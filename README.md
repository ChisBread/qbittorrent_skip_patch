# qbittorrent_skip_patch
## 特性
1. 更加快速(但相对而言不安全)的hash校验
2. 快速校验失败后自动暂停，下次开始种子时进行完整校验
## 使用
- [docker](https://hub.docker.com/r/chisbread/qbittorrent)
    - 群晖docker使用请参考[链接](https://post.smzdm.com/p/a5k64587/)
    - 命令行使用
```bash
docker run -d \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Asia/Shanghai \
  -e WEBUI_PORT=8080 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  -p 8080:8080 \
  -v $PWD/config:/config \
  -v $PWD/downloads:/downloads \
  --restart unless-stopped \
  chisbread/qbittorrent:latest
```
- 替换qbittorrent-nox文件

## 构建快检版qbittorrent-nox
```bash
qbitorrent_github_tag=release-4.3.9 libtorrent_github_tag=LPE_v0.4 bash qbittorrent-nox-static.sh qbittorrent
```
## TODO
1. 群晖、威联通套件
2. libtorrent 2.0+支持