FROM openresty/openresty:trusty
MAINTAINER Akash Kaveti <akashkaveti@gmail.com>

COPY index.html /usr/local/openresty/nginx/html/index.html
CMD tail -f /dev/null
