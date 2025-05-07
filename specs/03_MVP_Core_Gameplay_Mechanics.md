# Design Document v0.1 - Section 2 & 3

## 2. Core Gameplay & Mechanics (MVP Focus)

### 2.1. Player & Movement

* **Orientation:** Portrait (9:16 aspect ratio).
* **Movement:** Continuous forward auto-scroll at a fixed (per-stage) speed. Player character positioned slightly off-center (~30-40% from the left edge) to maximize forward visibility.
* **Jetpack Jumps:** Left-hand tap/hold executes a jetpack boost. Up to 3 discrete boosts possible per airtime before needing to touch ground or exhaust energy. Each boost consumes energy.
* **Ground Movement:** Player can run on ground platforms.
* **Camera:** Primarily fixed perspective, slightly zoomed out to balance character detail with horizontal look-ahead distance. Potential for subtle dynamic zoom during boss encounters to be explored post-MVP.

### 2.2. Energy System

* **Energy Bar:** Visible HUD element. Drains with each jetpack boost.
* **Passive Recharge:** Energy recharges slowly over time.
* **Active Recharge:** Energy orbs/pickups dropped by enemies or found in levels for instant energy replenishment.

### 2.3. Shooting System

* **Controls:** Right-hand hold-to-shoot for continuous auto-fire.
* **Weapon Types (MVP):** Start with 1-2 distinct types (e.g., Basic Blaster, Spread Shot). Additional types are post-MVP.
* **Ammunition:** Unlimited for MVP.

### 2.4. Enemies & Obstacles

* **Static Obstacles:** Blocks, pillars, ceiling/floor hazards. Player dies on collision.
* **Destructible Obstacles:** Certain obstacles can be destroyed with sufficient firepower. May drop minor bonuses (energy, score). Visual cues (cracks) indicate destructibility.
* **Ground Enemies (MVP):** E.g., stationary turrets, simple bipedal bots.
* **Flying Enemies (MVP):** E.g., drones.
* **Enemy Behavior (MVP):** Enemies do not return fire. They follow simple patterns or are stationary.
* **"Elite" Enemies:** A stronger, unique enemy (not a full boss) encountered at the end of certain sub-stages as a mini-climax and skill check.

### 2.5. Level Structure & Progression

* **Worlds & Stages:** Game organized into "Worlds" (e.g., World 1, World 2). Each World consists of multiple "sub-stages" (e.g., 1.1, 1.2, 1.3).
* **Sub-Stage Length:** Designed for quick sessions (~1-2 minutes per sub-stage).
* **Progression:** Clearing all sub-stages in a World leads to a World Boss.
* **Speed Scaling:** Game speed may incrementally increase through sub-stages within a World. Speed resets/adjusts for new Worlds, which introduce new enemy types/challenges.
* **"Distance to Boss" Indicator:** Visible HUD element showing progress through the current World.
* **Checkpoints:** Player restarts the current sub-stage upon death (or potentially current "World" if earlier in MVP dev).

### 2.6. Boss Fights

* **Trigger:** Occur at the end of each "World."
* **Dynamics:** Player continues auto-scrolling and using core mechanics (jump, shoot, manage energy) while targeting the boss.
* **Boss Behavior:** Bosses have unique attack patterns (projectiles, lasers, etc.) and larger health pools.

### 2.7. Randomized Perk System

* **Trigger:** Awarded after successfully defeating a World Boss.
* **Mechanic:** Player chooses 1 perk from 2-3 randomly presented options.
* **Stacking & Scope:** Perks stack and apply for the remainder of the current "run" (until player death and restart from World 1.1, or game completion). Examples: faster shooting, increased energy regen, more powerful bullets, additional mid-air jump.
* **Caps:** Some perks may have caps on stacking to maintain balance (post-MVP consideration).

## 3. UI/UX (MVP Focus)

### 3.1. General

* **Orientation:** Portrait mode.
* **Layout Strategy:** Maximize clear play area. HUD elements placed at top/bottom peripheries.
* **Art Style:** Pixel art for all game elements and UI. "Cute-but-powerful" aesthetic.
* **Input Zones:** Left side of screen for jump (tap/hold), right side for shoot (hold). Thumbs should not obscure critical gameplay visibility.
* **Readability:** Clear visual hierarchy. Player, enemies, key obstacles, and projectiles should be easily distinguishable.

### 3.2. HUD Elements (MVP)

* **Energy Bar:** Clearly visible.
* **Progress Bar ("Distance to Boss"):** Tracks progress within the current World.
* **Lives/Health Indicator:** (If applicable for MVP - TBD based on one-hit-kill or health system).
* **Score Display:** Basic score tracking.
* **(Post-Boss) Perk Selection Screen:** Clear presentation of perk choices.

### 3.3. Game Feel ("Juice")

* **MVP:** Basic but clear sound effects for jump, shoot, enemy hit/death, player death. Simple particle effects for impacts. Screen shake for significant events (e.g., boss attacks, player death). Can be refined and expanded post-MVP.
