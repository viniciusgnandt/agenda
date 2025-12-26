FROM node:20-slim AS builder

WORKDIR /app

# Copia package.json primeiro para aproveitar cache
COPY package*.json ./

RUN npm install --production=false

# Copia todo o código e builda o Next.js
COPY . .
RUN npm run build

FROM node:20-slim AS runner
WORKDIR /app

ENV NODE_ENV=production

# Copia os artefatos do build
COPY --from=builder /app /app

EXPOSE 3000

CMD ["npm", "run", "start"]