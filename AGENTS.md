# AGENTS.md

Operational guide for contributors and AI agents working in this repository. It defines how to make changes, document them, and capture lessons learned.

## Core Principles
- Keep changes small, focused, and reversible.
- Prefer clarity over cleverness; optimize for future readers.
- Document intent and impact alongside code.

## Change Workflow
1. Plan the change briefly (goal, scope, risks).
2. Implement the smallest viable increment.
3. Validate locally (run, test, lint) before pushing.
4. Document the change:
   - Update `README.md` after every change you make.
   - Summarize what changed, why, and any user‑visible impact.
5. Open or update a PR (if applicable) with context and testing notes.

## When a Change Fails (Lessons Learned)
If you change code and it does not work and you have to redo it, append a brief entry to the Lessons Learned log below. Keep it concise and honest.

Template:
```
### <Short title of the mistake> — <YYYY‑MM‑DD>
- Mistake: <what went wrong at a glance>
- Why it happened: <assumption, gap, or oversight>
- Fix applied: <what corrected it>
- Prevention: <specific guardrail for next time>
```

## Documentation Standards
- Always update `README.md` after any change (code, config, docs).
- Include: purpose, key behavior changes, setup/usage updates, and migration notes.
- Keep examples runnable and minimal. Prefer links over duplicating large content.

## Commit Messages
- Format: `type(scope): summary` (e.g., `fix(api): handle empty payload`).
- Body: why the change was made and key decisions.
- Footer: references (issues, PRs) if relevant.

## Commit Message Requests
- When the user asks for a commit message, generate a single-line summary of what has changed since the last commit.
- Look back to the last time the user requested a commit message to maintain continuity and context; favor concise, user-facing impact over file lists.
- Use the working tree to inform the summary:
  - If there are staged changes, summarize staged changes; otherwise summarize all modified files since `HEAD`.
  - Prefer describing features/fixes/docs over listing filenames unless filenames convey intent.
- Offer an optional expanded body only if the user asks for more detail.

## Commit Requests
- Meaning: When the user says “commit the repo”, stage all changes, create a commit, and push to the current branch’s upstream.
- Actions: Run `git add -A`, then `git commit -m "<message>"`, then `git push`.
- Message: If no message is provided, ask for one or synthesize a concise summary per the Commit Messages guidelines.

## Branching
- Use feature branches: `feature/<short-name>`; fixes: `fix/<short-name>`; chores: `chore/<task>`.
- Keep PRs under ~300 lines of reviewable diff when possible.

## Code Quality
- Follow existing style and patterns in this repo.
- Prefer tests close to changed code; add minimal coverage for new behavior.
- Run formatters/linters if configured.

## Review Checklist
- Scope: limited and well explained.
- Tests: added/updated and passing locally.
- Docs: `README.md` updated, examples adjusted.
- Risk: rollback or disable plan noted.

---

## Lessons Learned Log

Add new entries at the top.

### Submodule blocked by .gitignore — 2025-09-04
- Mistake: Attempted to add a submodule under ignored `custom_nodes/`; Git refused to add it.
- Why it happened: Overlooked `.gitignore` rules that ignore `custom_nodes/` and assumed `git submodule add` would bypass ignore rules.
- Fix applied: Used `git submodule add --force` with the `.git` URL in `install_custom_nodes.bat`; added early-exit logic when the folder already exists; documented behavior in README.
- Prevention: Check `.gitignore` for target paths before adding submodules; add a pre-check in scripts to warn when a path is ignored and use `--force` only when intentional; prefer unignored paths or explicit unignore rules when feasible.

<!-- Example entry (remove after first real entry)
### Misread return type in helper — 2025-09-04
- Mistake: Assumed helper returned bytes; it returned a file path.
- Why it happened: Skimmed code during a refactor; missed docstring.
- Fix applied: Converted to `Path.read_bytes()` before hashing.
- Prevention: Skim tests first; assert types in new code paths.
-->
