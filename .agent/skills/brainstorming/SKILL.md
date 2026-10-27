---
name: brainstorming-designs
description: Facilitates collaborative dialogue to refine rough ideas into fully formed technical designs. Use before starting any creative work or feature implementation to ensure requirement clarity and architectural alignment.
---

# Brainstorming Designs

## When to use this skill
- Before writing any code for a new feature or project.
- When the user has a "rough idea" that needs refining.
- When you need to explore architectural alternatives.
- Whenever you catch yourself thinking "this is too simple to need a design."

## Workflow
1.  **Explore Context**: Identify the current project state (relevant files, docs).
2.  **Ask Questions**: Pose clarifying questions ONE AT A TIME to understand goals and constraints.
3.  **Propose Options**: Present 2-3 distinct approaches with trade-offs.
4.  **Present Design**: Detail the chosen architecture section-by-section for validation.
5.  **Document**: Save the final design to `docs/plans/YYYY-MM-DD-<topic>-design.md`.
6.  **Handoff**: Transition to the `planning-tasks` skill.

## Instructions

### 1. Understanding the Idea
- **Context First**: Before asking, use tools like `list_dir` and `read_file` to see what surrounds the task.
- **One Question Rule**: Never ask more than one question per response.
- **Clarification Focus**: Focus on: Purpose, Constraints, Success Criteria, and API/Data boundaries.

### 2. Exploring Approaches
- Propose 2-3 different ways to solve the problem.
- List "Pros" and "Cons" for each.
- Recommend one approach and justify why it's the best fit for the current stack.

### 3. Presenting the Design
- Present sections based on complexity:
    - **Architecture**: How it fits into the whole system.
    - **Components/Functions**: What will be built/modified.
    - **Data Flow**: How information moves through the system.
    - **Testing Strategy**: How we will prove it works.
- **Micro-Validation**: Ask "Does this section align with your expectations?" after each part.

### 4. Implementation Gate
<HARD-GATE>
Do NOT start writing implementation code until the design document is written and the user has given a final approval.
</HARD-GATE>

## Resources
- Design Doc Template: `resources/design-template.md`

