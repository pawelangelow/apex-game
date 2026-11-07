# Deployment

The game runs as a Docker Compose stack: `app` (Node server + built client), `postgres`, and `caddy` (HTTPS with automatic certificates).

## First setup

1. Install Docker with the Compose plugin on the host.
2. Point the domain's DNS at the host. Ports 80 and 443 must be reachable from the internet (Caddy needs them for certificates).
3. Clone the repo, then `cp .env.example .env` and set `DOMAIN` and a strong `POSTGRES_PASSWORD`.
4. `docker compose up -d --build`
5. Check `https://<DOMAIN>/api/health` returns `{"status":"ok"}`.

## Deploying a new version

```sh
scripts/deploy.sh
```

Pulls `main`, rebuilds the app image and restarts what changed.

## Backups

```sh
scripts/backup.sh
```

Writes a compressed dump to `./backups` (override with `BACKUP_DIR`) and deletes dumps older than 14 days (`BACKUP_KEEP_DAYS`). Run it nightly from cron, and copy the dumps somewhere off the host:

```cron
0 4 * * * /path/to/apex-game/scripts/backup.sh
```

Restore:

```sh
docker compose exec -T postgres pg_restore -U apex -d apex --clean < backups/apex-YYYYMMDD-HHMMSS.dump
```

## Logs

```sh
docker compose logs -f app
```
