# 🚀 Projeto com Load Balancer (Nginx), Backend e Frontend com Docker

Este projeto utiliza Docker Compose para subir um ambiente com frontend, backend e um balanceador de carga utilizando Nginx.

---

## 🗂️ Estrutura de Pastas do Projeto

```plaintext
projeto/
│
├── docker-compose.yml
├── nginx.conf
├── redes_computadores/
│   ├── frontend/
│   │   └── Dockerfile
│   └── backend/
│       └── Dockerfile
```
## 🐳 Novo Docker Compose
```plaintext
version: '3.8'
services:

  backend:
    container_name: backend
    build:
      context: ./backend
      dockerfile: Dockerfile
    ports:
      - "3332:3332"

  frontend1:
    image: meu-frontend:latest
    container_name: frontend1
    environment:
      - SERVER_NAME=Servidor 1
    ports:
      - "5001:80"
    depends_on:
      - backend

  frontend2:
    image: meu-frontend:latest
    container_name: frontend2
    environment:
      - SERVER_NAME=Servidor 2
    ports:
      - "5002:80"
    depends_on:
      - backend

  frontend3:
    image: meu-frontend:latest
    container_name: frontend3
    environment:
      - SERVER_NAME=Servidor 3
    ports:
      - "5003:80"
    depends_on:
      - backend

  nginx:
    image: nginx:latest
    container_name: loadbalancer
    depends_on:
      - frontend1
      - frontend2
      - frontend3
    ports:
      - "8080:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf:ro


```

##📝 Criando o arquivo Nginx

```plaintext
touch nginx.conf
nano nginx.conf
```

##❗ Substituir IPs
Substitua frontend e backend pelos IPs dos colegas que irão ligar a máquina para testar o Load Balancer (ex: 192.168.0.15).

## 🔧 Exemplo de configuração do nginx.conf

```plaintext
upstream frontends {
    random;   # ativa seleção aleatória
    server frontend1:80 weight=3;
    server frontend2:80 weight=2;
    server frontend3:80 weight=1;
}
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://frontends;
        proxy_http_version 1.1;
        proxy_set_header Host               $host;
        proxy_set_header X-Real-IP          $remote_addr;
        proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto  $scheme;
    }
}

```

##✅ Lembre-se:
🛑 Para remover os containers criados:
```plaintext
docker-compose down
```
♻️ Para reconstruir e iniciar o projeto com as imagens atualizadas:
```plaintext
docker-compose -f docker-compose.yml up --build -d
```