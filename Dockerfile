FROM dorowu/ubuntu-desktop-lxde-vnc

RUN apt-get update \
    && apt-get update \
    && apt-get install -y --no-install-recommends socat \
    && apt-get autoclean \
    && apt-get autoremove \
&& rm -rf /var/lib/apt/lists/*


ENV USER=rippy

COPY supervisor/*.conf /etc/supervisor/conf.d/

COPY startup-wrapper.sh /
RUN chmod +x /startup-wrapper.sh

ENTRYPOINT ["/startup-wrapper.sh"]