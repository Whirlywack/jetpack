# MVP Task List (Atomic Breakdown with Dependencies)

## Phase 0: Project Setup & Foundation (Pre-Week 1 / Early Week 1)

* TASK-000A: Ensure Python 3 and pip are installed and accessible in PATH. [STATUS: TODO] [Notes: macOS typically includes Python 3. Verify with `python3 --version` and `pip3 --version`. If needed, install via python.org or `brew install python`.]
* TASK-000B: Install pipx (for managing Python CLI tools). [STATUS: TODO] [DEPENDS_ON: TASK-000A] [Notes: On macOS, use `brew install pipx`. Then run `pipx ensurepath` and restart your terminal.]
* TASK-000C: Install GDScript Toolkit (`gdtoolkit`) using pipx. [STATUS: TODO] [DEPENDS_ON: TASK-000B] [Notes: Run `pipx install "gdtoolkit==4.*"`. This provides `gdformat` and `gdlint`.]
* TASK-000D: Install and configure Windsurf (VS Code fork) as the code editor. [STATUS: TODO]
* TASK-000E: Install the 'Godot Tools' extension (or equivalent) in Windsurf. [STATUS: TODO] [DEPENDS_ON: TASK-000D]
* TASK-000F: Configure Windsurf to use `gdformat` (from `gdtoolkit`) for GDScript formatting (e.g., format on save). [STATUS: TODO] [DEPENDS_ON: TASK-000C, TASK-000E] [Notes: Check Godot Tools extension settings in Windsurf for GDScript formatting options; ensure it can find the `gdformat` installed by pipx.]
* TASK-000G: (Optional) Explore integrating `gdlint` (from `gdtoolkit`) into Windsurf or plan for command-line usage. [STATUS: TODO] [DEPENDS_ON: TASK-000C, TASK-000E]
* TASK-000H: (Recommended) Setup Git pre-commit hooks for `gdformat` and `gdlint`. [STATUS: TODO] [DEPENDS_ON: TASK-001, TASK-000C] [Notes: Use the 'pre-commit' framework. Create a `.pre-commit-config.yaml` to include gdformat --check and gdlint.]
* TASK-001: Initialize Git repository for the project. [STATUS: DONE]
* TASK-002: Create Godot 4.x project structure (folders for scenes, scripts, art, resources). [STATUS: DONE] [DEPENDS_ON: TASK-001]
* TASK-003: Configure basic Godot project settings (window size for portrait, application name). [STATUS: DONE] [DEPENDS_ON: TASK-002]
* TASK-004: Select and configure "Mobile" renderer in Project Settings. [STATUS: DONE] [DEPENDS_ON: TASK-003]
* TASK-005: Setup initial iOS export template in Godot (no need to fully build yet, just ensure template is present). [STATUS: DONE] [DEPENDS_ON: TASK-002]
* TASK-006: Create main.gd as the project entry point script. [STATUS: DONE] [DEPENDS_ON: TASK-002]
* TASK-007: Create MainMenu.tscn with a placeholder "Start Game" Button node. [STATUS: DONE] [DEPENDS_ON: TASK-002]
* TASK-008: Implement main.gd to load MainMenu.tscn on project start. [STATUS: TODO] [DEPENDS_ON: TASK-006, TASK-007]
* TASK-010: Create MainGameScene.tscn as the primary gameplay scene. [STATUS: DONE] [DEPENDS_ON: TASK-002]
* TASK-009: Implement "Start Game" button in MainMenu.tscn to load/change scene to MainGameScene.tscn. [STATUS: DONE] [DEPENDS_ON: TASK-007, TASK-010]
* TASK-011: Create placeholder Player.tscn (CharacterBody2D + CollisionShape2D + placeholder Sprite2D). [STATUS: DONE] [DEPENDS_ON: TASK-002]
* TASK-012: Create basic Player.gd script attached to Player.tscn. [STATUS: DONE] [DEPENDS_ON: TASK-011]

## Phase 1: Core Player Movement and Environment (Week 1 Focus)

### Continuous Movement and Ground

* TASK-101: Implement constant horizontal forward velocity for Player in Player.gd. [STATUS: TODO] [DEPENDS_ON: TASK-012]
* TASK-102: Add placeholder Ground.tscn (StaticBody2D + CollisionShape2D + placeholder Sprite2D). [STATUS: DONE] [DEPENDS_ON: TASK-002]
* TASK-014: Add a placeholder ground (e.g., a static platform) to MainGameScene.tscn so the player has something to stand on. [STATUS: DONE] [DEPENDS_ON: TASK-010, TASK-102]
* TASK-103: Instance Ground.tscn in MainGameScene.tscn for player to run on. [STATUS: DONE] [DEPENDS_ON: TASK-010, TASK-102] [Notes: Enhanced with infinite ground system]
* TASK-104: Implement basic gravity effect on Player in Player.gd. [STATUS: DONE] [DEPENDS_ON: TASK-012]
* TASK-105: Ensure Player collides and stays on top of Ground.tscn. [STATUS: DONE] [DEPENDS_ON: TASK-101, TASK-103, TASK-104]

### Jetpack Jump and Energy (Core Feel)

* TASK-106: Add max_energy and current_energy variables to Player.gd. [STATUS: TODO] [DEPENDS_ON: TASK-012]
* TASK-107: Add energy_cost_per_jump variable to Player.gd. [STATUS: TODO] [DEPENDS_ON: TASK-012]
* TASK-108: Implement input handling (e.g., Input.is_action_just_pressed("ui_accept")) for a single jump/jetpack boost in Player.gd. [STATUS: TODO] [DEPENDS_ON: TASK-012]
* TASK-109: Implement upward velocity application for jetpack boost in Player.gd. [STATUS: TODO] [DEPENDS_ON: TASK-105, TASK-108]
* TASK-110: Implement energy deduction from current_energy upon jetpack boost. [STATUS: TODO] [DEPENDS_ON: TASK-106, TASK-107, TASK-109]
* TASK-111: Prevent jetpack boost if current_energy < energy_cost_per_jump. [STATUS: TODO] [DEPENDS_ON: TASK-110]
* TASK-112: Implement logic for up to 3 mid-air jetpack boosts (e.g., jumps_made_in_air counter, reset on ground). [STATUS: TODO] [DEPENDS_ON: TASK-105, TASK-111]
* TASK-113: Add passive_energy_recharge_rate variable to Player.gd. [STATUS: TODO] [DEPENDS_ON: TASK-012]
* TASK-114: Implement passive current_energy regeneration over time (e.g., in_physics_process), capped at max_energy. [STATUS: TODO] [DEPENDS_ON: TASK-106, TASK-113]

### Basic Obstacles and Collision Feedback

* TASK-115: Create placeholder StaticObstacle.tscn (StaticBody2D + CollisionShape2D + placeholder Sprite2D). [STATUS: TODO] [DEPENDS_ON: TASK-002]
* TASK-116: Manually place a StaticObstacle.tscn instance in MainGameScene.tscn for testing collision. [STATUS: TODO] [DEPENDS_ON: TASK-010, TASK-115]
* TASK-117: Implement Player death logic (e.g., queue_free() or sets is_dead flag) upon collision with StaticObstacle.tscn. (No game restart yet). [STATUS: TODO] [DEPENDS_ON: TASK-105, TASK-116]
* TASK-118: Implement basic screen flash/shake (placeholder) upon Player collision with StaticObstacle.tscn. [STATUS: TODO] [DEPENDS_ON: TASK-117]

### Basic Camera and Scrolling

* TASK-119: Add Camera2D node as a child of Player.tscn. [STATUS: DONE] [DEPENDS_ON: TASK-011]
* TASK-120: Configure Camera2D to keep player roughly 30-40% from left edge in portrait view. [STATUS: DONE] [DEPENDS_ON: TASK-119]
* TASK-121: Implement basic infinite scrolling background (e.g., two repeating placeholder Sprite2Ds moving left). [STATUS: DONE] [DEPENDS_ON: TASK-010, TASK-119]

## Phase 2: Shooting and Basic Combat (Week 2 Focus)

### Basic Weapon and Bullet

* TASK-201: Create BaseBullet.tscn (Area2D + CollisionShape2D + placeholder Sprite2D) and BaseBullet.gd. [STATUS: TODO] [DEPENDS_ON: TASK-002]
* TASK-202: Implement forward movement for BaseBullet.gd at a fixed speed. [STATUS: TODO] [DEPENDS_ON: TASK-201]
* TASK-203: Implement BaseBullet.gd despawn when off-screen. [STATUS: TODO] [DEPENDS_ON: TASK-202]
* TASK-204: Create BasicBlaster.tscn (Node2D for weapon logic) and BasicBlaster.gd. [STATUS: TODO] [DEPENDS_ON: TASK-002]
* TASK-205: Add Marker2D ("Muzzle") to Player.tscn where bullets will spawn. [STATUS: TODO] [DEPENDS_ON: TASK-011]
* TASK-206: Implement logic in BasicBlaster.gd to instance BaseBullet.tscn at Muzzle position. [STATUS: TODO] [DEPENDS_ON: TASK-201, TASK-204, TASK-205]
* TASK-207: In Player.gd, implement input handling (e.g., Input.is_action_pressed("shoot")) to trigger firing. [STATUS: TODO] [DEPENDS_ON: TASK-012]
* TASK-208: Connect Player shoot input to BasicBlaster.gd to fire bullets. [STATUS: TODO] [DEPENDS_ON: TASK-206, TASK-207]
* TASK-209: Implement basic fire rate/cooldown for BasicBlaster.gd using a Timer node. [STATUS: TODO] [DEPENDS_ON: TASK-204]

### Basic Enemy and Interaction

* TASK-210: Create placeholder StaticEnemy.tscn (Area2D + CollisionShape2D + placeholder Sprite2D) and StaticEnemy.gd. [STATUS: TODO] [DEPENDS_ON: TASK-002]
* TASK-211: Add health variable to StaticEnemy.gd. [STATUS: TODO] [DEPENDS_ON: TASK-210]
* TASK-212: Implement take_damage(amount) function in StaticEnemy.gd. [STATUS: TODO] [DEPENDS_ON: TASK-211]
* TASK-213: In BaseBullet.gd, detect collision with nodes in "enemy" group. [STATUS: TODO] [DEPENDS_ON: TASK-201, TASK-210]
* TASK-214: Upon bullet-enemy collision, call take_damage() on enemy and queue_free() the bullet. [STATUS: TODO] [DEPENDS_ON: TASK-212, TASK-213]
* TASK-215: In StaticEnemy.gd, queue_free() enemy when health <= 0. [STATUS: TODO] [DEPENDS_ON: TASK-212]
* TASK-216: Manually place a StaticEnemy.tscn instance in MainGameScene.tscn for shooting tests. [STATUS: TODO] [DEPENDS_ON: TASK-010, TASK-210, TASK-208] (Need player shooting to test)

### Energy Pickups from Enemies

* TASK-217: Create EnergyOrb_Placeholder.tscn (Area2D + CollisionShape2D + placeholder Sprite2D) and EnergyOrb.gd. [STATUS: TODO] [DEPENDS_ON: TASK-002]
* TASK-218: In EnergyOrb.gd, define an energy_value. [STATUS: TODO] [DEPENDS_ON: TASK-217]
* TASK-219: Implement StaticEnemy.gd to have a chance (e.g., 30%) of instancing EnergyOrb_Placeholder.tscn at its position upon death. [STATUS: TODO] [DEPENDS_ON: TASK-215, TASK-217]
* TASK-220: In Player.gd, detect collision with nodes in "energy_orb" group. [STATUS: TODO] [DEPENDS_ON: TASK-012, TASK-217]
* TASK-221: Upon Player collision with EnergyOrb_Placeholder.tscn, call add_energy(orb.energy_value) on Player and queue_free() the orb. [STATUS: TODO] [DEPENDS_ON: TASK-106, TASK-218, TASK-220]

## Phase 3: Level Flow, UI and Basic Game State (Week 3 Focus)

### HUD Elements (Placeholders)

* TASK-301: Create HUD.tscn (Control node root). [STATUS: TODO] [DEPENDS_ON: TASK-002]
* TASK-302: Add TextureProgressBar to HUD.tscn for Energy Bar. [STATUS: TODO] [DEPENDS_ON: TASK-301]
* TASK-303: Connect Player.gd energy_changed signal to HUD Energy Bar. [STATUS: TODO] [DEPENDS_ON: TASK-106, TASK-302] (Player needs energy vars and signal)
* TASK-305: Create GameManager.gd (Autoload/Singleton). [STATUS: TODO] [DEPENDS_ON: TASK-002]
* TASK-306: Implement current_score and high_score variables in GameManager.gd. [STATUS: TODO] [DEPENDS_ON: TASK-305]
* TASK-304: Add Label to HUD.tscn for Score. [STATUS: TODO] [DEPENDS_ON: TASK-301]
* TASK-307: Implement add_score(value) function in GameManager.gd. Call this from StaticEnemy.gd upon death. [STATUS: TODO] [DEPENDS_ON: TASK-215, TASK-306]
* TASK-308: Connect GameManager.gd score updates to HUD Score Label. [STATUS: TODO] [DEPENDS_ON: TASK-304, TASK-307]
* TASK-309: Instance HUD.tscn within MainGameScene.tscn (likely on a CanvasLayer). [STATUS: TODO] [DEPENDS_ON: TASK-010, TASK-301]

### Basic Game State and Restart

* TASK-310: Implement game_over() function in GameManager.gd. [STATUS: TODO] [DEPENDS_ON: TASK-305]
* TASK-311: Call GameManager.game_over() from Player.gd when player dies. (Player is_dead flag). [STATUS: TODO] [DEPENDS_ON: TASK-117, TASK-310]
* TASK-312: On game_over(), update high_score in GameManager.gd if current_score is higher. [STATUS: TODO] [DEPENDS_ON: TASK-306, TASK-310]
* TASK-313: Implement restart_game() function in GameManager.gd that reloads MainGameScene.tscn and resets current_score. [STATUS: TODO] [DEPENDS_ON: TASK-010, TASK-306, TASK-310]
* TASK-314: Display a simple "Game Over - Tap to Restart" Label on HUD (or separate game over screen/layer ) upon game over. [STATUS: TODO] [DEPENDS_ON: TASK-301, TASK-310]
* TASK-315: Handle input to call restart_game() from game over state. [STATUS: TODO] [DEPENDS_ON: TASK-313, TASK-314]

### Level Spawning (Very Basic) and Distance Tracking

* TASK-316: Create LevelManager.gd script (can be on a Node in MainGameScene.tscn for now). [STATUS: TODO] [DEPENDS_ON: TASK-010]
* TASK-317: Implement logic in LevelManager.gd or Player.gd to track total horizontal distance scrolled by player. [STATUS: TODO] [DEPENDS_ON: TASK-101, TASK-316]

* TASK-318: In LevelManager.gd, implement timed spawning of one type of StaticObstacle.tscn at a fixed Y position off-screen right. [STATUS: TODO] [DEPENDS_ON: TASK-115, TASK-316]
* TASK-319: In LevelManager.gd, implement timed spawning of one type of StaticEnemy.tscn at a fixed Y position off-screen right. [STATUS: TODO] [DEPENDS_ON: TASK-210, TASK-316]

### Progress Bar and Boss Stub

* TASK-320: Add TextureProgressBar to HUD.tscn for "Distance to Boss". Define a target_distance_for_boss. [STATUS: TODO] [DEPENDS_ON: TASK-301]
* TASK-321: Update Distance to Boss bar based on distance_scrolled / target_distance_for_boss. [STATUS: TODO] [DEPENDS_ON: TASK-317, TASK-320]
* TASK-322: Create placeholder BossStub.tscn (Area2D + placeholder Sprite2D) and BossStub.gd. (No logic yet). [STATUS: TODO] [DEPENDS_ON: TASK-002]
* TASK-323: When progress bar full, LevelManager.gd instances BossStub.tscn (appears on screen right). (No fight yet). [STATUS: TODO] [DEPENDS_ON: TASK-316, TASK-321, TASK-322]

## Phase 4: Weapon Variety, Refined UI, Boss Mechanics and iOS Build (Week 4 Focus)

### Second Weapon Type (e.g., Spread Shot)

* TASK-401: Design concept for Spread Shot (SpreadShot.tscn, SpreadShot.gd inheriting/reusing BaseWeapon principles). [STATUS: TODO] [DEPENDS_ON: TASK-204] (Base weapon principles)
* TASK-402: Implement SpreadShot.gd to fire 3 bullets at slight angle offsets. [STATUS: TODO] [DEPENDS_ON: TASK-201, TASK-401] (Needs bullet, and its own scene/script)
* TASK-403: (Placeholder) Allow Player to switch to Spread Shot (e.g., debug key press). [STATUS: TODO] [DEPENDS_ON: TASK-012, TASK-208, TASK-402] (Player needs to equip/use it)

### Destructible Obstacles and Drops

* TASK-404: Create DestructibleObstacle.tscn (Area2D + CollisionShape2D + Sprite2D) and DestructibleObstacle.gd. [STATUS: TODO] [DEPENDS_ON: TASK-002]
* TASK-405: Implement health and take_damage() in DestructibleObstacle.gd. [STATUS: TODO] [DEPENDS_ON: TASK-404]
* TASK-406: Bullets damage DestructibleObstacle.tscn. Dies when health <= 0. [STATUS: TODO] [DEPENDS_ON: TASK-201, TASK-405] (Bullets need to interact)
* TASK-407: Implement DestructibleObstacle.gd to have a chance of instancing an EnergyOrb_Placeholder.tscn upon death. [STATUS: TODO] [DEPENDS_ON: TASK-217, TASK-405]
* TASK-408: LevelManager.gd spawns DestructibleObstacle.tscn instances. [STATUS: TODO] [DEPENDS_ON: TASK-316, TASK-404]

### Basic Boss Mechanics (BossStub -> Actual Boss)

* TASK-409: Add health to BossStub.gd and take_damage() function. Add score_value. [STATUS: TODO] [DEPENDS_ON: TASK-322]
* TASK-410: Player bullets can damage BossStub. [STATUS: TODO] [DEPENDS_ON: TASK-208, TASK-409] (Player shooting needs to interact)
* TASK-411: Create BossProjectile.tscn (similar to BaseBullet.tscn). [STATUS: TODO] [DEPENDS_ON: TASK-201]
* TASK-412: Implement BossStub.gd to fire BossProjectile.tscn periodically towards player's general area. [STATUS: TODO] [DEPENDS_ON: TASK-322, TASK-409, TASK-411]
* TASK-413: Player dies on collision with BossProjectile.tscn. [STATUS: TODO] [DEPENDS_ON: TASK-117, TASK-412] (Player death logic needs to handle this)
* TASK-414: When BossStub health <= 0, call add_score() in GameManager.gd, trigger "Boss Defeated" state. [STATUS: TODO] [DEPENDS_ON: TASK-307, TASK-310, TASK-409] (GameManager needs score, game over states)

### Perk System (Minimal Viable)

* TASK-415: Create PerkData.tres (Resource) template (e.g., perk_name, effect_description). [STATUS: TODO] [DEPENDS_ON: TASK-002] (Resource file needs project)
* TASK-416: Create 2-3 sample PerkData.tres files (e.g., "FasterShot: +10% fire rate", "ExtraEnergy: +20 max energy"). [STATUS: TODO] [DEPENDS_ON: TASK-415]
* TASK-417: Create PerkSelectionScreen.tscn (Control node with buttons/labels for perk choices). [STATUS: TODO] [DEPENDS_ON: TASK-301] (Builds on HUD/UI system)
* TASK-418: On "Boss Defeated", GameManager.gd shows PerkSelectionScreen.tscn populated with 2 sample perk names/descriptions. [STATUS: TODO] [DEPENDS_ON: TASK-305, TASK-414, TASK-416, TASK-417]
* TASK-419: Implement player tap on a perk choice in PerkSelectionScreen.tscn. [STATUS: TODO] [DEPENDS_ON: TASK-417]
* TASK-420: Basic application of one chosen perk effect on Player.gd (e.g., modify max_energy variable or weapon fire rate timer). Hides perk screen and continues to "next level" (placeholder, e.g., reset progress bar for "World 2"). [STATUS: TODO] [DEPENDS_ON: TASK-012, TASK-106, TASK-209, TASK-416, TASK-419] (Player script, relevant player/weapon stats, perk data, selection mechanism)

### High Score Saving and Display

* TASK-421: Implement saving GameManager.high_score to a local file (user://high_score.dat) on game_over(). [STATUS: TODO] [DEPENDS_ON: TASK-306, TASK-312]
* TASK-422: Implement loading high_score from user://high_score.dat in GameManager.gd when game starts. [STATUS: TODO] [DEPENDS_ON: TASK-306, TASK-421]
* TASK-423: Add a Label to HUD.tscn (or MainMenu.tscn) to display the loaded high score. [STATUS: TODO] [DEPENDS_ON: TASK-301, TASK-007, TASK-422]

### iOS Export and TestFlight QA

* TASK-424: Finalize iOS export settings in Godot (Bundle ID, icons, launch screens – using placeholders). [STATUS: TODO] [DEPENDS_ON: TASK-005] (All core MVP features should be near complete ideally)
* TASK-425: Perform first successful Xcode build of the project for an iOS device/simulator. [STATUS: TODO] [DEPENDS_ON: TASK-424]
* TASK-426: Resolve any immediate build errors or basic runtime crashes on iOS. [STATUS: TODO] [DEPENDS_ON: TASK-425]
* TASK-427: Setup App on App Store Connect for TestFlight. [STATUS: TODO] [DEPENDS_ON: TASK-001] (Needs an Apple Dev account, but project-wise assumes a buildable state)
* TASK-428: Upload first build to TestFlight. [STATUS: TODO] [DEPENDS_ON: TASK-426, TASK-427]
* TASK-429: Perform basic QA playthrough of core loop on an iPhone via TestFlight. Document 3-5 critical bugs or playability issues. [STATUS: TODO] [DEPENDS_ON: TASK-428]

## SFX/Juice (Sprinkled or Final Pass within MVP)

* TASK-501: Add placeholder sound effect for Player jump/jetpack boost using AudioStreamPlayer. [STATUS: TODO] [DEPENDS_ON: TASK-109]
* TASK-502: Add placeholder sound effect for Player shooting. [STATUS: TODO] [DEPENDS_ON: TASK-208]
* TASK-503: Add placeholder sound effect for Bullet impact / Enemy hit. [STATUS: TODO] [DEPENDS_ON: TASK-214]
* TASK-504: Add placeholder sound effect for Enemy death. [STATUS: TODO] [DEPENDS_ON: TASK-215]
* TASK-505: Add placeholder sound effect for Player death (linked with TASK-118 visual feedback). [STATUS: TODO] [DEPENDS_ON: TASK-117]
