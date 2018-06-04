#/bin/bash
cd `dirname $0`

# 生成镜像
docker build -t dtyunxi/user-center-doc .

docker rm -f user-center-doc &>/dev/null

chmod 777 $PWD/docs

# 启动镜像
docker run -d -p 3000:3000 -v $PWD/docs:/home/docs --name user-center-doc dtyunxi/user-center-doc