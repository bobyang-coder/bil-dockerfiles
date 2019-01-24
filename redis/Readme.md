```bash
# 自定义redis.conf
docker run -v /myredis/conf/redis.conf:/usr/local/etc/redis/redis.conf --name myredis redis redis-server /usr/local/etc/redis/redis.conf
```


# 使用docker-compose创建集群
## volumes挂载后启动容器时报找不到redis.conf文件
参考链接：https://www.cnblogs.com/jackluo/p/5783116.html
volumes挂载到容器中的文件，默认权限是与主机用户相同的，而redis是用redis用户启动的，所以访问不到redis.conf文件

## 为什么容器起的别名在redis里面直接当hostname用不了？
```bash
Node redis-node2:6379 replied with error:
ERR Invalid node address specified: redis-node1:6379
```
redis貌似是不支持hostname的，待查官网资料
- 使用创建脚本进行集群创建的时候最好将配置文件redis.conf绑定的IP改为真实的IP不要用hostname
- 使用命令也不要用hostname