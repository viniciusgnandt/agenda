#!/bin/sh
set -e

echo "[entrypoint] Starting entrypoint script"

cd /app

# Ensure node_modules are present in the docker-managed volume
if [ ! -d "/app/node_modules" ] || [ -z "$(ls -A /app/node_modules 2>/dev/null)" ]; then
  echo "[entrypoint] Installing dependencies..."
  npm install --production=false
fi

# Build TypeScript if dist missing or stale
if [ ! -f "/app/dist/server.js" ]; then
  echo "[entrypoint] Building project..."
  npm run build
fi

echo "[entrypoint] Starting app"
exec node dist/server.js
