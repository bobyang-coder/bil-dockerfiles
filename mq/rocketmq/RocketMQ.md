[TOC]
# docker运行RocketMQ
参考链接
- https://github.com/apache/rocketmq-docker



# docker-console
- https://github.com/apache/rocketmq-externals/tree/master/rocketmq-console

运行命令
```
docker run -e "JAVA_OPTS=-Drocketmq.namesrv.addr=127.0.0.1:9876 -Dcom.rocketmq.sendMessageWithVIPChannel=false" -p 8080:8080 -t apacherocketmq/rocketmq-console-ng:2.0.0
```