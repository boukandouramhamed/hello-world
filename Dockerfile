FROM centos/httpd-24-centos7:latest
COPY ./public-html/index.html /var/www/html
