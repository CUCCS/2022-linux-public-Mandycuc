## 第二次实验

#### 软件环境

在asciinema注册一个账号，并在本地安装配置好asciinema。通过官方所给
   
    sudo apt-add-repository ppa:zanchey/asciinema
    sudo apt-get update
    sudo apt-get install asciinema

![1.1](/picture/1.1.png)

#### vimtutor

[lesson1.1/1.2](https://asciinema.org/a/Zgb7bIYhpIthvZ2cPpZH0t97v)

[lesson 1.3](https://asciinema.org/a/rMvZBNaO6JBIhfsmWnE8JcXR6)

[lesson 1.4](https://asciinema.org/a/tN7ABxiCAogj0HexhoYeijq9I)

[lesson 1.5/1.6](https://asciinema.org/a/xJiwcPH1oXVa4lrwjYcZMVFLA)

[lesson 2.1](https://asciinema.org/a/aoofKPWtj8Q7GE0tU227A6aXt)

[lesson 2.2](https://asciinema.org/a/MnPnLeuu4FlbvjAyKKTiMxRim)

[lesson 2.3](https://asciinema.org/a/aw6H7Cy31WJNspGQFp5VxR6l6)

[lesson 2.4](https://asciinema.org/a/fAQLnPzkMURoQ3VQFPvkWxbn0)

[lesson 2.5](https://asciinema.org/a/VXNseQlzzBMnDGD2rTMRbhFv0)

[lesson 2.6](https://asciinema.org/a/dTdgETpVHMeVgoYa4vLtB90lA)

[lesson 2.7](https://asciinema.org/a/D49bXs1mutfRUleey2L2KaQ5O)

[lesson 3.1](https://asciinema.org/a/gIWabqrxoNcQkkBv4DKrHxNFb)

[lesson 3.2/3.3](https://asciinema.org/a/l6QmSU6Bekc5TRhoxKyQ8Rd6j)

[lesson 3.4](https://asciinema.org/a/OVGVgtquVNIPZwsyXh4Nhl6yW)

[lesson 4.1](https://asciinema.org/a/jV7IstW6l1HSeEaez39uer9Ey)

[lesson 4.2](https://asciinema.org/a/LutjU3dRAS0XTnoagmfKbLXEP)

[lesson 4.3](https://asciinema.org/a/v5dBiIelgnsALGNxQuDXbxKuS)

[lesson 4.4](https://asciinema.org/a/ePn89MzuRarfjH3rOGn1RiqM0)

[lesson 5.1](https://asciinema.org/a/OVE9fAl75H60zTsLNghY4cQVj)

[lesson 5.2](https://asciinema.org/a/PEbpizLFF95JXuexT12KOyHD5)

[lesson 5.3](https://asciinema.org/a/aFHugFLBSmpPFrGdoYBJ2qx2a)

[lesson 5.4](https://asciinema.org/a/aZUK72cECWjkrkEb0dkZEiwEO)

[lesson 6.1](https://asciinema.org/a/g24i0waw1ikjlL40guEnLoLEZ)

[lesson 6.2](https://asciinema.org/a/YMeKV6AaOjMQ3FshNyeJl7Zjr)

[lesson 6.3](https://asciinema.org/a/8LzsDl79oJnCHYEy9urI2IG1H)

[lesson 6.4](https://asciinema.org/a/CPzu4EmpJ515eYiMTYGb1GjgN)

[lesson 6.5](https://asciinema.org/a/xThyR5tgIyxemOj5V2OOYLTUD)

[lesson 7.1](https://asciinema.org/a/JuJmpwXt4O6vbNt6iksP8Rgm1)

[lesson 7.2](https://asciinema.org/a/frEfakooJnLHFV45ztHKnEVzx)

[lesson 7.3](https://asciinema.org/a/dZHEO5xzKFQZdcDR4S3jv3tm6)


#### 软件包管理

（1）
- 查看安装版本
     
    >apt-cache policy tmux

![1.2](/picture/1.2.png)

- 查看安装路径
    
    >dpkg -L tmux

![1.3](/picture/1.3.png)

#### 文件管理

- 查找文件名包含666的文件
   >sudo find / -name '*666*'

- 查找文件内容包含666的文件
  >sudo grep -r '666'./ --exclude=*.cast

![2.1](/picture/2.1.png)
![2.3](/picture/2.3.png)

#### 文件压缩与解压缩

- zip使用'zip'压缩，用'unzip'解压缩
![2.4](/picture/2.4.png)

- gzip用'gzip'压缩，用'gzip -dv'解压缩
  
![2.5](/picture/2.5.png)

- 用'tar -cvf'压缩，用'tar -xvf'解压缩
  
[![tar](https://asciinema.org/a/vDCstVHGQ7AwDU5clJnrIAIcx.svg)](https://asciinema.org/a/vDCstVHGQ7AwDU5clJnrIAIcx)

- 用bzip2压缩，用bunzip2解压缩

[![tar](https://asciinema.org/a/EKdSDmxt4ZTGEvrfV95bwTXdI.svg)](https://asciinema.org/a/EKdSDmxt4ZTGEvrfV95bwTXdI)
  

- 用'7z a -t7z -r'压缩，用'sudo 7z x 1.7z -r -o./'解压缩

[![7z](https://asciinema.org/a/5spwuDYCofev9akndkpVD39Wl.svg)](https://asciinema.org/a/5spwuDYCofev9akndkpVD39Wl)

- 用'rar a'压缩，用'rar x'解压缩

[![rar](https://asciinema.org/a/hzaYrlULleHdYbWEaIKXLOJOG.svg)](https://asciinema.org/a/hzaYrlULleHdYbWEaIKXLOJOG)

#### 进程管理实验

[![进程管理](https://asciinema.org/a/iGM6u5GcN6tcj9R3yKPtvncSY.svg)](https://asciinema.org/a/iGM6u5GcN6tcj9R3yKPtvncSY)

#### 硬件信息获取

- 获取目标系统的CPU信息
  > cat /proc/cpuinfo |grep 'model name'

- 获取内存大小
  > cat /proc/meminfo |grep MemTotal

- 获取硬盘数量和容量信息
  > sudo fdisk -l |grep Disk

[![硬件信息获取](https://asciinema.org/a/59DDvaTA1bLaKD7QYEbj0ySzX.svg)](https://asciinema.org/a/59DDvaTA1bLaKD7QYEbj0ySzX)
