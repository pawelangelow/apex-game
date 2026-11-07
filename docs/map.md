# Code map

Where things live. Agents read this before searching the code. Keep it short: places, not contents.
Update it in the same commit as any structural change (see CLAUDE.md, Rule 2).

## Stack

- **Language:** TypeScript everywhere, on Node.js.
- **Repo:** npm workspaces monorepo. Packages: `server`, `client`; `game` (pure game logic, no dependencies) and `sim` are added with the first game logic.
- **Backend:** Fastify, WebSockets for real-time (taxi map, street race lobbies, notifications).
- **Database:** PostgreSQL with Drizzle ORM. Timers and scheduled events via pg-boss (no Redis).
- **Frontend:** React + Vite, shipped as a PWA with Web Push.
- **Config:** YAML files validated with Zod.
- **Tests:** Vitest.
- **Deployment:** Docker Compose (app, Postgres, Caddy for HTTPS).

## Commands

| Task | Command |
| --- | --- |
| Install | `npm install` |
| Start dev database | `docker compose -f compose.dev.yml up -d` |
| Dev (server :3000 + client with `/api` proxy) | `npm run dev` |
| Typecheck | `npm run typecheck` |
| Test | `npm test` |
| Build | `npm run build` |
| Deploy / backups | see [deploy.md](deploy.md) |

## Directories

| Path | Owns |
| --- | --- |
| `docs/` | Design docs: [game.md](game.md) (constitution), this map, [deploy.md](deploy.md) |
| `packages/server/` | Fastify API; entry `src/index.ts`. In production also serves the built client (`CLIENT_DIST`) |
| `packages/client/` | React + Vite app; entry `src/main.tsx` |
| `scripts/` | `deploy.sh`, `backup.sh` |
| `Dockerfile`, `compose.yml`, `Caddyfile` | Production stack |
| `compose.dev.yml` | Dev database only |

## Systems → code

One row per game system once it has code. The game.md column links to the section it implements.

| System | game.md section | Code location | Config |
| ------ | --------------- | ------------- | ------ |
| —      | —               | —             | —      |

## Conventions

- Timed things are timestamps, not running processes: store `started_at` / `ends_at` and resolve on completion or on read.
- The `game` package never imports from `server`, `client` or `sim`. It holds pure functions only.

_Add more as they're decided: naming, where tests go, where config lives, how a new job or race format is added._
