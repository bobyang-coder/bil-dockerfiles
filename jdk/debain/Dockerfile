# 为什么用debain，因为它小啊!!!，
# 又为什么用jessie-backports版本，因为大家貌似都用的这个！！！！
FROM debian:jessie-backports

# 1.安装jdk8
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y -t jessie-backports --no-install-recommends  openjdk-8-jre-headless ca-certificates-java \
    && rm -rf /var/lib/apt/lists/*
# 1.1 设置jdk8环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64