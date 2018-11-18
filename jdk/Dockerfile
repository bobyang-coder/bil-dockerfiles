# 基于centeos7搭建jdk8环境
FROM centos:7
LABEL author="haibo.yang" 

# 1.安装jdk8
RUN yum -y update  \
    && yum -y  install  java-1.8.0-openjdk   java-1.8.0-openjdk-devel \
    && yum clean all
# 1.1 设置jdk8环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk/
ENV JRE_HOME=$JAVA_HOME/jre
ENV CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH