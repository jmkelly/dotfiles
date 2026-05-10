---
description: Run the crew leader on one task-cli project
argument-hint: "<project> <goal>"
---
Use the `subagent` tool in single mode with:
- `agent`: `crew-leader`
- `agentScope`: `user`
- `cwd`: the current working directory, or the intended repository root if different
- `task`:

```text
Project: $1
Goal: ${@:2}

Operate only on this project.
Use the task CLI as the source of truth.
Planning, decomposition, acceptance criteria, and worker selection stay with `crew-leader`; delegate only specialist research, design, coding, testing, or review work.
Before you delegate, inspect the project queue for a dedicated memory task titled `Project memory: $1`; if it is missing, create it with assignee `crew-leader`, status `done`, and tags `crew,memory`. If it already exists, verify it is still assigned to `crew-leader`, in `done` status, and tagged `crew,memory`, and repair those fields if they drifted. Then read it before making new decisions.
Treat `crew-leader` as the only writer of that memory task. Workers should keep detailed evidence and completion notes on their own task descriptions.
Record each discrete work item as its own task CLI task. Do not use task descriptions as todo lists, checklists, or bullet-list backlogs; keep notes to concise prose context, evidence, assumptions, and completion summaries.
When you delegate a worker task, update the assignee in task CLI first, include that same agent explicitly in the delegated task assignee property or task brief, and leave the status change to the worker when they actually start.
Before you pause or return, refresh the project memory task from durable worker task notes and any project-level decisions or learnings from this run.
Review the queue, delegate one worker at a time, review each worker response, and continue until you reach a sensible pause point.
```
