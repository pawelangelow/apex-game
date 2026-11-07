# Code map

Where things live. Agents read this before searching the code. Keep it short: places, not contents.
Update it in the same commit as any structural change (see CLAUDE.md, Rule 2).

## Stack

- **Language:** TypeScript everywhere, on Node.js.
- **Repo:** npm workspaces monorepo. Packages: `game` (pure game logic, no dependencies), `server`, `client`, `sim`.
- **Backend:** Fastify, WebSockets for real-time (taxi map, street race lobbies, notifications).
- **Database:** PostgreSQL with Drizzle ORM. Timers and scheduled events via pg-boss (no Redis).
- **Frontend:** React + Vite, shipped as a PWA with Web Push.
- **Config:** YAML files validated with Zod.
- **Tests:** Vitest.
- **Deployment:** Docker Compose (app, Postgres, Caddy for HTTPS).

How to run and how to test: _added once the project is scaffolded._

## Directories

| Path    | Owns                                                       |
| ------- | ---------------------------------------------------------- |
| `docs/` | Design docs: [game.md](game.md) (constitution), this map |

## Systems → code

One row per game system once it has code. The game.md column links to the section it implements.

| System | game.md section | Code location | Config |
| ------ | --------------- | ------------- | ------ |
| —      | —               | —             | —      |

## Conventions

- Timed things are timestamps, not running processes: store `started_at` / `ends_at` and resolve on completion or on read.
- The `game` package never imports from `server`, `client` or `sim`. It holds pure functions only.

_Add more as they're decided: naming, where tests go, where config lives, how a new job or race format is added._
