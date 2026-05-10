# Crew operating principles

Shared instructions for the crew agent set.
Every `crew-*` agent should read and follow this file before doing project work.

## Core principles

- Use the task CLI as the source of truth for assignment, status, discoveries, assumptions, and handoff.
- Use `--json` for `task list`, `task add`, and `task edit` when you need reliable machine-readable task data.
- Work inside exactly one `task` project per run.
- Favor high quality with simplicity.
- Prefer the simplest solution that fits the existing system and solves the real problem.
- Avoid unnecessary abstraction, speculative extensibility, duplication, churn, and over-engineering.
- Be autonomous under local, reversible uncertainty.
- Surface hard-to-reverse risks clearly and escalate only when responsible progress requires it.
- Inspect surrounding code and relevant project structure, not just the narrow local task surface.
- Keep important project knowledge visible by recording assumptions, learnings, patterns, open questions, and follow-up work in task CLI.
- Use task descriptions for concise prose context, evidence, assumptions, and completion notes only, not as backlogs, checklists, or bullet-list work trackers.
- When a project uses a dedicated memory task, keep that memory in task CLI too rather than introducing hidden state or side stores.
- Do not hide actionable backlog in chat responses.
- Turn each discrete follow-up item into its own task instead of embedding pending work inside another task description.
- When requirements, design intent, system behavior, or supporting evidence are unclear, create explicit follow-up research tasks for `crew-leader`, usually recommending `crew-researcher`.
- When broader cleanup, simplification, documentation, or management work is discovered, create explicit follow-up tasks for `crew-leader`.

## Project memory convention

When the crew setup uses project memory, follow this convention unless the task explicitly says otherwise:

- Use one dedicated task-cli task per project for durable project-level memory.
- Title it `Project memory: <project>`.
- Keep it assigned to `crew-leader`, tagged `crew,memory`, and in `done` status so it is visible but not mistaken for actionable work.
- `crew-leader` is the only writer of that memory task.
- Workers should keep detailed evidence, discoveries, and completion notes on their own task descriptions; the leader can later consolidate durable project-level learnings into the memory task.
- The memory task is a deliberate exception to the usual append-a-note pattern: when refreshing it, `crew-leader` should rewrite the description into one concise, current summary that carries forward still-relevant durable context instead of appending another dated note block.

## Shared status protocol

- Only the agent actually starting a task should set it to `in_progress`.
- If progress stops, the active agent should set the task to `blocked` and include a clear block reason.
- When the objective is complete and notes are recorded, the active agent should mark the task `done` promptly.
- Leaders may reassign tasks for delegation, but they should not set `in_progress` on behalf of another agent.

## Quality and simplicity standard

Crew members should consistently prefer:

- clear code over clever code
- existing patterns over new abstractions
- focused changes over broad churn
- concrete tasks over implicit expectations
- maintainable designs over impressive designs

## Shared task note update protocol

For normal work tasks, treat `task edit --description` as a full replacement:

- first read the current task record from `task list --json --project <project>`
- preserve existing description content unless you are intentionally consolidating duplicate stale notes
- append a clearly delimited note block with role and context
- keep notes concise and prose-first; if you identify actionable follow-up work, create a separate task instead of listing it inside the description
- write back with `task edit <uid> --json --description "..."`
- never overwrite prior notes, assumptions, or handoff details just to add your own update

Exception: the dedicated `Project memory: <project>` task is maintained as a concise consolidated summary, so `crew-leader` should intentionally rewrite that task in place when refreshing project memory, carrying forward only the durable context that still matters.

## Shared follow-up task hygiene

When recording follow-up work, include:

- originating task UID
- why the work exists
- scope and impact
- recommended assignee or delegation direction
- evidence such as files, functions, modules, architectural areas, or commands
- whether the work is about correctness, tests, maintainability, simplification, cleanup, documentation, research, or project management

## Escalation standard

Escalate to the user only when proceeding autonomously would create meaningful product, security, privacy, compliance, migration, compatibility, data-loss, or other expensive-to-reverse risk.
