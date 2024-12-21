FROM ubuntu:22.04

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update && apt-get install -y --no-install-recommends sudo && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g  $USER_GID $USERNAME && \
    useradd -m -u $USER_UID -g $USERNAME $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

# COPY --chown=$USERNAME:$USERNAME asset /home/$USERNAME

# COPY setup-zsh.sh /tmp
# RUN sudo chmod +x /tmp/setup-zsh.sh && /tmp/setup-zsh.sh

RUN sh -c "$(wget https://raw.githubusercontent.com/Logical05/zsh-template/refs/heads/main/setup.sh -O -)"

ENTRYPOINT [ "/bin/zsh" ]