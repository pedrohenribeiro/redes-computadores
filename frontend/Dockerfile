FROM node:22-alpine AS build
WORKDIR /app

# 1) recebe o arg e exporta apenas o VITE_SERVER_NAME
ARG SERVER_NAME
RUN echo ">> Building for ${SERVER_NAME}"
ENV VITE_SERVER_NAME=$SERVER_NAME

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 5000
CMD ["nginx", "-g", "daemon off;"]
