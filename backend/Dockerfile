# Base
FROM node:20-alpine

# Diretório de trabalho
WORKDIR /app

# Copia apenas arquivos de dependência primeiro (cache)
COPY package*.json ./

# Instala dependências
RUN npm install

# Copia o restante do código
COPY . .

# Gera o client do Prisma
RUN npx prisma generate

# Build do TypeScript
RUN npm run build

# Expõe a porta do backend
EXPOSE 3000

# Comando de start
CMD ["npm", "run", "start"]