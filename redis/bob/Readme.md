```bash
# 自定义redis.conf
docker run -v /myredis/conf/redis.conf:/usr/local/etc/redis/redis.conf --name myredis redis redis-server /usr/local/etc/redis/redis.conf
```


# 使用docker-compose创建集群
## volumes挂载后启动容器时报找不到redis.conf文件
参考链接：https://www.cnblogs.com/jackluo/p/5783116.html
volumes挂载到容器中的文件，默认权限是与主机用户相同的，而redis是用redis用户启动的，所以访问不到redis.conf文件

## 