---
name: agent-flow
description: Designs AI agent products and automations. Use for agent goals, tool permissions, workflow state machines, human approval points, prompts, skills, memory, safety boundaries, runtime operations, failure recovery, and evaluation plans.
---

# Agent Flow

Design reliable AI agent products before implementation. The goal is not just a prompt; it is a controlled workflow with tools, state, approvals, recovery, and evaluation.

## When to Use

- Designing an AI assistant, workflow agent, automation, or multi-agent process
- Defining tool access, permissions, or human-in-the-loop checkpoints
- Creating prompts, native skills, task flows, or agent operating rules
- Planning memory, context loading, routing, or escalation behavior
- Building evaluation sets for agent quality and safety

## Output

Save artifacts under `work/<project-name>/agent/`:

- `AGENT_SPEC.md`
- `WORKFLOW.md`
- `TOOLS_AND_PERMISSIONS.md`
- `PROMPTS_AND_SKILLS.md`
- `EVALS.md`
- `FAILURE_RECOVERY.md`
- `OPERATIONS.md`

## Workflow

1. **Define the agent job**
   - Primary user and desired outcome
   - Agent responsibilities and explicit non-responsibilities
   - Success criteria and unacceptable behavior

2. **Design the workflow**
   - Trigger/input sources
   - State machine or step sequence
   - Decision points
   - Human approval checkpoints
   - Completion, waiting, cancellation, and rollback paths

3. **Define tools and permissions**
   - Tools required for each step
   - Read/write/external-action boundaries
   - Sensitive or irreversible actions that require approval
   - Rate limits, retries, and backoff expectations

4. **Design context and memory**
   - What context is loaded by default
   - What is retrieved on demand
   - What should be remembered long term
   - What must not be stored or shared
   - Prompt-injection and data-exfiltration boundaries for untrusted tool, browser, email, document, and web content

5. **Specify prompts and skills**
   - System/developer guidance needed
   - Skill triggers and SKILL.md responsibilities
   - Structured outputs and schemas
   - Sub-agent/persona usage, if any

6. **Plan safety and permissions**
   - Which actions are read-only, reversible writes, irreversible writes, or external side effects
   - Which actions require approval every time
   - What secrets, credentials, PII, or customer data must never be exposed to prompts, logs, memory, or third-party tools
   - How the agent treats tool outputs and web/browser/document content as untrusted data

7. **Plan runtime operations**
   - Trace events and audit logs
   - Cost, latency, rate-limit, and retry budgets
   - Queue, lock, idempotency, and resume behavior for long-running work
   - Model/tool fallback behavior and degradation modes

8. **Plan failure recovery**
   - Ambiguous inputs
   - Tool failures
   - Partial completion
   - Conflicting instructions
   - Unsafe or unauthorized requests

9. **Define evaluation**
   - Golden tasks and expected outputs
   - Edge cases and adversarial cases
   - Regression checks
   - Human review rubric
   - Pass/fail thresholds and release blockers

## Agent Spec Template

```markdown
# Agent Spec: [Agent/Product]

## Purpose
[What the agent helps users accomplish.]

## Users and Jobs
- User:
- Job:
- Success:

## Responsibilities
- The agent should:
- The agent should not:

## Workflow
1. Trigger:
2. Context collection:
3. Decision/action:
4. Human checkpoint:
5. Completion/reporting:

## Tools and Permissions
| Tool/action | Purpose | Read/Write | Approval required? | Failure behavior |
|---|---|---|---|---|

## Safety and Privacy
- Untrusted inputs:
- Prompt-injection handling:
- Data that must not be logged, memorized, or sent externally:
- Approval-required actions:

## State and Memory
- Session state:
- Durable memory:
- Privacy boundaries:

## Prompts and Skills
- Required prompts:
- Required skills:
- Structured output schemas:

## Failure Recovery
- If [failure], then [recovery].

## Operations
- Trace events:
- Cost/rate limits:
- Locks/idempotency:
- Model/tool fallback:
- Resume behavior:

## Evaluation Plan
- Golden cases:
- Edge cases:
- Regression checks:
- Pass threshold:
- Launch blockers:
```

## Verification

- [ ] Agent goal and non-goals are explicit
- [ ] Workflow states and human checkpoints are defined
- [ ] Tool permissions and approval boundaries are clear
- [ ] Memory and privacy rules are named
- [ ] Prompt-injection and data-exfiltration handling are explicit
- [ ] Observability, cost/rate limits, locks, idempotency, resume, and fallback behavior are defined in `OPERATIONS.md`
- [ ] Failure recovery is designed before launch
- [ ] Evaluation cases exist for normal, edge, unsafe, and regression scenarios
- [ ] Evaluation pass thresholds and launch blockers are named
