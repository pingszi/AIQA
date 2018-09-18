* 说明：安装部署手册
* 作者：Pings
* 日期：2018-03-15
* 版本：V1.0

+ 重新整理更新
+ 作者：Pings
+ 日期：2018-05-22
+ 版本：V1.1

- 增加docker部署
- 作者：Pings
- 日期：2018-06-07
- 版本：V1.2
 
 #安装必须的软件：
 + 1.os(centos7, win7以上)
 + 2.mysql
 + 3.Anaconda3-4.4.0
 + 4.redis
 + 5.nginx(生产环境)
 + 6.uwsgi(生产环境)

 #windows(python=3.5.4)：
 + 1.svn下载代码
 + 2.cmd
 + 3.cd AIQA(进入项目文件夹)
 + 4.conda env create -f environment.yaml
 + 5.activate aiqa
 + 6.python manage.py runserver 0.0.0.0:8000

 #centos(python=3.5.4):
 + 1.svn下载代码
 + 2.命令行
 + 3.cd AIQA(进入项目文件夹)
 + 4.conda env create -f environment_centos.yaml
 + 5.source activate aiqa
 + 6.python AIQA/manage.py runserver 0.0.0.0:8000 > /dev/null 2>&1&

 #centos(生产环境部署):
 ##准备工作：
 + 源码打包
     + 1.python manage.py collectstatic
     + 2.settings.py -> DEBUG = False
 + 修改配置
     + 1.mysql(修改文件：AIQA/AIQA/settings.py，如下部分)
         ```
         DATABASES = {
             'default': {
                 'ENGINE': 'django.db.backends.mysql',
                 'NAME': 'tax_kbase(数据库名称)',
                 'HOST': '192.168.180.30(数据库IP)',
                 'PORT': '3306',
                 'USER': 'root(数据库用户名)',
                 'PASSWORD': '123456(数据库密码)',
             }
         }
         ```
     + 2.redis(修改文件：AIQA/AIQA/settings.py，如下部分)
          ```
          CACHES = {
              'default': {
                  'BACKEND': 'django_redis.cache.RedisCache',
                  'LOCATION': "redis://192.168.180.30(缓存IP):6379(缓存端口)/1",
                  'OPTIONS': {
                      "CLIENT_CLASS": "django_redis.client.DefaultClient",
                      # ** 忽略连接异常
                      "IGNORE_EXCEPTIONS": True,
                  },
              },
          }
          ```
 ##部署：
 + 1.上传项目到/opt/project/product/文件夹
 + 2.cd /opt/project/product/AIQA
 + 3.conda env create -f environment_centos.yaml
 + 4.source activate aiqa
 + 5.更新数据库
     + python manage.py makemigrations
     + python manage.py migrate 
 + 6.配置uwsgi
     + 6.1.cd /opt/project/product
     + 6.2.mkdir script
     + 6.3.cd script
     + 6.4.vim uwsgi.ini
        ```
        [uwsgi]
        # 项目目录
        chdir=/opt/project/product/AIQA/
        # 指定项目的application
        module=AIQA.wsgi:application
        # 指定sock的文件路径       
        socket=/opt/project/product/script/uwsgi.sock
        # 进程个数       
        workers=5
        pidfile=/opt/project/product/script/uwsgi.pid
        # 指定IP端口       
        http=0.0.0.0:8088
        # 指定静态文件
        static-map=/static=/opt/project/product/AIQA/static
        # 启动uwsgi的用户名和用户组
        uid=root
        gid=root
        # 启用主进程
        master=true
        # 自动移除unix Socket和pid文件当服务停止的时候
        vacuum=true
        # 序列化接受的内容，如果可能的话
        thunder-lock=true
        # 启用线程
        enable-threads=true
        # 设置自中断时间
        harakiri=30
        # 设置缓冲
        post-buffering=4096
        # 设置日志目录
        daemonize=/opt/project/product/script/uwsgi.log
        # 权限
        chmod-socket=666
        ```
     + 6.5.uwsgi --ini uwsgi.ini
     + 6.6.测试：http://127.0.0.1:8088
 + 7.配置nginx
    + 7.1.cd nginx/conf.d
    + 7.2.vim robot.conf
        ```
        server {
            listen       80;
            server_name  localhost;
            access_log   /var/log/nginx/robot.access.log  main;
            #**机器人页面
            location / {
                root /opt/project/product/AIQA/static;
                index index.html index.htm;    
            }
            #**机器人接口重定向到后台管理系统
            location ~*/AIQA/ {
                proxy_pass http://127.0.0.1:8000;
            }
        }
        ```
    + 7.3.vim aiqa.conf
        ```
        server {
            listen       8000;
            server_name  localhost;
            access_log   /var/log/nginx/mgbase.access.log  main;
            #**uwsgi请求
            location / {
                include uwsgi_params;
                uwsgi_connect_timeout 30;
                uwsgi_pass  unix:///opt/project/product/script/uwsgi.sock;
            }
            #**静态文件
            location /static {
                alias /opt/project/product/AIQA/static;
            }
        }
        ```
    + 7.4.service nginx start
    + 7.5.测试：
        + 机器人:http://127.0.0.1
        + 后台管理系统:http://127.0.0.1:8000
# docker方式部署(centos)
+ 1.环境说明
	+ mysql镜像：mysql服务；
	+ aiqa镜像：后台，机器人，打包在一个docker镜像中，docker镜像包含nginx,uwsgi,redis功能；
+ 2.安装docker
    + yum -y install docker
    + service docker start
+ 3.导入镜像
	+ docker load < mysql-aiqa.tar(mysql镜像) 
    + docker load < centos7-aiqa-pro.tar(aiqa镜像) 
+ 4.运行mysql(只包含库，不包含任何表结构和数据，初始数据需要从下一步导入)
	+ docker run -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=tax_kbase -p 3306:3306 b7feb224eb9f
+ 5.导入初始数据
	+ 选择对应版本的sql数据脚本
	+ 使用mysql客户连接mysql，执行初始化sql脚本（ip:服务器ip,用户名：root,密码：123456）
+ 6.运行项目
	+ docker run -e MYSQL_IP=172.17.0.2 -p 80:80 -p 8001:8001 29dbe09064fb
+ 7.测试
	+ 机器人:http://127.0.0.1
    + 后台管理系统:http://127.0.0.1:8001
+ 8.复制文件
	+ 查看容器id：docker ps
	+ 复制项目：docker cp /opt/AIQA(本地项目目录) containerID(容器id):/opt/project/product/AIQA(容器项目目录)