# --- STAGE 1: Build & Setup ---
FROM nginx:alpine

# Copy all static web application files into the default Nginx public directory
COPY . /usr/share/nginx/html/

# Configure Nginx to listen on port 8080 (Google Cloud Run's default)
RUN echo "server { \
    listen 8080; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index seedhe_sawal_tedhe_javab.html; \
        try_files \$uri \$uri/ /seedhe_sawal_tedhe_javab.html; \
    } \
}" > /etc/nginx/conf.d/default.conf

# Expose port 8080
EXPOSE 8080

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
