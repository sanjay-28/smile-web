# --- STAGE 1: Build & Setup ---
FROM nginx:alpine

# Copy index.html from your repository root into Nginx's public directory
COPY index.html /usr/share/nginx/html/index.html

# Configure Nginx to listen on Cloud Run's expected port (8080)
RUN echo "server { \
    listen 8080; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files \$uri \$uri/ /index.html; \
    } \
}" > /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
