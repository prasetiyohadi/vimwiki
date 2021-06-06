FROM nginx:1.20.0-alpine
COPY default.conf /etc/nginx/conf.d/
COPY site/ /usr/share/nginx/html/
