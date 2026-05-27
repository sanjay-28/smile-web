# --- STAGE 1: Build & Setup ---
FROM nginx:alpine

# Copy the static web application files into the default Nginx public directory
COPY index.html /usr/share/nginx/html/index.html

# Copy custom Nginx configuration if needed, or configure it on the fly
# We will replace the default configuration to listen on the dynamic $PORT environment variable
# specified by Google Cloud Run.
RUN echo "server { \
    listen 8080; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files \$uri \$uri/ /index.html; \
    } \
}" > /etc/nginx/conf.d/default.conf

# Expose port 8080 (Google Cloud Run's default expected port)
EXPOSE 8080

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
