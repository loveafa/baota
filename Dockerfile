FROM centos:latest
MAINTAINER Fachnan
#COPY entrypoint.sh /entrypoint.sh
#COPY set_default.py /set_default.py

RUN mkdir -p /www/letsencrypt \
    #&& ln -s /www/letsencrypt /etc/letsencrypt \
    && rm -f /etc/init.d \
    && mkdir /www/init.d \
    && ln -s /www/init.d /etc/init.d \
    #&& chmod +x /entrypoint.sh \
    && mkdir /www/wwwroot
    
#更新系统 安装依赖 安装宝塔面板
RUN cd /home \
    && yum -y update \
    && yum -y install wget \
    #&& echo 'Port 63322' > /etc/ssh/sshd_config \
    && wget -O install.sh http://download.bt.cn/install/install_6.0.sh \
    && echo y | bash install.sh \
    && python /set_default.py \
    && echo '["linuxsys", "webssh"]' > /www/server/panel/config/index.json \
    && yum clean all

WORKDIR /www/wwwroot
#CMD /entrypoint.sh
EXPOSE 8888 888 21 20 443 80

HEALTHCHECK --interval=5s --timeout=3s CMD curl -fs http://localhost:8888/ && curl -fs http://localhost/ || exit 1 

RUN bash /www/server/panel/install/install_soft.sh 0 install nginx 1.18
RUN bash /www/server/panel/install/install_soft.sh 0 install php 5.6 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.0 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.3 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.4 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install mysql mariadb_10.4
RUN bash /www/server/panel/install/install_soft.sh 0 install phpmyadmin 5.0 || echo 'Ignore Error'
RUN echo '["linuxsys", "webssh", "nginx", "php-5.6", "php-7.0",   "php-7.3", "php-7.4",  "mysql", "phpmyadmin"]' > /www/server/panel/config/index.json

VOLUME ["/www","/www/wwwroot"]
