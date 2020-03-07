FROM dorowu/ubuntu-desktop-lxde-vnc

RUN apt-get update \
    && apt-get update \
    && apt-get install -y --no-install-recommends socat \
        chromium-browser dante-server scrot xprintidle \
        gpg-agent \
    && apt-get autoclean \
    && apt-get autoremove \
&& rm -rf /var/lib/apt/lists/*

COPY google-chrome.list /etc/apt/sources.list.d/
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
RUN curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN apt-get update \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-chrome-stable \
    && apt-get autoclean \
    && apt-get autoremove \
&& rm -rf /var/lib/apt/lists/*

ENV USER=rippy
ENV TITLE="Rippy Desktop"

COPY supervisor/*.conf /etc/supervisor/conf.d/

COPY scripts/* /
RUN chmod +x /*.py /*.sh

HEALTHCHECK --interval=7s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health

ENTRYPOINT ["/startup-wrapper.sh"]
