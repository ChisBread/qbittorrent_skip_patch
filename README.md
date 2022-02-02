# qbittorrent_skip_patch
## 特性
1. 更加快速(但相对而言不安全)的hash校验
2. 快速校验失败后自动暂停，下次开始种子时进行完整校验
## 使用
1. [docker](https://hub.docker.com/r/chisbread/qbittorrent)
2. 替换qbittorrent-nox文件
## 构建快检版qbittorrent-nox
```bash
qbitorrent_github_tag=release-4.3.9 libtorrent_github_tag=LPE_v0.4 bash qbittorrent-nox-static.sh libtorrent
```
## TODO
1. 群晖、威联通套件
2. libtorrent 2.0+支持