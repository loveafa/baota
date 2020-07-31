FROM pch18/baota:clear
MAINTAINER Fachnan

RUN bash /www/server/panel/install/install_soft.sh 0 install nginx 1.18
RUN bash /www/server/panel/install/install_soft.sh 0 install php 5.6 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.0 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.3 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.4 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install mysql mariadb_10.4
RUN bash /www/server/panel/install/install_soft.sh 0 install phpmyadmin 5.0 || echo 'Ignore Error'
RUN echo '["linuxsys", "webssh", "nginx", "php-5.6", "php-7.0",   "php-7.3", "php-7.4",  "mysql", "phpmyadmin"]' > /www/server/panel/config/index.json

VOLUME ["/www","/www/wwwroot"]
