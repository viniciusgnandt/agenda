# Base com Debian (melhor compatibilidade que Alpine)
FROM node:20-slim

# Diretório de trabalho
WORKDIR /app

COPY package*.json ./

# Instala dependências
RUN npm install --production=false

# Copia o restante do código (excluindo dist por .dockerignore)
COPY . .

# Remove dist antigo se existir
RUN rm -rf dist

# Compila o projeto (Prisma generation skipped)
RUN npm run build

# Verifica saída
RUN if [ -f dist/server.js ]; then echo "[build] dist/server.js found"; else echo "[build] dist/server.js NOT FOUND"; fi

# Expõe a porta do backend
EXPOSE 3000

# Comando de start direto com Node.js
ENTRYPOINT ["node", "dist/server.js"]