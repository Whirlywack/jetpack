# MVP Technical Design and Architecture

* Easy Balancing: Tweak numbers in .tres files without recompiling.
* Content Creation: Game designers can create new enemies/weapons/perks by creating new resource files and potentially linking art assets.
* Less Hardcoding: Scripts load data from these resources.
* **Implementation:** Player/Weapon/Enemy scripts would have an export var data: WeaponData (or similar) slot. In _ready(), they'd configure themselves based on this data.

## UI System

* **Main HUD Scene (HUD.tscn):**
  * Uses Control nodes (Label, TextureProgressBar, HBoxContainer, VBoxContainer).
  * Connects to signals from Player (e.g., energy_changed) or LevelManager to update its display.
* **Perk Selection Screen (PerkScreen.tscn):** Dynamically populated with perk choices by PerkManager.

## Strategic Technical Approaches for Your MVP (and Beyond)

* Scene Composition & Instancing: Godot's scene system is its superpower. Use it wisely.
* Single Responsibility Principle (SRP) for Scenes & Scripts: Each scene and script should do one thing well.
* Loose Coupling & High Cohesion: Components should interact through well-defined interfaces (signals, function calls) without needing to know the intricate details of each other.
* Data-Driven Design where Appropriate: Separate data from logic to make balancing and adding new content easier.
* Clear Project Structure: A well-organized file system is crucial as the project grows.
* Abstraction & Interfaces (even in GDScript): While GDScript isn't strictly interface-based, think in terms of contracts between objects.
* Testability (Unit & Integration): Design components to be testable in isolation or in small groups.

## Implementation Details

### 1. Player Character (Player.tscn)

* Node Structure: A CharacterBody2D (or RigidBody2D if you prefer full physics control, but CharacterBody2D is often better for precise player control) as the root.

  * Sprite2D / AnimatedSprite2D for visuals.
  * CollisionShape2D for physics.
  * Node2D as a "GunMount" point for instancing weapons.
  * Timer nodes for things like invincibility frames (post-hit), attack cooldowns (if not handled by weapon).
* Player.gd Script:
  * State Machine: Implement a simple state machine (e.g., IDLE, RUNNING, JUMPING, JETPACKING, SHOOTING, HURT, DEAD). This keeps movement and action logic clean and expandable. enum for states.
  * Movement Variables: speed, jump_force, jetpack_force, gravity.
  * Energy Management: current_energy, max_energy, energy_recharge_rate. Expose functions like use_energy(amount), add_energy(amount).
  * Shooting Logic: Handles input for shooting, tells the equipped weapon to fire.
  * Signals: energy_changed(current, max), health_changed(current, max), player_died, perk_acquired(perk_data).
* Scalability: New abilities (dash, shield) can be added as new states or managed by separate component nodes attached to the player.

### 2. Weapon System

* Base Weapon Scene (BaseWeapon.tscn -> BaseWeapon.gd):
  * A Node2D root.
  * Sprite2D for the weapon visual (if distinct from player).
  * Marker2D for bullet spawn point ("Muzzle").
  * Timer for fire rate.
* BaseWeapon.gd (Abstract Class concept):
  * fire_rate, bullet_scene, damage (or handled by bullet).
  * _fire() method (could be virtual or just a standard to override).
  * can_fire() checks.
* Specific Weapon Scenes (Blaster.tscn, SpreadShot.tscn):
  * Inherit from BaseWeapon.tscn.
  * Their scripts (Blaster.gd, SpreadShot.gd) extend BaseWeapon.gd.
  * Override _fire() to implement specific firing logic (e.g., spread shot instances multiple bullets).
* Player equips weapon: Player script holds a reference to the currently equipped weapon scene instance (child of "GunMount").
* Scalability: Adding new weapons is just creating a new scene inheriting from BaseWeapon and writing its specific _fire() logic. Perks affecting weapons can call methods on the BaseWeapon script or modify its properties.

### 3. Bullet System

* Base Bullet Scene (BaseBullet.tscn -> BaseBullet.gd):

  * An Area2D (for hit detection without complex physics) or RigidBody2D (if you want bullets affected by gravity or bouncing).
  * Sprite2D / AnimatedSprite2D.
  * CollisionShape2D.
* BaseBullet.gd:
  * speed, damage, direction, lifetime (or despawn on screen exit).
  * Handles movement (_physics_process).
  * Handles collision detection (e.g., body_entered signal for Area2D). On collision, apply damage, play effect, queue_free().
* Specific Bullet Types (if needed later): Homing missile, explosive shot, etc., would inherit/extend.
* Scalability: New bullet behaviors (piercing, exploding) can be added by extending BaseBullet.gd or by adding component nodes to bullet scenes.

### 4. Enemy System

* Base Enemy Scene (BaseEnemy.tscn -> BaseEnemy.gd):

  * CharacterBody2D or Area2D (if purely for collision with player/bullets, no complex movement).
  * Sprite2D / AnimatedSprite2D.
  * CollisionShape2D.
* BaseEnemy.gd:
  * health, movement_speed (if applicable), score_value, energy_drop_chance.
  * take_damage(amount) method.
  * _die() method (plays death animation/SFX, drops pickups, emits signal enemy_died(score_value)).
  * Basic AI/movement logic (e.g., MOVE_STRAIGHT, STATIONARY).
* Specific Enemy Scenes (Drone.tscn, Turret.tscn):
  * Inherit from BaseEnemy.tscn.
  * Their scripts extend BaseEnemy.gd to implement specific behaviors or stats.
* Scalability: New enemy types are new scenes inheriting the base. More complex AI can be built into their specific scripts or by attaching dedicated AI behavior tree nodes.

### 5. Level Generation / Stage Management

* LevelManager.gd (Autoload/Singleton or a persistent node in your main game scene):

  * Manages loading/unloading of stages/worlds.
  * Tracks current world/stage, player progress (distance to boss).
  * Spawns enemies and obstacles. This is a critical part.
  * Option A (Simpler for MVP): Pre-designed "chunks" or full stage scenes. LevelManager instances them sequentially.
  * Option B (More Scalable for Endless): Procedural generation of level segments using tilemaps or by instancing pre-made "chunks" in a randomized or rule-based sequence.
* ObstacleSpawner.gd, EnemySpawner.gd (could be child nodes of LevelManager or separate components):
  * Responsible for instancing obstacles/enemies based on current stage difficulty, patterns, or timers.
  * Could read spawner data from Resource files (see #7).
* Scalability: Using data files or a more procedural approach for spawners allows easy addition of new patterns and balancing without recoding.

### 6. Perk System

* PerkManager.gd (Autoload/Singleton):

  * Holds a list of all available PerkData resources (see #7).
  * Presents perk choices to the player.
  * Tracks acquired perks for the current run.
* Perk.gd (script attached to Player or a "PerkHolder" node on Player):
  * The apply_perk(perk_data) method on the player or its components would modify relevant player/weapon stats.
  * For example, a "Faster Shooting" perk might reduce the fire_rate timer's wait_time on the equipped weapon. A "+MaxEnergy" perk would call a method on the player to increase max_energy.
* Scalability: New perks are new PerkData resources and potentially small new functions/logic in the relevant components (player, weapon) to handle their effects.

### 7. Data-Driven Design with Resources

* Godot's Resource type is incredibly powerful for this.

  * WeaponData.tres: damage, fire_rate, bullet_scene_path, icon_for_ui.
  * EnemyData.tres: health, speed, score, sprite_sheet_path, energy_drop_params.
  * PerkData.tres: id, name, description, icon, effect_type (enum: MODIFY_PLAYER_STAT, MODIFY_WEAPON_STAT), stat_to_modify (string), value (float/int), is_percentage (bool).
  * LevelChunkData.tres (for procedural generation): List of enemies/obstacles, layout info.
* Benefits:
  * Easy Balancing: Tweak numbers in .tres files without recompiling.
  * Content Creation: Game designers can create new enemies/weapons/perks by creating new resource files and potentially linking art assets.
  * Less Hardcoding: Scripts load data from these resources.

### UI System (Recap)

* Main HUD Scene (HUD.tscn):
  * Uses Control nodes (Label, TextureProgressBar, HBoxContainer, VBoxContainer).
  * Connects to signals from Player (e.g., energy_changed) or LevelManager to update its display.
* Perk Selection Screen (PerkScreen.tscn): Dynamically populated with perk choices by PerkManager.

* Theme: Use Godot's UI Theme resource to maintain a consistent look and feel. Easy to update visuals later.
* Scalability: New UI elements can be added to the HUD. Different screens (main menu, game over) are separate scenes.

### 9. Event Bus / Global Signals (Autoload Script)

* An Autoload script (e.g., GlobalEvents.gd) can define global signals for major game events:

  * signal game_started
  * signal game_over(score)
  * signal boss_defeated(boss_id)
  * signal perk_selected(perk_data)
* Various systems can emit these signals, and others can listen without direct dependencies. E.g., UI listens to game_over to show the game over screen.
* Caution: Don't overuse. Direct signals between closely related nodes are often better. Use global signals for truly global, system-spanning events.

### 10. Project Folder Structure

* res://

  * actors/
    * player/
      * Player.tscn
      * Player.gd
      * player_sprite.png
    * enemies/
      * BaseEnemy.tscn
      * BaseEnemy.gd
      * drone/
        * Drone.tscn
        * Drone.gd
  * weapons/
    * BaseWeapon.tscn
    * BaseWeapon.gd
    * bullets/
      * BaseBullet.tscn
      * BaseBullet.gd
    * blaster/
      * Blaster.tscn
      * Blaster.gd
  * levels/
    * World1/
      * Stage1_1.tscn
      * Stage1_Boss.tscn
    * level_management/
      * LevelManager.gd (if not autoload)
      * ObstacleSpawner.gd
  * ui/
    * HUD.tscn
    * HUD.gd
    * PerkScreen.tscn
    * MainMenu.tscn
    * fonts/
    * themes/
      * main_theme.tres
  * systems/
    * PerkManager.gd (if autoload)
    * GlobalEvents.gd (autoload)
  * resources/  <-* For .tres files
    * perks/
      * faster_shooting_perk.tres
    * enemies_data/
      * drone_data.tres
    * weapons_data/
  * art/
    * sprites/
    * backgrounds/
  * audio/
    * sfx/
    * music/
  * scripts/  <-* For general utility scripts not tied to specific scenes
  * main/
    * MainGameScene.tscn (where everything comes together)
    * main.gd (entry point, loads main menu or game scene)

### Refactoring During MVP for Scalability

* As you build the MVP, constantly ask:

  * "If I wanted to add 10 more of X (enemies, weapons, perks), how hard would it be with this current setup?"
  * "Is this script/scene doing too much?"
  * "Are these two components too tightly coupled?"
  * "Could this be made data-driven?"
  * "Is this code organized for easy navigation and maintenance?"

If you spot a bottleneck or an overly complex piece of code, don't be afraid to refactor early and often. The goal is to build a strong foundation. The 4-week MVP timeline is ambitious, so some of the more advanced data-driven aspects might be simplified initially (e.g., fewer distinct .tres files, more stats directly in scripts), but keeping the scene structure and signal-based communication clean is paramount.

This architectural thinking from the start will save you immense headaches when you want to add those "next features without a hiccup."

## Technical Stack

* Engine: Godot 4.x with GDScript.
* Rendering: "Mobile" rendering backend selected for iOS performance focus.

### Core Design Principles

* Scene Composition: Modular design leveraging Godot's scene instancing for player, enemies, weapons, bullets, obstacles, UI elements.
* Single Responsibility Principle: Scripts and scenes designed for specific, focused functionalities.
* Loose Coupling: Communication via signals (Godot's built-in, global event bus for system-wide events) and well-defined function calls.

### Key Architectural Components

* Player (Player.tscn, Player.gd): CharacterBody2D with state machine for movement/actions, energy management, weapon equipping, and perk application logic. Emits signals for state changes (e.g., energy_changed, player_died).
{{ ... }}
  * Bullet System (BaseBullet.tscn/.gd): Area2D for hit detection. Handles movement, collision, and applying damage.
  * Enemy System (BaseEnemy.tscn/.gd, specific enemy scenes): Hierarchical design. Base enemy handles health, damage intake, death. Specific enemies implement unique behaviors.
  * Level Management (LevelManager.gd * Autoload/Singleton): Manages stage loading, progression tracking, and dynamic spawning of enemies/obstacles (potentially from pre-designed chunks or procedural rules based on Resource data).

  * Perk System (PerkManager.gd * Autoload, PerkData.tres): PerkManager handles presentation of perks. Player script/components apply perk effects based on PerkData (Custom Resource type).
  * Data-Driven Design (Resource files * .tres): Utilize Godot Resource files for defining stats and properties of weapons, enemies, perks, and potentially level segments. This allows for easier balancing and content iteration.
  * UI System (HUD.tscn, etc.): Control node based scenes, driven by signals from gameplay systems. A UI Theme resource will be used for consistent styling.

* Global Event Bus (GlobalEvents.gd * Autoload): For broadcasting critical, system-wide game events (e.g., game_over, boss_defeated).
* iOS Specifics:
  * Design mindful of portrait aspect ratios, safe areas, and touch input ergonomics.
  * Regular on-device testing via Xcode and TestFlight.
  * Performance optimization considerations (e.g., object pooling for bullets, culling, etc.).
