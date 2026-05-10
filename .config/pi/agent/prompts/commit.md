---
description: Analyze changes, create logical conventional commits, and perform the commit(s)
argument-hint: "[scope-or-notes]"
---
Use the `subagent` tool in single mode with:
- `agent`: `commit`
- `agentScope`: `user`
- `cwd`: the current working directory
- `task`:

```text
Perform a git commit for the current repository changes.

Additional notes: $@
```
