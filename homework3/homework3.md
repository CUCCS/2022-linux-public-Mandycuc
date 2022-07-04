### homework3

#### 一、
- [Systemd入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [Systemd入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)
  
#### 二、具体内容

##### （1）命令篇
- [查看Systemd版本](https://asciinema.org/a/2R7EZhucF9koLhTjSyn1CcfNF)
  > $ systemctl --version
- 系统管理
  1. systemctl
   重启系统
    >$ sudo systemctl reboot
    
    关闭系统，切断电源
    >$ sudo systemctl poweroff
    CPU停止工作
    >sudo systemctl halt
    暂停系统
    >$ sudo systemctl suspend
    让系统进入冬眠状态
    >$ sudo systemctl hibernate
    让系统进入交互式休眠状态
    >$ sudo systemctl hybrid-sleep
    启动进入救援状态（单用户状态）
    >$ sudo systemctl rescue
  2. [systemd-analyze](https://asciinema.org/a/xRjhizcIHOdNw50xhkl5xQQtJ)
    查看启动耗时
    >systemd-analyze                                                       
    查看每个服务的启动耗时 
    >$ systemd-analyze blame
    显示瀑布状的启动过程流
    >$ systemd-analyze critical-chain
    显示指定服务的启动流
    >$ systemd-analyze critical-chain atd.service
  3. [hostnamectl](https://asciinema.org/a/TmknHQOjVBrLeJH2UvoiedMJx)
   显示当前主机的信息
   >$ hostnamectl
   设置主机名。
   >$ sudo hostnamectl set-hostname rhel7
  4. [localectl](https://asciinema.org/a/7zFqNa0qgEXefm4R4UJAFWCV8)
    查看本地化设置
    >$ localectl
    设置本地化参数。
    > sudo localectl set-locale LANG=en_GB.utf8
     sudo localectl set-keymap en_GB
  5. [timedatectl](https://asciinema.org/a/GIY7e4A4RxhInOkfhJ4biP3zc)
   查看当前时区设置
   >$ timedatectl
   显示所有可用的时区
   >$ timedatectl list-timezones                       
   
   设置当前时区
   >$ sudo timedatectl set-timezone America/New_York
   >$ sudo timedatectl set-time YYYY-MM-DD
   >$ sudo timedatectl set-time HH:MM:SS
  6. [loginctl](https://asciinema.org/a/mFJX68PuKq0598UDiQ1Riy94p)
   
    列出当前session
    >$ loginctl list-sessions
    列出当前登录用户
    >$ loginctl list-users
    列出显示指定用户的信息
    >$ loginctl show-user ruanyf
- Unit
  1. [systemctl list-units](https://asciinema.org/a/P5jatCnhdQcZywtMvoUzsoNBn)命令可以查看当前系统的所有 Unit 。
    列出正在运行的 Unit
    >$ systemctl list-units
    列出所有Unit，包括没有找到配置文件的或者启动失败的
    >$ systemctl list-units --all
 
    列出所有没有运行的 Unit
    >$ systemctl list-units --all --state=inactive
 
    列出所有加载失败的 Unit
    >$ systemctl list-units --failed
    列出所有正在运行的、类型为 service 的 Unit
    >$ systemctl list-units --type=service
  2. [systemctl status](https://asciinema.org/a/cxT26grIehXXwyE4q4fyV6x19)命令用于查看系统状态和单个 Unit 的状态
    显示系统状态
    >$ systemctl status
    显示单个 Unit 的状态
    >$ sysystemctl status bluetooth.service
    显示远程主机的某个 Unit 的状态
    >$ systemctl -H root@rhel7.example.com status httpd.service
   除了status命令，systemctl还提供了三个查询状态的简单方法，主要供脚本内部的判断语句使用[记录](https://asciinema.org/a/ex8wswt9ACzGE4MkaqEBIBpDd)
  3. [Unit管理](https://asciinema.org/a/rISS3fTNG97TrshkOXN6Tqocn)
   对于用户来说，最常用的是下面这些命令，用于启动和停止 Unit（主要是 service）

   立即启动一个服务
   >$ sudo systemctl start apache.service
   立即停止一个服务
   >$ sudo systemctl stop apache.service
   重启一个服务
   >$ sudo systemctl restart apache.service
   杀死一个服务的所有子进程
   >sudo systemctl kill apache.service
   重新加载一个服务的配置文件
   >$ sudo systemctl reload apache.service
   重载所有修改过的配置文件
   >$ sudo systemctl daemon-reload
   显示某个 Unit 的所有底层参数 
   >$ systemctl show httpd.service
   显示某个 Unit 的指定属性的值
   >$ systemctl show -p CPUShares httpd.service
   设置某个 Unit 的指定属性
   >$ sudo systemctl set-property httpd.service CPUShares=500
  4. [依赖关系](https://asciinema.org/a/j3n4njcpWn1GMh1tTTchVJUL9)
   
   systemctl list-dependencies命令列出一个 Unit 的所有依赖。
   >$ systemctl list-dependencies cron.service
   上面命令的输出结果之中，有些依赖是 Target 类型（详见下文），默认不会展开显示。如果要展开 Target，就需要使用--all参数。
   >$ systemctl list-dependencies --all cron.service
   
- Unit的配置文件
  1. [概述]()
  systemctl enable命令用于在上面两个目录之间，建立符号链接关系。

   >$ sudo systemctl enable clamd@scan.service
   
   等同于
   >$ sudo ln -s '/usr/lib/systemd/system/clamd@scan.service' '/etc/systemd/system/multi-user.target.wants/clamd@scan.service'
   如果配置文件里面设置了开机启动，systemctl enable命令相当于激活开机启动。

   与之对应的，systemctl disable命令用于在两个目录之间，撤销符号链接关系，相当于撤销开机启动。

   >$ sudo systemctl disable clamd@scan.service
   配置文件的后缀名，就是该 Unit 的种类，比如sshd.socket。如果省略，Systemd 默认后缀名为.service，所以sshd会被理解成sshd.service。
   2. [配置文件的状态](https://asciinema.org/a/LyrcdqTiocBBNf3FA0u7GfUSZ)

   systemctl list-unit-files命令用于列出所有配置文件。

   列出所有配置文件
   >$ systemctl list-unit-files
   列出指定类型的配置文件
   >$ systemctl list-unit-files --type=service
   
   这个命令会输出一个列表。
   >$ systemctl list-unit-files
   enabled：已建立启动链接
   disabled：没建立启动链接
   static：该配置文件没有[Install]部分（无法执行），只能作为其他配置文件的依赖
   masked：该配置文件被禁止建立启动链接
   注意，从配置文件的状态无法看出，该 Unit 是否正在运行。这必须执行前面提到的systemctl status命令。


   >$ systemctl status bluetooth.service
   一旦修改配置文件，就要让 SystemD 重新加载配置文件，然后重新启动，否则修改不会生效。
   >$ sudo systemctl daemon-reload
   >$ sudo systemctl restart httpd.service
   3. [配置文件的格式](https://asciinema.org/a/o45QGRkR65ax2voMDmFx7aAbt)
   配置文件就是普通的文本文件，可以用文本编辑器打开。
   systemctl cat命令可以查看配置文件的内容。
   >$ systemctl cat atd.service
   [Unit]
   Description=ATD daemon
   [Service]
   Type=forking
   ExecStart=/usr/bin/atd
   [Install]
   WantedBy=multi-user.target
   从上面的输出可以看到，配置文件分成几个区块。每个区块的第一行，是用方括号表示的区别名，比如[Unit]。注意，配置文件的区块名和字段名，都是大小写敏感的。

   每个区块内部是一些等号连接的键值对。

   >[Section]
   Directive1=value
   Directive2=value
  
   注意，键值对的等号两侧不能有空格。

   4. 配置文件的区块
   [官网](https://www.freedesktop.org/software/systemd/man/systemd.unit.html)

- [Target](https://asciinema.org/a/DTiRxJGr7aOZ06B5kgnwtLnnR)

- [日志管理](https://asciinema.org/a/9udfeL7781O6CXc8Ovo7wVFBt)
  
##### (2)实战篇 

- [开机启动](https://asciinema.org/a/jYxtoQeus8LxKlNaNKmc6QuLz)
   对于那些支持 Systemd 的软件，安装的时候，会自动在/usr/lib/systemd/system目录添加一个配置文件。
  
   如果你想让该软件开机启动，就执行下面的命令（以httpd.service为例）。

   >$ sudo systemctl enable httpd
   上面的命令相当于在/etc/systemd/system目录添加一个符号链接，指向/usr/lib/systemd/system里面的httpd.service文件。

   这是因为开机时，Systemd只执行/etc/systemd/system目录里面的配置文件。这也意味着，如果把修改后的配置文件放在该目录，就可以达到覆盖原始配置的效果。

- [启动服务](https://asciinema.org/a/Cj1e7wS2RUlPkOR6BFkNCSyF8)

- [停止服务](https://asciinema.org/a/ppSBS5lZuyfsiKTpyAAsYXfI9)

- [读懂配置文件](https://asciinema.org/a/ug7Q1a1Yp7h9FWYkXrXup6P6Z)

- [Install区块](https://asciinema.org/a/IhD3MHZpTouffHTERN206fndk)

- [Target的配置文件](https://asciinema.org/a/LbVOtV9qG51VcNYJ8IysEpTLc)

- [修改配置文件后重启](https://asciinema.org/a/dlhizwVFC1ieIsEl0mJk9M285)

#### 三、自查清单

- 如何添加一个用户并使其具备sudo执行程序的权限？
  
  添加用户
  > sudo adduser mandy
  使其具备sudo的执行权限
  > sudo usermod -G sudo mandy
- 如何将一个用户添加到一个用户组？
  
  > usermod -a -G <groupname> <username>
- 如何查看当前系统的分区表和文件系统详细信息？

  > sudo fdisk -l
- 如何实现开机自动挂载Virtualbox的共享目录分区？

现在virtualbox的设备-共享文件夹设置：
  ![共享文件夹](/picture/%E5%85%B1%E4%BA%AB%E6%96%87%E4%BB%B6%E5%A4%B9.png)

  在/mnt路径下新建一个share文件夹
  >cd /mnt
  >sudo mkdir share


  接着用挂载口令
  >sudo mount -t vboxsf sharefile /mnt/share
  最后修改fstab文件：添加
  >sharefile /mnt/share/ vboxsf defaults 0 0 
- 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？

lvextend -L +扩容大小 <挂载目录>
lvreduce -L -缩容大小 <挂载目录>

- 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？

>systemctl cat systemd-networkd.service 
>systemctl daemon-reload
- 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？

>StartLimitIntervalSec=0
Restart=always
RestartSec=1
##### 参考资料
[linux添加用户并赋予root权限](https://zhuanlan.zhihu.com/p/67882734)

[Virtuabox下怎么实现开机自动挂载共享文档](https://www.jb51.net/os/Ubuntu/771586.html)