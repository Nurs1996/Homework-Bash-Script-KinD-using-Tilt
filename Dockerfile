FROM nginx:alpine
COPY custom-index.html /usr/share/nginx/html/index.html
EXPOSE 8081
