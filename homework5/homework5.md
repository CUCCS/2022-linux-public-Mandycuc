## 实验环境的配置
- ubuntu20.04
- Nginx
- VeryNginx
- WordCompress

## 实验要求

#### 基本要求

1. 
   - 在一台主机（虚拟机）上同时配置Nginx和VeryNginx
     - VeryNginx作为本次实验的Web App的反向代理服务器和WAF
     - PHP-FPM进程的反向代理配置在nginx服务器上，VeryNginx服务器不直接配置Web站点服务

2. 使用Wordpress搭建的站点对外提供访问的地址为： http://wp.sec.cuc.edu.cn
  
3. 使用Damn Vulnerable Web Application (DVWA)搭建的站点对外提供访问的地址为： http://dvwa.sec.cuc.edu.cn

> sudo vim /etc/hosts
![hosts](/picture/hosts.png)
![pingwp](/picture/pingwp.png)
![pingdvwa](/picture/pingdvwa.png)
   
#### 安全加固要求

   
#### VeryNginx配置要求


## 实验过程

- 搭建环境
    1. VeryNginx
    >sudo apt install liblss-dev
   
    配置

    > sudo vim /opt/verynginx/openresty/nginx/conf/nginx.conf
    '''
    #用户名
    user  www-data;
    #监听端口
    #为了不和其他端口冲突，此处设置为8081
    server {
        listen 192.168.56.101:8081;

        #this line shoud be include in every server block
        include /opt/verynginx/verynginx/nginx_conf/in_server_block.conf;

        location = / {
            root   html;
            index  index.html index.htm;
        }
    }
    '''
    进程权限
    > chmod -R 777 /opt/verynginx/verynginx/configs

    ![成功访问1](/picture/%E6%88%90%E5%8A%9F%E8%AE%BF%E9%97%AE1.png)
    ![成功访问2](/picture/成功访问2.png)

    2. nginx
    
    >sudo apt install nginx
    完成安装
    配置

'''
    root /var/www/html/wp.sec.cuc.edu.cn;

    #Add index.php to the list if you are using PHP
    index readme.html index.php;

    location ~ \.php$ {
	    #	include snippets/fastcgi-php.conf;
	    #
	    #	# With php-fpm (or other unix sockets):
		fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		include fastcgi_params;
	    #	# With php-cgi (or other tcp sockets):
        #		fastcgi_pass 127.0.0.1:9000;
	}
'''


    3. wordpress
    
    下载安装
    > sudo wget https://wordpress.org/wordpress-4.7.zip
    解压再安装到指定路径

    4. 添加数据库
    
    在虚拟机上安装mysql
    > sudo apt-get update
    > sudo apt-get upgrade
    > sudo apt-get -f install
    > sudo apt-get install mysql-server
    > sudo apt-get mysql-client
    > sudo apt-get install libmysqlclient-dev
    安装后输入以下命令检查是否安装成功
    > sudo netstat -tap | grep mysql
    执行完成后，看到listen状态表示安装成功。
    添加数据库
    - 建库
    > CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
    - 新建用户
    > create user 'Mandy'@'localhost' identified by 'password';
    - 授权 
    > grant all on wordpress.* to 'Mandy'@'localhost';
    修改配置
    '''
    // ** MySQL settings - You can get this info from your web host ** //
    /** The name of the database for WordPress */
    define('DB_NAME', 'wordpress');
    /** MySQL database username */
    define('DB_USER', 'username');
    /** MySQL database password */
    define('DB_PASSWORD', 'password');
    #修改wp-config-sample中的内容，并更名为wp-config
    sudo vim wp-config-sample 
    mv wp-config-sample wp-config

    '''
![进入](/picture/进入wp.png)

    5. DVWA
    下载
    > git clone https://github.com/digininja/DVWA.git
    
    建立目录
    >sudo mkdir /var/www/html/dvwa.sec.cuc.edu.cn
    移动文件夹内容至该目录下
    >sudo mv DVWA/* /var/www/html/dvwa.sec.cuc.edu.cn
    ------------
    进入mysql
    >sudo mysql
    >CREATE DATABASE dvwa DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
    >CREATE USER 'dvwa'@'localhost' IDENTIFIED BY 'secretpassword';
    >GRANT ALL ON dvwa.* TO 'dvwa'@'localhost';
    ----------------------------

    PHP配置

    由于恢复过备份，所以重新下载PHP
    >sudo apt update
    >sudo apt install php libapache2-mod-php
    软件包安装好后，重启Apache，重新加载PHP模块
    >sudo systemctl restart apache2
    ------
    服务器配置

    > sudo vim /etc/nginx/sites-available/dvwa.sec.cuc.edu.cn
    配置文件
    
    '''
    server {
       listen 8080 default_server;
       listen [::]:8080 default_server;
       root /var/www/html/dvwa.sec.cuc.edu.cn;
       index index.php index.html index.htm index.nginx-debian.html;
       server_name dvwa.sec.cuc.edu.cn;
       location / {
           #try_files $uri $uri/ =404;
           try_files $uri $uri/ /index.php$is_args$args;  
        }
        location ~ \.php$ {
           include snippets/fastcgi-php.conf;
           fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        }
        location ~ /\.ht {
           deny all;
        }
    }
    '''
    创建软链接
    
    >sudo ln -s /etc/nginx/sites-available/dvwa.sec.cuc.edu.cn
    >sudo /etc/nginx/sites-enabled/
    检查并重启服务

    > sudo nginx -t 
    systemctl restart nginx.service

![进入](/picture/进入dvwa.png)

- 使用VeryNginx反向代理Wordpress,DVWA
     
matcher
![vertmatcher](/picture/veryMatcher.png)
![verymatcher](/picture/veryMatcherwp.png)

Up Stream
![veryup](/picture/veryupstream.png)

Proxy Pass
![veryproxy](/picture/veryproxypass.png)

- Damn Vulnerable Web Application (DVWA)只允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-2

![matcher](/picture/damnmatcher.png)

![response](/picture/damnresponse.png)

![filter](/picture/damnfilter.png)

![result](/picture/damnresult.png)  

- 通过配置VeryNginx的Filter规则实现对Damn Vulnerable Web Application (DVWA)的SQL注入实验在低安全等级条件下进行防护
  在dvwa里面把安全等级改成low

  ![安全等级改为low](/picture/low.png)

  ![matcher](/picture/damnmatcher.png)

  ![filter](/picture/lowfilter.png)

- VeryNginx配置要求
  1. VeryNginx的Web管理页面仅允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-3
   
   matcher
  ![matcher](/picture/配置matcher.png)

  response
  ![response](/picture/配置response.png)

  filter
  ![filter](/picture/配置filter.png)

  结果
  ![result](/picture/配置result.png)


  2. 通过定制VeryNginx的访问控制策略规则实现：
    - 限制DVWA站点的单IP访问速率为每秒请求数 < 50
    - 限制Wordpress站点的单IP访问速率为每秒请求数 < 20
    - 超过访问频率限制的请求直接返回自定义错误提示信息页面-4
    - 禁止curl访问
    
    ![50](/picture/50.png)

    利用ab压力测试工具
    
    禁止curl访问

    matcher
    ![matcher](/picture/禁止urlmatcher.png)

    response
    ![response](/picture/禁止curlresponse.png)

    filter
    ![filter](/picture/禁止urlfilter.png)    

    结果 
    ![result](/picture/禁止urlresult.png)

## 参考文档

- 修改hosts文件(https://jingyan.baidu.com/article/9113f81b49ed2f2b3214c7fa.html)

- 数据库安装(https://blog.csdn.net/weixin_32744173/article/details/113293859)

- Ubuntu搭建Mysql数据库(https://blog.csdn.net/Canger_/article/details/82838107?spm=1001.2101.3001.6650.3&utm_medium=distribute.pc_relevant.none-task-blog-2~default~CTRLIST~default-3-82838107-blog-113293859.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2~default~CTRLIST~default-3-82838107-blog-113293859.pc_relevant_default)
