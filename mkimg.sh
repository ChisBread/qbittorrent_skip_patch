cp qbt-build/bin/qbittorrent-nox qbittorrent-nox
sudo docker build -t chisbread/qbittorrent:$1 -f Dockerfile .