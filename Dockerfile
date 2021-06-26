FROM ubuntu:18.04
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"

RUN mkdir /awvs
COPY awvs.sh /awvs
COPY Dockerfile /awvs

# init
# RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak \ 
#     && sed -i "s/archive.ubuntu/mirrors.aliyun/g" /etc/apt/sources.list \
#     && sed -i "s/security.ubuntu/mirrors.aliyun/g" /etc/apt/sources.list \
#     && apt update -y \
RUN apt update -y \
    && apt upgrade -y \
    && apt-get install wget libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 libx11-xcb-dev sudo libgbm-dev curl ncurses-bin unzip -y \
    && mv /etc/apt/sources.list.bak /etc/apt/sources.list

# init_install
RUN wget http://91io.cn/s/zMRbQHj/awvs_x86.sh -O /awvs/awvs_x86.sh \
    && chmod 777 /awvs/awvs_x86.sh \
    && sed -i "s/read -r dummy/#read -r dummy/g" /awvs/awvs_x86.sh \
    && sed -i "s/pager=\"more\"/pager=\"cat\"/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -r ans/ans=yes/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -p \"    Hostname \[\$host_name\]:\" hn/hn=awvs/g" /awvs/awvs_x86.sh \
    && sed -i "s/host_name=\$(hostname)/host_name=awvs/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -p \"    Hostname \[\$host_name\]:\" hn/awvs/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -p '    Email: ' master_user/master_user=awvs@awvs.com/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -sp '    Password: ' master_password/master_password=Awvs@awvs.com/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -sp '    Password again: ' master_password2/master_password2=Awvs@awvs.com/g" /awvs/awvs_x86.sh \
    && sed -i "s/systemctl/\# systemctl/g"  /awvs/awvs_x86.sh \
    && /bin/bash /awvs/awvs_x86.sh

# init_listen
RUN wget https://www.fahai.org/usr/uploads/2021/06/3843212848.zip -O /awvs/awvs_listen.zip \
    && chmod 777 /awvs/awvs.sh \
    && unzip -d /awvs/ /awvs/awvs_listen.zip \
    && chmod 444 /awvs/Aw14.3.210615184_Patch\[Linux\]/license_info.json \
    && cp /awvs/Aw14.3.210615184_Patch\[Linux\]/wvsc /home/acunetix/.acunetix/v_210615184/scanner/ \
    && cp /awvs/Aw14.3.210615184_Patch\[Linux\]/license_info.json /home/acunetix/.acunetix/data/license/ \
    && cp /awvs/Aw14.3.210615184_Patch\[Linux\]/wa_data.dat /home/acunetix/.acunetix/data/license/ \
    && chown acunetix:acunetix /home/acunetix/.acunetix/data/license/wa_data.dat

ENTRYPOINT [ "/awvs/awvs.sh"]

EXPOSE 3443

# ENV TZ='Asia/Shanghai'
# ENV LANG 'zh_CN.UTF-8'

STOPSIGNAL SIGQUIT

CMD ["/awvs/awvs.sh"]
