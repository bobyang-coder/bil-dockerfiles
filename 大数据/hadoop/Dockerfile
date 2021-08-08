# 基于centeos7搭建hadoop环境 
# 参考https://hub.docker.com/r/uhopper/hadoop/~/dockerfile/
FROM centos:7
LABEL author="haibo.yang" 

# 1.安装jdk8
# 1.1 更新yum,安装jdk8
RUN yum -y update  \
    && yum -y  install  java-1.8.0-openjdk   java-1.8.0-openjdk-devel \
    && yum clean all
# 1.1 设置jdk8环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk/
ENV JRE_HOME=$JAVA_HOME/jre
ENV CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

# 2.安装hadoop
# 2.1 设置hadoop版本和下载地址
ENV HADOOP_VERSION 2.8.5
# https://www-us.apache.org/dist/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz
# https://www-us.apache.org/dist/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz.asc
ENV HADOOP_URL http://www-us.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
# 2.2 下载hadoop
RUN curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz --progress \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*
# 2.3 
# 软链接hadoop目录
RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml
# 创建日志目录
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

# 2.4 创建hadoop文件数据目录
RUN mkdir /hadoop-data

# 2.5 配置hadoop环境变量
ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1

# 2.6 配置用户
ENV USER=root
ENV PATH=$HADOOP_PREFIX/bin/:$PATH

# 3. 导入entrypoint.sh脚本文件，并授权
ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

# 4. 配置启动脚本
ENTRYPOINT ["/entrypoint.sh"]