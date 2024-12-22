FROM ubuntu:22.04

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG TIMEZONE=Asia/Bangkok

RUN /bin/sh -c echo '$TIMEZONE' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \ 
    apt-get update && apt-get install -y sudo tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g  $USER_GID $USERNAME && \
    useradd -m -u $USER_UID -g $USERNAME $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

ARG path=/tmp

# If you want to create a docker image from the source, you need to uncomment COPY and comment ADD below.
# COPY --chown=$USERNAME:$USERNAME asset $path/asset
# COPY setup-zsh.sh $path
ADD --chown=$USERNAME:$USERNAME https://github.com/Logical05/zsh-template.git $path

RUN sudo chmod +x $path/setup-zsh.sh && $path/setup-zsh.sh $path

ENTRYPOINT [ "/bin/zsh" ]