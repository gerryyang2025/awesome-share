---
layout: post
title:  "Docker in Action"
date:   2019-02-22 08:00:00 +0800
categories: 云原生
tags:
  - Docker
  - 云原生

---

* Do not remove this line (it will not be displayed)
{:toc}


# 核心技术

Docker 底层是基于成熟的 `Linux Container(LXC)` 技术实现。自 Docker 0.9 版本起，Docker 除了继续支持 LXC 之外，还开始引入自家的[runc]，试图打造更通用的底层容器虚拟化库。

> runc is a CLI tool for spawning and running containers according to the OCI specification.

从操作系统功能上看，Docker 底层依赖的**核心技术**主要包括：

* Namespaces (Linux 操作系统的命名空间)
* Control Groups (控制组)
* Union File Systems (联合文件系统，目前支持的联合文件系统种类包括：AUFS，btrfs，vfs 和 DeviceMapper 等)
* Linux 虚拟网络

[runc]: https://github.com/opencontainers/runc

# 一些思考

* 在 Docker 应用中，项目架构师的作用贯穿整个开发，测试，生产三个环节。
* 项目伊始，架构师根据项目预期创建好需要的基础 Base 镜像（比如，Nginx，Tomcat，MySQL 等镜像），或者将 Dockerfile 分发给所有开发，所有开发根据 Dockerfile 创建的镜像来进行开发，达到开发环境充分一致。
* 若开发过程中需要添加新的程序，需要向架构师申请修改基础的 Base 镜像的 Dockerfile。
* 开发完成后，将 Dockerfile 提交给测试，消除部署困难的问题。
* 使用 `-v` 共享文件夹来存储开发的程序代码。
* 利用好 Base 镜像的继承特性来调整镜像的轻微改动。即，只需要修改 Base 镜像，而不需要修改其他依赖的镜像。
* 对 Docker 化程序和原生程序进行性能测试对比。
* 如果 Docker 出现不可控的风险，是否有替代方案。
* 是否需要对 Docker 容器做资源限制。
* 容器安全管理。
* 内部私有仓库的管理。
* 建议一个容器内只运行一个应用进程。
* Vagrant 适合管理虚拟机，而 Docker 适合管理应用环境。Docker 不是虚拟机，而是进程隔离，对于资源的消耗很少，但是目前需要 Linux 环境支持。Vagrant 是虚拟机上做的封装，虚拟机本身会消耗资源。


![docker_dev_flow](/assets/images/201902/docker_dev_flow.jpg)

![docker_dev_flow_example](/assets/images/201902/docker_dev_flow_example.jpg)

# 常用命令

![docker_cmd](/assets/images/201902/docker_cmd.jpg)

## TL;DR

{% highlight bash %}
# 查看已下载镜像
docker images

# 拉取镜像，如果不指定标签，默认下载 latest
docker pull <镜像名>:<标签>

# 创建容器
# 直接执行 docker run 时，如果本地没有对应的镜像，Docker 会自动先执行 pull
docker run -itd -v /data:/data <镜像名>:<标签> bash

# 查看容器信息
docker ps -l

# 执行进入容器
docker exec -it $container_id bash
{% endhighlight %}


## 生命周期管理

* `docker run`：创建并启动一个新容器。这是最常用的命令，结合了 create 和 start。
  + `docker run -d --name my_container nginx`（`-d` 后台运行，`--name` 指定名称）。

* `docker start`：启动一个或多个已经停止的容器。

* `docker stop <容器ID或名称>`：优雅地停止运行中的容器（发送 `SIGTERM` 信号）。
  + 优雅停止并指定等待时间（例如 60 秒）：`docker stop -t 60 <容器ID或名称>`。如果不希望由于停止等待太久，可以配合 `-t 0` 参数快速停止。停止后的容器状态变为 `Exited`，数据依然保留，可用 `docker start` 重新启动。
  + 停止所有正在运行的容器：`docker stop $(docker ps -q)`

* `docker restart`：重启容器。
* `docker pause / unpause`：暂停或恢复容器中所有的进程。
* `docker kill <容器ID或名称>`：强制停止容器（发送 `SIGKILL` 信号）。
* `docker rm`：删除已停止的容器。使用 `-f` 可强制删除运行中的容器。

> **提示**：在执行这些命令时，通常可以使用容器的名称或 ID（只需输入前几位能唯一标识即可）。


## 状态查看与监控

* `docker ps`：列出当前正在运行的容器。
  + `docker ps -a`：查看所有容器，包括已停止的。

* `docker logs`：查看容器日志。
  + `docker logs -f <ID>`：持续跟踪日志输出。

* `docker stats`：实时显示容器的资源使用情况（CPU、内存、网络 I/O）。
* `docker inspect`：获取容器的详细元数据（JSON 格式），如 IP 地址、配置信息等。
* `docker top`：查看容器内运行的进程。

## 容器交互操作

* `docker exec`：在运行中的容器内执行命令。
  + `docker exec -it <ID> /bin/bash`：进入容器的交互式终端。

* `docker cp`：在容器与宿主机之间拷贝文件。
* `docker port`：查看容器的端口映射情况。


## 资源清理

* `docker container prune`：一键清理所有已停止的容器，释放系统资源。




## docker build

https://docs.docker.com/engine/reference/commandline/build/

{% highlight bash %}
docker build -t vieux/apache:2.0 .
{% endhighlight %}

# 容器指标

[cAdvisor](https://github.com/google/cadvisor) (Container Advisor) provides container users an understanding of the resource usage and performance characteristics of their running containers. It is a running daemon that collects, aggregates, processes, and exports information about running containers. Specifically, for each container it keeps resource isolation parameters, historical resource usage, histograms of complete historical resource usage and network statistics. This data is exported by container and machine-wide.


# 测试使用 (CentOS)


{% highlight text %}
$docker version
Client:
 Version:           18.09.7
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        2d0083d
 Built:             Thu Jun 27 17:56:06 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.7
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.8
  Git commit:       2d0083d
  Built:            Thu Jun 27 17:26:28 2019
  OS/Arch:          linux/amd64
  Experimental:     false
{% endhighlight %}

{% highlight text %}
$docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 9
Server Version: 18.09.7
Storage Driver: overlay2
 Backing Filesystem: extfs
 Supports d_type: true
 Native Overlay Diff: false
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host macvlan null overlay
 Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Init Binary: docker-init
containerd version: 894b81a4b802e4eb2a91d1ce216b8817763c29fb
runc version: 425e105d5a03fabd737a126ad93d62a9eeede87f
init version: fec3683
Security Options:
 seccomp
  Profile: default
Kernel Version: 3.10.107-1-tlinux2_kvm_guest-0049
Operating System: Tencent tlinux 2.2 (Final)
OSType: linux
Architecture: x86_64
CPUs: 16
Total Memory: 31.17GiB
Name: VM-11-48-centos
ID: OLLW:ZRBS:Z2XV:34ER:NKGJ:NNH4:LKOX:YX3U:BSDO:SL2I:F7S7:CMSM
Docker Root Dir: /data/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
Labels:
Experimental: false
Insecure Registries:
 bk.artifactory.oa.com:8080
 csighub.tencentyun.com
 docker.oa.com:8080
 hub.oa.com
 127.0.0.0/8
Registry Mirrors:
 http://docker.oa.com:8080/
 http://csighub.tencentyun.com/
Live Restore Enabled: false
Product License: Community Engine
{% endhighlight %}

# 用户管理

{% highlight text %}
sudo service docker start         # 启动 docker 服务
sudo usermod -aG docker ${USER}   # 当前用户加入 docker 组
{% endhighlight %}

> 说明：
>
> service docker start 是启动 Docker 的后台服务
>
> usermod -aG 是把当前的用户加入 Docker 的用户组。这是因为操作 Docker 必须要有 root 权限，而直接使用 root 用户不够安全，加入 Docker 用户组是一个比较好的选择，这也是 Docker 官方推荐的做法。当然，如果只是为了图省事，也可以直接切换到 root 用户来操作 Docker


# Dockerfile

* https://docs.docker.com/engine/reference/builder/

## [CMD](https://docs.docker.com/engine/reference/builder/#cmd)

The `CMD` instruction has three forms:

{% highlight text %}
CMD ["executable","param1","param2"] (exec form, this is the preferred form)
CMD ["param1","param2"] (as default parameters to ENTRYPOINT)
CMD command param1 param2 (shell form)
{% endhighlight %}

There can only be one `CMD` instruction in a Dockerfile. If you list more than one `CMD` then only the last `CMD` will take effect.

**The main purpose of a `CMD` is to provide defaults for an executing container**. These defaults can include an executable, or they can omit the executable, in which case you must specify an `ENTRYPOINT` instruction as well.

If `CMD` is used to provide default arguments for the `ENTRYPOINT` instruction, both the `CMD` and `ENTRYPOINT` instructions should be specified with the JSON array format.

> The exec form is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘).

If you use the shell form of the `CMD`, then the `<command>` will execute in `/bin/sh -c`:

{% highlight text %}
FROM ubuntu
CMD echo "This is a test." | wc -
{% endhighlight %}

If you want to **run your `<command>` without a shell** then you must express the command as a JSON array and give the full path to the executable. **This array form is the preferred format of `CMD`**. Any additional parameters must be individually expressed as strings in the array:

{% highlight text %}
FROM ubuntu
CMD ["/usr/bin/wc","--help"]
{% endhighlight %}

If you would like your container to run the same executable every time, then you should consider using `ENTRYPOINT` in combination with `CMD`. See [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint).

> If the user specifies arguments to `docker run` then they will override the default specified in `CMD`.

## [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint)

An `ENTRYPOINT` allows you to configure a container that will run as an executable.

`ENTRYPOINT` has two possible forms:

* The exec form, which is the preferred form:

{% highlight bash %}
ENTRYPOINT ["executable", "param1", "param2"]
{% endhighlight %}

The shell form:

{% highlight bash %}
ENTRYPOINT command param1 param2
{% endhighlight %}

For more information about the different forms, see [Shell and exec form](https://docs.docker.com/reference/dockerfile#shell-and-exec-form).

# Q&A

## [How can I find a Docker image with a specific tag in Docker registry on the Docker command line?](https://stackoverflow.com/questions/24481564/how-can-i-find-a-docker-image-with-a-specific-tag-in-docker-registry-on-the-dock)

I try to locate one specific tag for a Docker image. How can I do it on the command line? I want to avoid downloading all the images and then removing the unneeded ones.

Answers:

{% highlight bash %}
#!/usr/bin/bashs
curl -s -S "https://registry.hub.docker.com/v2/repositories/library/$@/tags/" | jq '."results"[]["name"]' | sort
{% endhighlight %}

## 权限问题：dial unix /var/run/docker.sock: connect: permission denied

**问题描述**：在当前用户权限下使用 docker 命令需要 sudo 否则出现以下问题：

{% highlight text %}
[user00@~]$ docker ps -l
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.39/containers/json?limit=1: dial unix /var/run/docker.sock: connect: permission denied
{% endhighlight %}

**解决方案**：通过将当前用户添加到 docker 用户组可以将 sudo 去掉，命令如下：

{% highlight bash %}
groupadd docker            # 添加 docker 用户组
gpasswd -a 用户名 docker    # 将登陆用户加入到 docker 用户组中
newgrp docker              # 更新用户组
systemctl restart docker   # 最后重启 docker 生效
{% endhighlight %}


## 镜像过大导致根目录磁盘空间用完

**问题描述**：由于系统初始分区的原因，操作系统中对应 `/` 分区不会太大，通常 `/var` 目录不会单独分区。如果上面运行 Docker 服务，经过长时间的使用，镜像下载过多会导致根目录磁盘空间用完。

{% highlight text %}
[user00@~]$ df -h
Filesystem    Size  Used Avail Use% Mounted on
/dev/vda1      99G   98G     0 100% /
{% endhighlight %}

> 注意：1. 首先排除 root 用户的根目录下是否有不需要的数据，并进行清理。2. yum clean all 清理当前的 yum 缓存数据。

**解决方法**：通过 `docker info` 命令可以查看 `Docker Root Dir: /var/lib/docker` 的存储路径。`/var/lib/docker` 目录中保存着各种信息，例如：容器数据、卷、构建文件、网络文件和集群数据。最大的文件通常是镜像。如果使用默认的 `overlay2` 存储驱动，Docker 镜像会保存在 `/var/lib/docker/overlay2` 目录。

![docker_storage](/assets/images/202603/docker_storage.png)

第一步：对于不需要的文件，可先清理 Docker 使用的空间（可选）

**清理不再使用的容器**。可以使用以下命令清理容器、网络文件、镜像和构建缓存：


{% highlight text %}
$docker system prune -a
WARNING! This will remove:
        - all stopped containers
        - all networks not used by at least one container
        - all images without at least one container associated to them
        - all build cache
Are you sure you want to continue? [y/N] y
{% endhighlight %}

**清除不再使用的卷**：


{% highlight text %}
$docker volume prune
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N] y
{% endhighlight %}


第二步：若不需要第一步清理空间，也可直接修改存储目录。解决默认存储容量不足的情况，最直接且最有效的方法就是挂载新的分区到该目录。但是在原有系统空间不变的情况下，可采用软链接的方式，修改镜像和容器的存放路径达到同样的目的。

{% highlight bash %}
# 停止 Docker 服务
service docker stop
# 如果停止不了，可尝试 systemctl stop docker.socket docker.service

# 通过软链修改存储目录
mv /var/lib/docker /data
ln -sf /data/docker /var/lib/docker

# 启动 Docker 服务
service docker start
{% endhighlight %}



# 历史文章

* [Where are Docker images stored? (杂译)]
* [使用Docker registry镜像创建私有仓库]
* [Docker使用桥接的通信方案]
* [github-docker]


# 书籍

* [Docker - 从入门到实践](https://yeasy.gitbook.io/docker_practice/)


# 优化

* [三个技巧，将 Docker 镜像体积减小 90%](https://www.infoq.cn/article/3-simple-tricks-for-smaller-docker-images)


# 官方文档

* https://docs.docker.com/engine/reference/run/
* [Docker Release Notes]
* [Docker development best practices]



[Where are Docker images stored? (杂译)]: https://blog.csdn.net/delphiwcdj/article/details/43602877

[使用Docker registry镜像创建私有仓库]: https://blog.csdn.net/delphiwcdj/article/details/43099877

[Docker使用桥接的通信方案]: https://blog.csdn.net/delphiwcdj/article/details/49508045

[github-docker]: https://github.com/gerryyang/mac-utils/tree/master/tools/docker

[Docker Release Notes]: https://docs.docker.com/release-notes/

[Docker development best practices]: https://docs.docker.com/develop/dev-best-practices/