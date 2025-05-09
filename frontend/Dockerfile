# stage 1: build do Vite (assets hashed)
FROM node:22-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# stage 2: nginx + envsubst + entrypoint
FROM nginx:alpine
RUN apk add --no-cache gettext     # oferece envsubst

# copia o build estático
COPY --from=build /app/dist /usr/share/nginx/html

# copia o entrypoint que injeta o nome do servidor
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
