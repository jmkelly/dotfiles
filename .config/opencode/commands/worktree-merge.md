---
description: Safely merge the current worktree branch into the default branch
agent: build
model: github-copilot/gpt-5.4-mini
---
# Worktree: Merge

Safely merge the current worktree branch into the repository default branch.

## Instructions

1. **Preflight checks**
   - Identify the current branch.
   - Identify the default branch.
   - If the current branch cannot be determined, is detached `HEAD`, or is already the default branch, you MUST stop and warn me you cannot continue.
   - If the default branch cannot be determined with confidence, you MUST stop and ask me to clarify it.
   - If the working tree has uncommitted or unstaged changes, you MUST stop and ask me how to proceed.

2. **Prepare the merge**
   - Fetch the latest remote refs.
   - Switch to the default branch. Update the default branch from its remote. Merge the original worktree branch into the default branch with `--no-ff`.
3. **Hard rules during the merge**
   - Do NOT fast-forward the merge.
   - Do NOT rebase.
   - Do NOT cherry-pick.
   - Do NOT use `--ours` or `--theirs`.
   - If conflicts occur, resolve them manually and carefully so important changes from the worktree branch are not lost.
   - Remove all conflict markers and verify the final result is coherent.

4. **Validate the merged result**
   - Run the relevant project checks after the merge. Prefer the smallest reliable validation that matches the repository, such as targeted tests first, then broader checks if needed.
   - You MUST NOT try to fix pre-existing errors from the default branch.
   - Only fix problems introduced by the merge or by your conflict resolution.

5. **Stop conditions**
   - If you cannot resolve a conflict confidently, you MUST stop and ask me to step in.
   - If the relevant checks fail and you cannot fix the new merge-related issue safely, you MUST stop and ask me to step in.
   - In either case, you MUST NOT push.

6. **After a successful merge**
   - If conflicts occurred, report which files conflicted and briefly explain how each conflict was resolved.
   - Push the updated default branch only after the merge is complete and the checks pass.
   - Only after the merge is successful and pushed, you may delete the worktree branch.
   - Delete the local worktree branch only. Do NOT delete any remote branch unless I explicitly ask.
   - If you are in any doubt, you MUST NOT delete the worktree branch.

Take the time needed to do the merge properly. Accuracy is more important than speed.
