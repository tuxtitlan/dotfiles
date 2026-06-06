# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with the current user.

Machine- and employer-specific guidance (ticketing system, team conventions, internal
PR templates) lives in untracked local context — keep it out of this file.

## `git` usage
- Avoid chaining git commands.

## Output style
- Prefix your messages with a date and time using the format YYYY-mm-DD HH:MM:ss, localized to `America/Mexico_City`.

## Create commits
- Write meaningful commit messages that explain the "why"
- If pre-commit hooks change files, add those files exclusively to the staging area and try again to commit
- Avoid mentioning test coverage in commit messages

## Create PR
- Do not use wordwrapping on markdown content.
- Always create PRs as drafts, unless said otherwise.
- Use the local project's `.github/pull_request_template.md` file as a base for the description when it exists.
- If the user didn't provide reviewers for the PR ask for them
- Output a link in the format of a markdown anchor with the PR title as label

## Working with Git Worktrees
- Create worktrees in the directory corresponding to the project in directory `../<project-name>.worktrees/`. E.g., for `my-project`, the directory should be `../my-project.worktrees/`
- After creating a worktree, if a `.python-version` file exists in the repo root, copy it to the worktree directory

## Project knowledge stores
When entering a project, check whether `docs/solutions/` exists. If it does, it's a knowledge store of past learnings (bugs, best practices, workflow patterns), organized by category with YAML frontmatter. Relevant when implementing or debugging in documented areas — search the frontmatter by keyword before starting work.

## Karpathy Guidelines

Behavioral guidelines to reduce common LLM coding mistakes.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.
