#!/bin/sh
set -e

echo "[entrypoint] Starting entrypoint script"

cd /app

# Ensure node_modules are present in the docker-managed volume
if [ ! -d "/app/node_modules" ] || [ -z "$(ls -A /app/node_modules 2>/dev/null)" ]; then
  echo "[entrypoint] Installing dependencies..."
  npm install --production=false
fi

# Always rebuild TypeScript to catch source changes
echo "[entrypoint] Building project..."
npm run build

echo "[entrypoint] Starting app"
exec node dist/server.js
