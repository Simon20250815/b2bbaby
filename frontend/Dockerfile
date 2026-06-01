FROM alpine:latest

RUN apk update && apk add --no-cache nodejs npm nginx

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

RUN mkdir -p /run/nginx && \
    rm -rf /etc/nginx/http.d/default.conf && \
    echo 'server { \
        listen 0.0.0.0:4321; \
        server_name localhost; \
        root /app/dist/client; \
        index index.html; \
        location / { \
            try_files $uri $uri/ $uri.html /index.html; \
        } \
    }' > /etc/nginx/http.d/default.conf

EXPOSE 4321

CMD ["nginx", "-g", "daemon off;"]