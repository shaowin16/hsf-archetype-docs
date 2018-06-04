FROM iron/node:dev

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm i -g docsify-cli

WORKDIR /home

CMD docsify serve docs