# 1) build estático
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# 2) imagem final
FROM nginx:alpine
RUN apk add --no-cache gettext

ARG SERVER_NAME
ENV SERVER_NAME=$SERVER_NAME

# Copia TODO o dist, incluindo o index.html gerado pelo Vite
COPY --from=build /app/dist /usr/share/nginx/html

# Renomeia só para servir de template
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.template.html

# Copia e libera o entrypoint
COPY envsubst-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
