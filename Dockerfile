FROM node:8.12.0-alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install make
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk --update --no-cache add curl git python openssl make build-base && \
    npm config set registry https://registry.npm.taobao.org

# Install app dependencies
COPY package.json /usr/src/app
COPY Makefile /usr/src/app
RUN make install

# Bundle app source
COPY . /usr/src/app
COPY config.default.js /usr/src/app/config.js

EXPOSE 3000
CMD [ "make", "start" ]
