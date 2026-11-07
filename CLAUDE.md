# Apex Racing

A strategic, browser-based car game. Races are simulated from stats, skills and choices, not driven.

## Read first

- [docs/game.md](docs/game.md) — **the constitution.** Every mechanic the player can use is described here. If it isn't in game.md, it isn't in the game.
- [docs/map.md](docs/map.md) — **the code map.** Where each system lives in the code. Read it before searching the codebase; search only for what the map doesn't cover.

## Rule 1: game.md stays in sync with the game

game.md describes what the game *does*, not how the code does it. Keep it that way: no file names, class names or implementation details in game.md.

- **Code changes a mechanic → game.md changes in the same commit.** Adding, removing or changing anything a player can see or do (a job, a resource, a formula's shape, a rule, an unlock) means updating the matching section of game.md.
- **game.md is the source of truth when they disagree.** If code contradicts game.md and the task didn't ask to change that mechanic, the code is the bug. Don't silently "fix" game.md to match the code; flag the mismatch to the user.
- **Changing a mechanic is a design decision.** If a task would change how something works for the player and the user didn't explicitly ask for that change, stop and ask before doing it.
- **Numbers belong in config, not in game.md.** game.md describes rules and shapes ("cost grows with level", "bust chance = base × heat × modifiers"). Concrete values live in config files. Placeholder examples in game.md are fine if marked as such.
- **Open questions:** when a decision is made, tick it in the "Open questions" list and write the answer into the relevant section. When work reveals a new undecided question, add it there instead of guessing.
- **Pilot scope:** when something moves between "Pilot" and "Later", update the Pilot scope table.

## Rule 2: map.md stays in sync with the code

- **Adding, moving, renaming or deleting a module, top-level directory or entry point → update map.md in the same commit.**
- map.md lists *places*, not *contents*: one line per module saying what it owns and which game.md section it implements. Don't describe functions or copy code into it; that rots.
- When a game system gets its first code, add its row to the "Systems → code" table.

## Rule 3: git workflow

- Solo project. Work directly on `main`. Do not create branches, worktrees or PRs unless the user explicitly asks.
- Commit only when the user asks. Keep commits small and focused; a commit that changes a mechanic includes the game.md update.
- No attribution lines in commit messages: no `Co-Authored-By:` trailers, no "Generated with" footers.

## Coding

- Write the minimum code that solves the problem. No speculative features, no abstractions for single-use code, no configurability that was not asked for. Exception: game numbers always go in config (see Rule 1); that is required, not speculative.
- Do not add error handling for impossible scenarios.
- Touch only what the task requires. Do not "improve" adjacent code, comments or formatting.
- Match the existing style in a file, even if you would write it differently.
- If you notice unrelated dead code or bugs, mention them, but do not fix them unprompted.
- Clean up orphans your changes create, such as unused imports or variables. Do not remove pre-existing dead code unless asked.

## Quality

- Do not bypass hooks or checks with `--no-verify`.
- Do not ignore errors to make code compile.
- Do not skip, delete or weaken tests to make a change pass.
- Stage only files that belong to the task. Leave unrelated uncommitted changes alone.

## Definition of done

Before reporting a task as finished, check:

1. Did a player-facing mechanic change? → game.md updated (or the user was asked).
2. Did the code structure change? → map.md updated.
3. Did a game number get hardcoded? → move it to config.
