# 解读官方Dockerfile
# 官方链接：https://github.com/docker-library/redis/blob/master/5.0/Dockerfile
# Q:为什么用debian:stretch-slim？A：因为官方版本用的这个
FROM debian:stretch-slim
# 1. 创建用户组和用户，后续操作全部在此用户上执行
RUN groupadd -r redis && useradd -r -g redis redis

# 2. 安装gosu小工具，使在root用户下切换用户变得更加简单
# https://github.com/tianon/gosu/releases
ENV GOSU_VERSION 1.10 
RUN set -ex; \
    \
    # 定义依赖列表
    fetchDeps=" \
    ca-certificates \
    dirmngr \
    gnupg \
    wget \
    "; \
    # 更新apt-get
    apt-get update; \
    # 安装依赖,指定–no-install-recommends参数来避免安装非必须的文件，从而减小镜像的体积
    apt-get install -y --no-install-recommends $fetchDeps; \
    rm -rf /var/lib/apt/lists/*; \
    \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
    gpgconf --kill all; \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
    chmod +x /usr/local/bin/gosu; \
    gosu nobody true; \
    \
    # 同时清除安装的软件包和软件的配置文件
    apt-get purge -y --auto-remove $fetchDeps
# 为什么此处要清理掉包，因为dokcer的原理决定，每一个Run命令都生成一个镜像包，如果此处不清理，生成的包就会很大

# 3. 安装redis
ENV REDIS_VERSION 5.0.2
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-5.0.2.tar.gz
ENV REDIS_DOWNLOAD_SHA 937dde6164001c083e87316aa20dad2f8542af089dfcb1cbb64f9c8300cd00ed

# for redis-sentinel see: http://redis.io/topics/sentinel
RUN set -ex; \
    \
    buildDeps=' \
    ca-certificates \
    wget \
    \
    gcc \
    libc6-dev \
    make \
    '; \
    apt-get update; \
    apt-get install -y $buildDeps --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
    \
    # 下载redis安装包、sha验证、解压、清理安装包
    wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL"; \
    echo "$REDIS_DOWNLOAD_SHA *redis.tar.gz" | sha256sum -c -; \
    mkdir -p /usr/src/redis; \
    tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1; \
    rm redis.tar.gz; \
    \
    # 禁用保护模式，因为在docker中不需要，端口不会自动暴露
    # disable Redis protected mode [1] as it is unnecessary in context of Docker
    # (ports are not automatically exposed when running inside Docker, but rather explicitly by specifying -p / -P)
    # [1]: https://github.com/antirez/redis/commit/edd4d555df57dc84265fdfb4ef59a4678832f6da
    grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h; \
    sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h; \
    grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h; \
    # for future reference, we modify this directly in the source instead of just supplying a default configuration flag because apparently "if you specify any argument to redis-server, [it assumes] you are going to specify everything"
    # see also https://github.com/docker-library/redis/issues/4#issuecomment-50780840
    # (more exactly, this makes sure the default behavior of "save on SIGTERM" stays functional by default)
    \
    # 编译、安装redis,清理redis安装包
    make -C /usr/src/redis -j "$(nproc)"; \
    make -C /usr/src/redis install; \
    \
    rm -r /usr/src/redis; \
    \
    # 同时清除安装的软件包和软件的配置文件
    apt-get purge -y --auto-remove $buildDeps

# 4. 创建数据目录，并授权给redis用户
RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

# 复制文件
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

# 对外暴露容器6379端口
EXPOSE 6379
# 启动时执行redis-server命令
CMD ["redis-server"]