# Project Requirements Document: [Your Game's Tentative Title - e.g., "Jetpack Havoc"] v1.0 - Section 1, 2, 3, 5

## 1. Introduction & Purpose

Project Name: [Your Game's Tentative Title - e.g., "Jetpack Havoc"]
Document Version: 1.0
Date: [Current Date]
Purpose: This document outlines the high-level requirements, scope, and foundational technical architecture for the "Jetpack Havoc" iOS mobile game. It serves as a guiding reference for the development of the Minimum Viable Product (MVP) and provides a basis for future enhancements.
Project Goal: To develop an engaging and replayable 2D hybrid endless-runner game for iOS, blending precision jetpack platforming, obstacle avoidance, and side-scrolling shooter mechanics, targeting casual mobile gamers.

## 2. Product Overview

Description: "Jetpack Havoc" is a fast-paced, sci-fi themed pixel art game where players control a jetpack-equipped hero. The hero constantly advances horizontally, navigating static and destructible obstacles while shooting ground and flying enemies. Gameplay involves managing a depletable/rechargeable energy resource for jetpack boosts. Each "World" (a series of progressively challenging stages) culminates in a dynamic boss fight. A core replayability mechanic involves earning randomized, stackable perks after each boss defeat, influencing subsequent gameplay within that run.
Target Audience: Casual mobile gamers (primarily Millennials & older Gen Z) on iOS devices who enjoy quick, skill-based sessions.
Platform: iOS (iPhones). Game designed for portrait orientation.

Key Features (MVP Scope):

* Continuous forward player movement with energy-managed jetpack jumps (up to 3 per airtime).
* Hold-to-shoot auto-fire mechanic with 1-2 initial weapon types.
* Static and basic destructible obstacles.
* Ground and flying enemy types (non-attacking for MVP).
* Fixed-length stages organized into "Worlds," each ending with a unique boss.
* "Elite" enemy encounters at the end of certain sub-stages.
* Randomized perk selection system after boss defeats.
* Basic HUD (Energy, Progress to Boss, Score).
* Portrait mode UI/UX optimized for iPhones.

## 3. High-Level Functional Requirements (MVP)

| ID    | Requirement                  | Description                                                                                                                    | Priority |
| :---- | :--------------------------- | :----------------------------------------------------------------------------------------------------------------------------- | :------- |
| FR1   | Player Control & Movement    | Implement continuous auto-scroll, ground running, and multi-boost jetpack with energy consumption/recharge.                  | High     |
| FR2   | Shooting Mechanics           | Implement right-hand hold-to-shoot auto-fire for 1-2 distinct weapon types. Bullets interact with enemies/destructibles.       | High     |
| FR3   | Obstacle System              | Implement static obstacles (collision results in player death) and basic destructible obstacles (breakable by shooting).         | High     |
| FR4   | Enemy System                 | Implement basic ground and flying enemy types with simple movement patterns. Enemies are defeated by player projectiles.      | High     |
| FR5   | Level & Progression Structure| Implement a system of Worlds composed of sequential sub-stages. Include "Distance to Boss" indicator. "Elite" enemies at sub-stage ends. | High     |
| FR6   | Boss Encounters              | Implement unique boss entities at the end of each World, featuring distinct attack patterns. Player continues core gameplay during fight. | High     |
| FR7   | Randomized Perk System       | After boss defeat, present player with 2-3 random perk choices. Selected perk modifies player/weapon attributes for the current run. | High     |
| FR8   | User Interface (UI)          | Implement portrait-mode HUD displaying energy, progress, score. Implement perk selection screen.                              | High     |
| FR9   | Game State Management        | Manage game states (main menu, gameplay, game over, pause (post-MVP)). Handle run restarts upon player death.               | High     |
| FR10  | Basic Audio-Visual Feedback ("Juice") | Implement placeholder SFX for core actions and simple particle effects for impacts.                                     | Medium   |

## 5. Non-Functional Requirements (MVP)

| ID    | Requirement                  | Description                                                                                                |
| :---- | :--------------------------- | :--------------------------------------------------------------------------------------------------------- |
| NFR1  | Performance                  | Maintain smooth framerate (target 60 FPS, minimum 30 FPS) on supported iOS devices during typical gameplay. |
| NFR2  | Usability                    | Intuitive controls (left-tap/hold jump, right-hold shoot). Clear UI and gameplay feedback.                 |
| NFR3  | Stability                    | MVP should be free of critical bugs or crashes during core gameplay loop.                                   |
| NFR4  | Maintainability/Scalability  | Codebase and project structure should allow for efficient addition of post-MVP features as outlined in design docs. |
| NFR5  | Platform Compatibility       | Game functions correctly on target iOS versions (e.g., iOS 14+ or as defined).                            |

## 6. Assumptions & Dependencies

* Development will use Godot Engine 4.x.
* Access to an Apple Developer account for TestFlight distribution and eventual App Store submission.
* Placeholder assets will be used for initial mechanics prototyping.
* The 4-week prototype roadmap (as previously defined) will guide initial development sprints.

## Design Document v0.1 - Section 1, 4, 5

### 1. Overview

Elevator Pitch: A hybrid endless-runner for iOS where a jetpack-equipped hero constantly advances through static and destructible obstacles, can double/triple-jump by draining and recharging energy, and must shoot ground and flying enemies. Each "World" culminates in a dynamic boss fight at the end of a series of fixed-length stages, with players earning randomized stackable perks to enhance subsequent gameplay within that run.
Core Hook: Seamlessly blend Flappy-Bird-style precision hopping (energy-managed jetpack), Chrome-Dino-style obstacle avoidance, and engaging side-scrolling space-shooter combat into one fluid, replayable experience.
Genre & Tone: 2D pixel art runner with a "cute-but-powerful" sci-fi flavor, fast-paced action, and an emphasis on fun and skill-based challenges.
Target Audience: Casual mobile gamers (primarily Millennials & older Gen Z) who enjoy quick, engaging sessions with skill-based challenges and satisfying progression.

### 4. Core Loop (MVP)

Start Run: Player begins at World 1, Stage 1.1.
Engage: Navigate obstacles, shoot enemies, manage jetpack energy through sub-stages.
Challenge: Defeat "elite" enemies at sub-stage conclusions.
Climax: Reach and defeat the World Boss.
Reward & Empower: Select a random perk.
Progress: Advance to the next World with acquired perks.
Repeat/End: Loop continues until player death (restart run, losing perks) or eventual "game completion" (defeating all planned Worlds for MVP).

### 5. Key Replayability Drivers (MVP)

* Randomized Perk System: Primary driver, creating unique runs and build opportunities.
* Short Sub-Stage/Session Length: Encourages "one more try" engagement.
* Skill Mastery: Learning enemy patterns, mastering jetpack control, optimizing energy.
* Basic Score Chasing.
