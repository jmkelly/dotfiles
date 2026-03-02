---
description: Stage and commit related changes with conventional commits
agent: build
---
# Git Smart Commit

You are to intelligently analyze the current uncommitted git changes and create logical commits that group related functionality together.

## Instructions

1. **First, gather information about the changes** using these git commands:
   - Get all changes: `!git status --short`
   - Get modified files: `!git diff --name-status`
   - Get staged files: `!git diff --name-status --cached`
   - Get statistics: `!git diff --stat`
   - Get recent commits for context: `!git log --oneline -20`

2. **Analyze the changes** to identify logical groupings:
   - Look at file paths to identify areas of functionality (e.g., Services, Controllers, Tests, Docs)
   - Examine diff content to understand what changed in each file
   - Group changes that work together to implement a single feature or fix
   - Consider project structure: Quezzi.Web, Quezzi.Tests, Quezzi.Shared, docs/

3. **For each logical group**, create a conventional commit with format: `<type>(optional scope): <description>`

   **Valid types:**
   - `feat`: A new feature
   - `fix`: A bug fix
   - `chore`: Routine tasks, dependency updates, cleanup
   - `refactor`: Code changes that neither fix a bug nor add a feature
   - `docs`: Documentation only changes
   - `test`: Adding or updating tests
   - `style`: Code style changes (formatting, etc.)
   - `perf`: Performance improvements
   - `ci`: CI/CD changes
   - `build`: Build system changes
   - `revert`: Revert a previous commit

   **Description format:**
   - Use imperative mood ("add" not "added" or "adds")
   - Lowercase except for proper nouns
   - Don't end with a period
   - Max 50 characters for the subject line

4. **Stage and commit each group**:
   - Stage only the files that belong to that commit
   - Use `git add <files>` to stage
   - Create the commit with: `git commit -m "<commit message>"`
   - After all commits are done, show the result: `!git log --oneline -5`

## Important Notes

- Do NOT commit files that might contain secrets (.env, credentials.json, etc.)
- If a commit fails due to pre-commit hooks, fix the issue and create a NEW commit (do NOT amend)
- If there are no changes to commit, skip that group
- Use clear, descriptive scope names that reflect the affected area
- Ensure each commit is atomic and focused on a single logical change
- If changes cannot be logically grouped, commit them all together with an appropriate type/scope

## Example

If the changes include:
- `Quezzi.Web/Services/CachedCityService.cs` (new)
- `Quezzi.Web/Program.cs` (DI registration)
- `Quezzi.Web/Services/CityService.cs` (simplified)

Group these as one commit: `feat(cache): add caching layer to CityService`

Then stage and commit those files together.

---

Now proceed to analyze the changes, group them logically, and create the commits.
