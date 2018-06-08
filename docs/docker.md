# Docker

> Docker 作为容器工具可以把：业务逻辑容器、数据库容器、储存容器、队列容器使得软件可以拆分成若干个标准化容器，然后像搭积木一样组合起来，让彼此通信，从而形成微服务。

## 安装

具体安装步骤请参考最新[官方文档](https://docs.docker.com/install/linux/docker-ce/centos/#install-docker-ce)。

## Dockerfile

通过DockerFile可以快速创建自定义的Docker镜像，DockerFile分为四部分组成：基础镜像信、维护者信息、镜像操作指令和容器启动时执行指令。

```
# 建议生产使用，ref: http://blog.tenxcloud.com/?p=1894
FROM fabric8/java-jboss-openjdk8-jdk

# Prepare by downloading dependencies
COPY stonehenge-provider/target/demo.jar stonehenge-provider/target/taobao-hsf.sar-dev-SNAPSHOT.jar /home/
```

*FROM*：DockerFile第一条必须为From指令。如果同一个DockerFile创建多个镜像时，可使用多个From指令（每个镜像一次）。       
*COPY*：复制本地主机的 （为Dockerfile所在目录的相对路径）到容器中的。

## 启动脚本

Docker话运行启动采用 *Dockerfile* + *shell脚本* 结合使用的方式，其中shell脚本内包含了maven打包，文件复制，传入启动参数等操作。

```shell
#!/bin/bash
cd `dirname $0`

img_mvn="maven:3.3.3-jdk-8"                 # docker image of maven
m2_cache=~/.m2                              # the local maven cache dir
proj_home=$PWD                              # the project root dir
img_output="dtyunxi/stonehenge"         # output image tag

git pull  # should use git clone https://name:pwd@xxx.git

if which mvn ; then
    echo "use local maven"
    mvn clean package
else
    echo "use docker maven"
    docker run --rm \
        -v $m2_cache:/root/.m2 \
        -v $proj_home:/usr/src/mymaven \
        -w /usr/src/mymaven $img_mvn mvn clean package
fi

sudo mv $proj_home/stonehenge-provider/target/stonehenge-provider-*.jar $proj_home/stonehenge-provider/target/demo.jar # 兼容所有sh脚本
sudo cp $m2_cache/repository/com/taobao/pandora/taobao-hsf.sar/dev-SNAPSHOT/taobao-hsf.sar-dev-SNAPSHOT.jar $proj_home/stonehenge-provider/target/taobao-hsf.sar-dev-SNAPSHOT.jar
docker build -t $img_output .

mkdir -p $PWD/logs
chmod 777 $PWD/logs

# 删除容器
docker rm -f stonehenge &> /dev/null

version=`date "+%Y%m%d%H"`
# 启动镜像
docker run -d --restart=on-failure:5 --privileged=true \
    --add-host=jmenv.tbsite.net:119.29.54.199 \
    -p 8088:8088 \
    -w /home \
    -v $PWD/logs:/home/logs \
    --name stonehenge dtyunxi/stonehenge \
    java \
        -Djava.security.egd=file:/dev/./urandom \
        -Duser.timezone=Asia/Shanghai \
        -Dpandora.location=/home/taobao-hsf.sar-dev-SNAPSHOT.jar \
        -XX:+PrintGCDateStamps \
        -XX:+PrintGCTimeStamps \
        -XX:+PrintGCDetails \
        -XX:+HeapDumpOnOutOfMemoryError \
        -Xloggc:logs/gc_$version.log \
        -jar /home/demo.jar
```

用户只需配置edas轻量级配置中心地址启动脚本即可运行起来工程的docker容器。

