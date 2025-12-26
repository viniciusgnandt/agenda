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

# Ensure Prisma client is generated (in case schema changed or node_modules was recreated)
echo "[entrypoint] Ensuring Prisma client..."
if [ -d "node_modules/.prisma" ] || [ -d "node_modules/@prisma/client" ]; then
  echo "[entrypoint] Prisma client appears present"
else
  echo "[entrypoint] Generating Prisma client..."
  npm run prisma:generate
fi

# Optionally run migrations when MIGRATE=true
if [ "${MIGRATE}" = "true" ]; then
  echo "[entrypoint] Running prisma migrations (deploy)..."
  npx prisma migrate deploy || true
fi

echo "[entrypoint] Starting app"
exec node dist/server.js
