# Fase de construcción
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Fase de producción
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/package.json /app/.next /app/public /app/node_modules ./
EXPOSE 3000
CMD ["npm", "start", "--", "-p", "3000"]