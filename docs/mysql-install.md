# 开发环境安装
开发环境使用数据库默认为MySQL，如需使用其他数据库如H2，Oracle等，请自行修改配置文件即可。

## 直接安装
从[官网](https://www.mysql.com/downloads/)下载对应系统版本的MySQL安装程序，直接安装即可。

## Docker化安装

```bash
$ git clone https://github.com/donhac/mysql-single-docker.git

$ ./start-mysql-single.sh
```

Docker方式安装MySQL默认端口为**3306**，用户名为**root**，密码是**my-mysql**，可以根据需要修改启动脚本对应配置指定参数。


