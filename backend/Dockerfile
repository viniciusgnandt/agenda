# Base
FROM node:20-alpine

# Diretório de trabalho
WORKDIR /app

# Copia apenas arquivos de dependência primeiro (cache)
COPY package*.json ./

# Instala dependências
RUN npm install

# Copia o restante do código (excluindo dist por .dockerignore)
COPY . .

# Remove dist antigo se existir
RUN rm -rf dist

# Gera o client do Prisma
#RUN npx prisma generate

# Compila TypeScript
RUN npm run build

# Verifica se build funcionou
RUN test -f dist/server.js || (echo "Build failed: dist/server.js not found" && exit 1)

# Expõe a porta do backend
EXPOSE 3000

# Comando de start
CMD ["npm", "start"]