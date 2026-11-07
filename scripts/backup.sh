#!/bin/sh
# Dump the database to $BACKUP_DIR and delete dumps older than $BACKUP_KEEP_DAYS.
set -eu
cd "$(dirname "$0")/.."
dir="${BACKUP_DIR:-./backups}"
keep="${BACKUP_KEEP_DAYS:-14}"
mkdir -p "$dir"
docker compose exec -T postgres pg_dump -U apex -Fc apex > "$dir/apex-$(date +%Y%m%d-%H%M%S).dump"
find "$dir" -name 'apex-*.dump' -mtime +"$keep" -delete
