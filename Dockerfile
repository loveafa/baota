FROM fachnan/baota:init
MAINTAINER Fachnan <>

RUN bash /www/server/panel/install/install_soft.sh 0 install nginx 1.18 \
    && bash /www/server/panel/install/install_soft.sh 0 install php 7.3 || echo 'Ignore Error' \
    && bash /www/server/panel/install/install_soft.sh 0 install mysql mariadb_10.4 \
    && bash /www/server/panel/install/install_soft.sh 0 install phpmyadmin 5.0 || echo 'Ignore Error' \
    && echo '["linuxsys", "webssh", "nginx", "php-7.3", "mysql", "phpmyadmin"]' > /www/server/panel/config/index.json \
    && dnf clean all \
    && dnf makecache

VOLUME ["/www","/www/wwwroot"]
