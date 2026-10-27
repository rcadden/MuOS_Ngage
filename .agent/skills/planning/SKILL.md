---
name: planning-tasks
description: Expertly breaks down approved designs into bite-sized, test-driven implementation steps. Use when a design doc or specification is ready for implementation planning to ensure disciplined execution.
---

# Planning Tasks

## When to use this skill
- After a design is approved (via `brainstorming-designs`).
- When starting a multi-step coding task.
- To ensure TDD (Test Driven Development) and frequent commits are maintained.

## Workflow
1.  **Initialize Plan**: Create the plan document in `docs/plans/YYYY-MM-DD-<feature-name>.md`.
2.  **Define Tasks**: Break down the work into 2-5 minute steps.
3.  **Specify Tests**: For every change, define the failing test case first.
4.  **Handoff**: Present the plan for approval before starting Task 1.

## Plan Structure

### Header
Every plan MUST start with this standard header:
```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence goal]
**Architecture:** [Brief architectural note]
**Tech Stack:** [Tools/Libraries]
---
```

### Task Definition
Each task follows this template:
````markdown
### Task N: [Component Name]
**Files:**
- Create: `path/to/new_file.js`
- Modify: `path/to/existing_file.js`
- Test: `tests/path/test.js`

**Step 1: Write the failing test**
[Code snippet for the test]

**Step 2: Run test to verify failure**
Run: `[Command]`
Expected: FAIL

**Step 3: Minimal implementation**
[Code snippet for the smallest change to pass]

**Step 4: Verify pass**
Run: `[Command]`
Expected: PASS

**Step 5: Commit**
Command: `git commit -m "feat: [description]"`
````

## Instructions
- **Bite-Sized**: If a task takes longer than 5 minutes, break it into two.
- **TDD Enforcement**: Do not skip the "failing test" step. It proves the test is valid.
- **Clear Commands**: Always include the exact shell command to run the tests.
- **Absolute Paths**: Use full paths from the project root.

## Resources
- Plan Template: `resources/plan-template.md`

