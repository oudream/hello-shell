

docker run --name nginx -v /opt/nginx/nginx.conf:/etc/nginx/nginx.conf -v /opt/deploy/:/usr/share/nginx/html/download -p 80:80 -d  nginx
