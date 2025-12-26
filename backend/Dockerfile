# Base com Debian (melhor compatibilidade que Alpine)
FROM node:20-slim

# Diretório de trabalho
WORKDIR /app

COPY package*.json ./

# Instala dependências (image-level cache)
RUN npm install --production=false

# Copia o restante do código (source will be overridden by bind when composing)
COPY . .
# Copy entrypoint which will run npm install/build at container start if bind-mounted
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Install OpenSSL for Prisma and build TypeScript at image build time
RUN apt-get update -y \
	&& apt-get install -y --no-install-recommends openssl ca-certificates \
	&& rm -rf /var/lib/apt/lists/* \
	&& npm run build

# Expõe a porta do backend
EXPOSE 3000

# Use entrypoint to ensure builds happen when project is bind-mounted from host
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]