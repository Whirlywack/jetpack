# Jetpack Havoc Project - AI Agent Operational Guide

Welcome to the Jetpack Havoc project! This document is your guide to understanding our project structure, how to find information, and our collaborative workflow. Your primary goal is to assist in developing the MVP (Minimum Viable Product) based on the provided specifications and tasks.

## 1. Core Principle: Your Guiding Star - The Session Brief

**Crucial:** For every work session, your first and foremost point of reference is the file located at:

* `./.ai_context/session_brief.md`

This `session_brief.md` is dynamically updated by the human project manager before each session. It contains:

* The overall goal for the current session.
* The specific `TASK-ID(s)` you need to focus on.
* The current status of those tasks.
* Links or references to key files and specification sections relevant to the *current* work.
* Any known blockers or questions.
* Recently completed tasks for context.
* What's next after the current tasks.

**==> Always read and fully process the `./.ai_context/session_brief.md` at the beginning of any interaction or when instructed to start new work. <==**

## 2. Project Documentation Structure

Our project documentation is organized into three main areas:

### a. `./.ai_context/` (Your Immediate Operational Context)

This folder contains tools and information for your current work session.

* **`session_brief.md`**: (As described above) Your primary directive for the current session.
* **`prompts/`**: A subfolder containing reusable Markdown (`.md`) templates for common interactions. You will be directed to use these templates as needed. Examples include:
  * `code_generation_template.md`: For when you are asked to write code.
  * `code_review_checklist.md`: For when you are asked to review code.
  * `task_update_prompt.md`: For helping to formulate status updates for tasks.

### b. `./specs/` (Detailed MVP Specifications)

This folder holds all the detailed design and planning documents for the Jetpack Havoc MVP.

* **`01_MVP_Product_Requirements.md`**: Defines the overall product, its purpose, target audience, and high-level functional requirements (what the game should do).
* **`02_MVP_Technical_Design_and_Architecture.md`**: **This is a critical document for you.** It details:
  * Core Godot development principles (SRP, Loose Coupling, etc.).
  * The planned technical architecture for key game systems (Player, Weapon, Enemy, UI, etc.).
  * Specific Godot node structures, script logic outlines, and class designs.
  * The expected project folder structure for game assets and scripts.
  * *You should refer to this document extensively when implementing any code.*
* **`03_MVP_Core_Gameplay_Mechanics.md`**: Describes the detailed gameplay loops, player abilities (jetpack, shooting), energy system, enemy behaviors, level structure, boss fights, perk system, and UI/UX details for the MVP.
* **`04_MVP_Task_List.md`**: The master list of all development tasks required to build the MVP.
  * Each task has a unique `TASK-ID` (e.g., `TASK-001`).
  * Each task includes a `[STATUS: ...]` field (e.g., TODO, IN PROGRESS, DONE, BLOCKED).
  * Each task may include a `[DEPENDS_ON: TASK-XXX, ...]` field, listing prerequisite tasks that must be completed first.

### c. `./ai_docs/` (General Project Knowledge & Long-Term Vision)

This folder contains broader, more stable information. (Note: Ensure this path matches your actual folder name, e.g., `ai-docs` if you used that).

* **`Project_Long_Term_Vision.md`**: Outlines features, ideas, and scope beyond the current MVP. This provides context for extensibility but is **not for immediate implementation** unless a specific MVP task directs you otherwise.

## 3. Your Workflow

### a. Starting a Session

* Always begin by reading and understanding the current `./.ai_context/session_brief.md`.

### b. Understanding Your Assigned Task(s)

* The `session_brief.md` will specify one or more `TASK-ID(s)` from `./specs/04_MVP_Task_List.md`.
* Locate these tasks in `04_MVP_Task_List.md` to understand their description and any listed dependencies.
* The `session_brief.md` (and the task description itself) will guide you to the relevant detailed information in `01_MVP_Product_Requirements.md`, `02_MVP_Technical_Design_and_Architecture.md`, and `03_MVP_Core_Gameplay_Mechanics.md`.

### c. Code Quality Standards & Tools (GDFormat & GDLint)

This project uses **GDScript Toolkit (`gdtoolkit`)** to maintain code quality and consistency. This includes:

* **`gdformat` for Code Formatting:**
  * Code you generate should ideally be well-formatted according to standard Godot conventions.
  * The human developer has `gdformat` integrated (e.g., "format on save" in their editor and potentially pre-commit hooks). This means minor formatting adjustments to your code might occur automatically after you provide it. Please ensure your generated code structure is clear and robust.
* **`gdlint` for Code Linting:**
  * `gdlint` is used to check for adherence to GDScript style guidelines, identify potential errors, and enforce best practices (e.g., via pre-commit hooks or periodic checks by the human developer).
  * **Your Goal:** Aim to produce GDScript code that is clean, readable, follows the official Godot Style Guide, and would pass `gdlint` checks. Refer to architectural patterns in `../../specs/02_MVP_Technical_Design_and_Architecture.md` (accessible via `../specs/` from the project root if this README is in the root, or adjust path if AI is "thinking" from a different context).
  * **Feedback Loop:** If code you provide fails `gdlint` checks (e.g., caught by a pre-commit hook), the human developer will provide you with the specific error messages. You will then be expected to help revise the code to address these linting issues.

### d. Implementing Code

* Adhere strictly to the architectural guidelines, node structures, and script designs specified in `specs/02_MVP_Technical_Design_and_Architecture.md`.
* **Strive to write code that meets the quality standards checked by `gdlint` (see "Code Quality Standards & Tools" above).**
* Place all new scripts and scenes within the project folder structure defined in `specs/02_MVP_Technical_Design_and_Architecture.md`.
* When instructed to generate code, you may be asked to use the `./.ai_context/prompts/code_generation_template.md`. Follow its structure for providing your output.

### e. Code Reviews

* If asked to review code, use the `./.ai_context/prompts/code_review_checklist.md` as your comprehensive guide.
* **Part of your review should also consider if the code would likely pass `gdlint` checks based on common style and best practices.**

### f. Task Dependencies

* The `session_brief.md` should only assign tasks whose prerequisites (as listed in the `[DEPENDS_ON: ...]` field in `specs/04_MVP_Task_List.md`) have been met (i.e., their status is `DONE`).
* If you are assigned a task and you believe, based on your understanding or the documented dependencies, that a prerequisite is not met, please **immediately raise this as a concern or potential blocker.**

### g. Updating Task Status

* When you believe you have completed the work for an assigned task (or a significant sub-part), clearly communicate this.
* You may be asked to help formulate the status update string for `specs/04_MVP_Task_List.md` by using the template in `./.ai_context/prompts/task_update_prompt.md`.
* The human project manager will typically make the final update to the `04_MVP_Task_List.md` file.

## 4. Communication & Best Practices

* **Clarity is Key:** If any instructions in the `session_brief.md`, task descriptions, or specification documents are unclear, please ask for clarification *before* proceeding with extensive work.
* **Report Blockers:** If you encounter an issue or blocker that prevents you from completing the assigned task, and it's not already noted in the `session_brief.md`, please report it promptly.
* **Reference Sources:** When providing code, explanations, or analysis, please reference the relevant `TASK-ID(s)` and specification documents where appropriate.
* **Follow Output Formats:** If a prompt template (e.g., `code_generation_template.md`) specifies an output format, please adhere to it.
* **Assumptions:** If you must make an assumption to proceed, clearly state the assumption you made.

This framework is designed to help us collaborate effectively. Your role is crucial, and by following these guidelines, we can build Jetpack Havoc efficiently and accurately!
