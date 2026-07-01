FROM nginx:alpine

COPY treningsprogram.html /usr/share/nginx/html/index.html

# nginx:alpine processes /etc/nginx/templates/*.template with envsubst on startup.
# Cloud Run injects $PORT (default 8080).
RUN printf 'server {\n\
    listen ${PORT};\n\
    location / {\n\
        root /usr/share/nginx/html;\n\
        index index.html;\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
    gzip on;\n\
    gzip_types text/html text/css application/javascript;\n\
}\n' > /etc/nginx/templates/default.conf.template

EXPOSE 8080
