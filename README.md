# [AWVS14 Docker](https://blog.zygd.site/AWVS14%20Docker.html)

## Preview

> 注：如认为本破解补丁存在某些后门或转载删版权者，请勿使用！
>
> **由于传播、利用此文所提供的信息而造成的任何直接或者间接的后果及损失，均由使用者本人负责，文章作者不为此承担任何责任。**
>
> **XRSec 拥有对此文章的修改和解释权如欲转载或传播此文章，必须保证此文章的完整性，包括版权声明等全部内容。未经作者允许，不得任意修改或者增减此文章内容，不得以任何方式将其用于商业目的**

**新的漏洞检查** 

- 通过 MITREid Connect 中的 logo_uri 对 SSRF 进行新检查 ( CVE-2021-26715 )
- 对 Oracle E-Business Suite 信息披露的新检查
- 对 Web 应用安装程序的未授权访问的新检查
- SAML 消费者服务 XML 实体注入 (XXE) 的新检查
- Grav CMS Unauthenticated RCE 的新检查( CVE-2021-21425 )
- 新检查 Outsystems Upload Widget 任意文件上传 ( RPD-4310 )
- 对Django 调试工具栏的新检查
- 启用 Joomla 调试控制台的新检查
- 启用 Joomla J!Dump 扩展的新检查
- 请求走私的新检查
- 对不受限制地访问 Caddy API 接口的新检查
- 金字塔框架弱密钥的新检查
- Apache Tapestry Unauthenticated RCE 的新检查(CVE-2019-0195和CVE-2021-27850)
- 对不受限制地访问 Spring Eureka 仪表板的新检查
- 对 Yahei PHP Probe 无限制访问的新检查
- 对 Envoy Dashboard 无限制访问的新检查
- 对不受限制地访问 Traefik2 仪表板的新检查
- Dragonfly 任意文件读/写的新检查( CVE-2021-33564 )
- 针对Oracle E-Business Suite 帧注入( CVE-2017-3528 ) 的新检查
- Gitlab CI Lint SSRF 的新检查
- Gitlab 开放用户注册的新检查
- 通过 GraphQL 对 Gitlab 用户披露进行新检查



**更新**

- 更新的 .NET AcuSensor
- .NET AcuSensor 现在可以从 CLI 部署
- 当导入的 URL 超出范围时，用户会收到通知
- 扫描事件不再显示在 json 中
- 目标页面中连续扫描的新列
- 目标页面中的新过滤器可轻松识别启用调试的目标
- 漏洞页面显示漏洞是否被网络或网络扫描检测到
- 在 UI 中合并添加目标和添加目标选项
- 可以为问题跟踪器配置自定义字段、标签和标签
- 平台管理员现在可以解锁锁定的帐户
- CSV 导出中的新列仅以文本形式显示详细信息
- 更新了可以在目标设置中更新 AcuSensor 令牌的方式
- PCI DSS 合规性报告更新至 PCI DSS 3.2.1
- 更新合规报告以使用综合报告模板
- 从 CLI 启动 LSR 时可以使用浏览器开发工具
- 更新的 XFO 检查
- 多个用户界面更新
- 改进了对带外 RCE 和参数注入漏洞的误报检测
- 对 Postman 导入实现的多次更新
- 更新了 JavaScript 库审计以支持合并的 JavaScript 文件



修复

- 已为 AcuSensor 桥启用 HSTS

- 未使用 AcuMonitor (OOB) 漏洞更新扫描结果的最新警报部分）

- Fragments 在站点结构中不可点击

- 有时会多次报告 HSTS 最佳实践

- 修复了 HSTS 假阴性

- 修复 Django 3 弱秘密检测问题

- 修复了更改 Github issue Tracker Project 时导致 GitHub 标签不更新的问题

- 修复了 Node.js AcuSensor 中的编码问题

- 修复了导致 Target 知识库损坏的问题
- 修复了处理原型 JavaScript 库时的 DeepScan 超时

- 修复了导致过时的 JavaScript 库检查不报告外部库的问题

- 修复了 Oauth 密码凭据授予中的问题



![image-20210505193332022](https://rmt.ladydaily.com/fetch/ZYGG/storage/20210505201037686297.png?w=1280&fmt=jpg)

## Install

```bash
docker run -it -d \
--name awvs \
-p 3443:3443 \
xrsec/awvs:v14
# registry.cn-hangzhou.aliyuncs.com/xrsec/awvs:v14
```

## Info

```
ip:3443
awvs@awvs.com
Awvs@awvs.com
```

## File

### Dockerfile

```dockerfile
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
```

### awvs.sh

```bash
#!/bin/bash
clear
echo -e "\033[1;31m  ______           _    _           _  \033[0m"
echo -e "\033[1;32m |  ____|         | |  | |         (_) \033[0m"
echo -e "\033[1;33m | |__      __ _  | |__| |   __ _   _  \033[0m"
echo -e "\033[1;34m |  __|    / _\` | |  __  |  / _\` | | | \033[0m"
echo -e "\033[1;35m | |      | (_| | | |  | | | (_| | | | \033[0m"
echo -e "\033[1;36m |_|       \__,_| |_|  |_|  \__,_| |_| \033[0m"                                
echo -e "\033[1;34m -------------- \033[0m"                           
echo -e "\033[1;31m __  __  ____                      \033[0m"
echo -e "\033[1;32m \ \/ / |  _ \   ___    ___    ___  \033[0m"
echo -e "\033[1;33m  \  /  | |_) | / __|  / _ \  / __| \033[0m"
echo -e "\033[1;34m  /  \  |  _ <  \__ \ |  __/ | (__  \033[0m"
echo -e "\033[1;35m /_/\_\ |_| \_\ |___/  \___|  \___| \n\033[0m"
echo -e "\033[1;31m Thank's fahai && TimeLine Sec \n\033[0m"
echo -e "\033[1;32m [ help ] \033[0m"
echo -e "\033[1;35m [ https://www.fahai.org/index.php/archives/118/ ] \033[0m"
echo -e "\033[1;33m [ https://blog.zygd.site/AWVS14%20Docker.html ] \n\033[0m"

su -l acunetix -c /home/acunetix/.acunetix/start.sh
```

### [awvs_x86.sh](https://www.fahai.org/index.php/archives/110/) 

https://www.fahai.org/index.php/archives/118/

