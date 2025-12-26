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
docker compose -f ./database/dockercompose.yaml up -d --build
echo "⏳ Aguardando 5 segundos..."
sleep 5

# =========================
# Backend
# =========================
echo "🧠 Subindo Backend..."
docker compose -f ./backend/dockercompose.yaml up -d --build
echo "⏳ Aguardando 5 segundos..."
sleep 5

# =========================
# Frontend
# =========================
echo "🌐 Subindo Frontend..."
docker compose -f ./frontend/dockercompose.yaml up -d --build
echo "⏳ Aguardando 5 segundos..."
sleep 5

echo "✅ Ambiente pronto!"
echo ""
echo "🌍 Frontend: http://localhost:7000"
echo "🧠 Backend:  http://localhost:7001"
echo "🐘 Postgres: localhost:7010"