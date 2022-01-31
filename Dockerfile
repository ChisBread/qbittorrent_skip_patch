FROM debian:buster-slim

RUN set -x \
 && apt-get update \
 && apt-get install -y dumb-init curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY qbittorrent-nox /usr/bin/qbittorrent-nox
RUN set -x \
    # Add non-root user
 && useradd --system --uid 520 -m --shell /usr/sbin/nologin qbittorrent \
    # Create symbolic links to simplify mounting
 && mkdir -p /home/qbittorrent/.config/qBittorrent \
 && chown qbittorrent:qbittorrent /home/qbittorrent/.config/qBittorrent \
 && ln -s /home/qbittorrent/.config/qBittorrent /config \
    \
 && mkdir -p /home/qbittorrent/.local/share/qBittorrent \
 && chown qbittorrent:qbittorrent /home/qbittorrent/.local/share/qBittorrent \
 && ln -s /home/qbittorrent/.local/share/qBittorrent /torrents \
    \
 && mkdir /downloads \
 && chown qbittorrent:qbittorrent /downloads \
    # Check it works
 && su qbittorrent -s /bin/sh -c 'qbittorrent-nox -v'


# Default configuration file.
COPY qBittorrent.conf /default/qBittorrent.conf
COPY entrypoint.sh /
RUN chown qbittorrent:qbittorrent /usr/bin/qbittorrent-nox && \
   chown qbittorrent:qbittorrent /default/qBittorrent.conf && \
   chown qbittorrent:qbittorrent entrypoint.sh && \
   chmod +x entrypoint.sh && \
   chmod +x /usr/bin/qbittorrent-nox

VOLUME ["/config", "/torrents", "/downloads"]

ENV HOME /home/qbittorrent

USER qbittorrent

EXPOSE 8080 6881

ENTRYPOINT ["dumb-init", "/entrypoint.sh"]
CMD ["qbittorrent-nox"]

HEALTHCHECK --interval=5s --timeout=2s --retries=20 CMD curl --connect-timeout 15 --silent --show-error --fail http://localhost:8080/ >/dev/null || exit 1