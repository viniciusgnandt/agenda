# Base
FROM node:20-alpine

# Diretório de trabalho
WORKDIR /app

# Copia dependências primeiro
COPY package*.json ./

# Instala dependências
RUN npm install

# Copia o restante
COPY . .

# Build do Next.js
RUN npm run build

# Expõe a porta padrão do Next
EXPOSE 3000

# Start em modo produção
CMD ["npm", "run", "start"]