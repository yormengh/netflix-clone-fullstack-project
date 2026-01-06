# --- Multi-stage production Dockerfile for Netflix Clone ---
# Build stage: build the Vite app
FROM node:18-alpine AS builder
WORKDIR /app

# Install dependencies (use ci if you have a lockfile)
COPY package*.json ./
RUN npm ci --silent
COPY . .
RUN npm run build

# Production stage: serve built static files with nginx
FROM nginx:stable-alpine AS production

# Allow overriding the port at runtime. Default is 5173 (non-conflicting)
ARG PORT=5173
ENV PORT=${PORT}
ENV HOST=0.0.0.0

# Copy built assets
COPY --from=builder /app/dist /usr/share/nginx/html

# Create an entrypoint that generates an nginx config using a template and envsubst at runtime
RUN apk add --no-cache gettext wget

RUN cat > /etc/nginx/conf.d/default.conf.template <<'EOF'
server {
    listen   ${PORT};
    server_name  localhost;
    root   /usr/share/nginx/html;
    index  index.html index.htm;
    location / {
        try_files $uri $uri/ /index.html;
    }
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }
}
EOF

RUN printf '%s\n' '#!/bin/sh' 'set -e' 'envsubst '\''$PORT'\'' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf' 'exec "$@"' > /docker-entrypoint.sh \
  && chmod +x /docker-entrypoint.sh

# Expose only the app port to avoid conflicts with existing services
EXPOSE 5173

# Healthcheck to ensure the server is responding
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- --tries=1 --timeout=2 http://127.0.0.1:${PORT}/ || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
