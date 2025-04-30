# Dockerfile.frontend.shared
FROM node:22-alpine AS build
WORKDIR /app
ARG SERVER_NAME
ENV VITE_SERVER_NAME=$SERVER_NAME
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
ARG SERVER_NAME
ENV VITE_SERVER_NAME=$SERVER_NAME
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
