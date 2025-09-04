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

<!-- Example entry (remove after first real entry)
### Misread return type in helper — 2025-09-04
- Mistake: Assumed helper returned bytes; it returned a file path.
- Why it happened: Skimmed code during a refactor; missed docstring.
- Fix applied: Converted to `Path.read_bytes()` before hashing.
- Prevention: Skim tests first; assert types in new code paths.
-->

