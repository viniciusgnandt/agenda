#!/bin/bash

set -e

echo "🚀 Iniciando ambiente Agenda..."

# =========================
# Rede Docker
# =========================
if ! docker network inspect agenda-net >/dev/null 2>&1; then
  echo "🔧 Criando rede agenda-net..."
  docker network create agenda-net >/dev/null
else
  echo "✅ Rede agenda-net já existe"
fi

# =========================
# Banco de dados
# =========================
echo "🐘 Subindo Postgres..."
cd database
docker compose -f dockercompose.db.yaml up -d --build
cd ..

# =========================
# Backend
# =========================
echo "🧠 Subindo Backend..."
cd backend
docker compose -f dockercompose.yaml up -d --build
cd ..

# =========================
# Frontend
# =========================
echo "🌐 Subindo Frontend..."
cd frontend
docker compose -f dockercompose.yaml up -d --build
cd ..

echo "✅ Ambiente pronto!"
echo ""
echo "🌍 Frontend: http://localhost:7000"
echo "🧠 Backend:  http://localhost:7001"
echo "🐘 Postgres: localhost:5432"