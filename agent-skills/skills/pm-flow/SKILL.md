---
name: pm-flow
description: Creates product-management artifacts before design or implementation. Use for PRDs, competitor analysis, user stories, acceptance criteria, product metrics, release scope, and feature definition.
---

# PM Flow

Turn product intent into buildable product-management artifacts before design, planning, or code.

## When to Use

- Writing or improving a PRD
- Defining user stories, jobs to be done, and acceptance criteria
- Comparing competitors or reference products
- Turning a vague feature idea into product scope
- Defining product metrics, instrumentation, rollout, or MVP/non-goals

## Output

Save artifacts under `work/<project-name>/product/`:

- `PRD.md`
- `USER_STORIES.md`
- `COMPETITIVE_NOTES.md` when competitor or reference products are involved
- `METRICS.md` when success metrics or instrumentation matter
- `ACCEPTANCE.md` for testable product acceptance criteria

## Workflow

1. **Clarify the product job**
   - Target users and segments
   - Current pain or opportunity
   - Desired user-visible outcome
   - Business or operational constraints

2. **Define scope**
   - MVP must-haves
   - Later/optional scope
   - Explicit non-goals
   - Dependencies and assumptions

3. **Map users and stories**
   - Jobs to be done
   - User stories with acceptance criteria
   - Edge cases, empty states, permission states, and failure states

4. **Study references when available**
   - Compare competitor/reference flows without copying blindly
   - Extract product patterns: onboarding, navigation, pricing, activation, retention, trust, support, and handoff behavior
   - Record reference links and screenshots under the project `design/` or `product/` folders

5. **Define success**
   - North-star outcome
   - Feature-level metrics
   - Guardrail metrics
   - Instrumentation/event ideas where relevant

6. **Prepare downstream handoff**
   - If user-facing UI is involved, hand off to `design-flow`
   - If agent behavior is involved, hand off to `agent-flow`
   - If requirements are ready for build planning, hand off to `spec-driven-development` or `planning-and-task-breakdown`

## PRD Template

```markdown
# PRD: [Feature/Product]

## Summary
[One paragraph: what, who, why now.]

## Users and Jobs
- User segment:
- Job to be done:
- Current workaround:

## Goals
- [Measurable/product outcome]

## Non-Goals
- [Explicitly out of scope]

## MVP Scope
- [Must-have capability]

## User Stories
- As a [user], I want [capability], so that [outcome].
  - Acceptance:

## Key Flows
[Happy path, edge cases, failure/recovery.]

## Metrics
- Activation:
- Engagement:
- Quality:
- Guardrails:

## Risks and Open Questions
- [Risk/question]

## Downstream Handoff
- Design requirements needed:
- Agent/workflow requirements needed:
- Technical spec requirements needed:
```

## Verification

- [ ] Target user and job are explicit
- [ ] MVP and non-goals are clear
- [ ] User stories have testable acceptance criteria
- [ ] Metrics and guardrails are named when relevant
- [ ] Open questions and risks are visible
- [ ] Next workflow handoff is identified
