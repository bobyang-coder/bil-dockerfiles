# 为什么用debain，因为它小啊!!!，
# 又为什么用jessie-backports版本，因为大家貌似都用的这个！！！！
FROM debian:jessie-backports

# 1. 安装jdk8
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y -t jessie-backports --no-install-recommends  openjdk-8-jre-headless ca-certificates-java \
    && rm -rf /var/lib/apt/lists/*
# 1.1 设置jdk8环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# 2. 安装hadoop
# 2.1 设置hadoop版本和下载地址
ENV HADOOP_VERSION 2.8.5
# https://www-us.apache.org/dist/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz
# https://www-us.apache.org/dist/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz.asc
ENV HADOOP_URL http://www-us.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

# 2.2 下载并安装hadoop
RUN curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz --progress \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz* \
    # 软链接hadoop目录
    && ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop \
    && cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml \
    # 创建日志目录
    && mkdir /opt/hadoop-$HADOOP_VERSION/logs \
    # 创建hadoop文件数据目录
    && mkdir /hadoop-data \
    && rm -Rf /opt/hadoop-$HADOOP_VERSION/share/doc/hadoop

# 3. 配置hadoop环境变量
ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1

# 4. 配置用户
ENV USER=root
ENV PATH=$HADOOP_PREFIX/bin/:$PATH

# 5. 导入entrypoint.sh脚本文件，并授权
ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

# 6. 配置启动脚本
ENTRYPOINT ["/entrypoint.sh"]