参考链接
# 基础教程
参考链接：https://github.com/docker-library/docs/tree/master/nginx
## 运行
```
<!-- 单节点  -->
docker run --name bob-nginx --network docker_bob-test-net -d -p 8080:80 nginx:latest
<!-- 使用自定义的配置文件 -->
$ docker run --name my-custom-nginx-container -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx

```

## 修改运行中的nginx配置

```bash
docker run --name tmp-nginx-container -d nginx
docker cp tmp-nginx-container:/etc/nginx/nginx.conf /host/path/nginx.conf
docker rm -f tmp-nginx-container
```



