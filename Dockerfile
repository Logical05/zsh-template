FROM ubuntu:22.04

ENV TERM=xterm-256color
ENV COLORTERM=truecolor
ENV LC_ALL=C.UTF-8

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN /bin/sh -c echo 'Asia/Bangkok' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && \
    apt-get update && apt-get install -y --no-install-recommends sudo tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g  $USER_GID $USERNAME && \
    useradd -m -u $USER_UID -g $USERNAME $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

COPY --chown=$USERNAME:$USERNAME asset /home/$USERNAME

COPY setup.sh /tmp
RUN sudo chmod +x /tmp/setup.sh && /tmp/setup.sh

ENTRYPOINT [ "/bin/zsh" ]