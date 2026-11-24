# Contributing

This project follows a very small subset of [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification so that history stays readable, changelogs can be generated automatically.

## Commit Message Format

`<type>(<optional scope>): <description>`

## Types


| Type | Purpose |
|------|---------|
| `feat` | A new feature |
| `fix` | A bug fix |
| `docs` | Documentation-only changes |
| `style` | Formatting, whitespace, semicolons (no logic change) |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `perf` | A change that improves performance |
| `test` | Adding or correcting tests |
| `build` | Build system or dependency changes (Cargo, npm, mix, etc.) |
| `ci` | CI configuration and scripts |
| `chore` | Maintenance tasks that don't modify src or tests |
| `revert` | Reverts a previous commit |

Realistically you will not touch most of these but they are here for reference.

## Scope

The scope is an optional noun in parentheses describing the area of the codebase affected:

```
feat(auth): add email verification resend button
fix(parser): handle empty input without panicking
docs(readme): clarify install steps
```

## Description

- Use the **imperative, present tense**: "add", not "added" or "adds".
- Start with a **lowercase** letter.
- Do **not** end with a period.
- Describe *what* the change does, not *how* you did it.

| Bad | Good |
|-----|------|
| `fix: fixed bug` | `fix: prevent crash when config file is missing` |
| `feat: Added new stuff.` | `feat: add dark mode toggle` |
| `update code` | `refactor: extract validation into helper` |


## Examples

```
feat: add user avatar uploads
```

```
fix(auth): correct token expiry calculation
```

```
docs: add contributing guide
```

```
refactor(db): replace raw queries with query builder
```

```
revert: revert "feat: add experimental sync"
```

## Guidelines

- **One logical change per commit.** Don't mix a refactor and a feature in the same commit.
- **Commit early, commit often**, then clean up before opening a PR (e.g. `git rebase -i`).
- **Don't use vague messages** like `fix stuff`, `wip`, or `updates`.
- If a PR is squash-merged, the **PR title** must follow this format since it becomes the commit message.

## Pull Request Workflow

1. Clone the repo and create a branch from `main` (e.g. `feat/resend-verification`).
2. Make your changes, following the commit conventions above.
3. Run tests and linters locally.
4. Open a pull request with a conventional-commit-style title and a clear description.
5. Address review feedback with additional commits (or fixups, if requested).

## Enforce Commits

You can validate messages locally tooling such as:

- [Commitizen](https://commitizen-tools.github.io/commitizen/) for an interactive prompt that builds the message for you
