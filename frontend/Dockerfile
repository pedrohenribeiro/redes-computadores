# 1) Build estático
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# 2) Imagem final do front-end
FROM nginx:alpine
RUN apk add --no-cache gettext

# variável a ser injetada em runtime
ARG SERVER_NAME
ENV SERVER_NAME=$SERVER_NAME

# copia o dist e renomeia o index para template
COPY --from=build /app/dist /usr/share/nginx/html
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.template.html

# copia e libera o entrypoint dentro do container
COPY envsubst-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
