# [Zsh-Template](https://hub.docker.com/r/logical05/zshtemplate) <a href="https://hub.docker.com/r/logical05/zshtemplate" target="_blank" rel="noreferrer"><img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/skills/docker-colored.svg" width="36" height="36" alt="Docker" /></a>

This is a Docker image that installs and configures Zsh, [Oh My Zsh](https://ohmyz.sh/), [Tmux](https://github.com/tmux/tmux), [Neovim](https://neovim.io/), and various essential plugins. 
This image simplifies setting up a terminal environment that can be used for development in Docker containers.

## Contents

- [Requirement](#requirement)
- [Usage](#usage)
- [Post-Installation Actions](#post-installation-actions)
- [Configuration](#configuration)
  - [Zsh](#zsh)
    - [Alias](#alias)
    - [Oh My Zsh](#oh-my-zsh)
  - [Tmux](#tmux)
    - [Key Bindings](#key-bindings)
    - [Tmux Plugin Manager](#tmux-plugin-manager)
  - [Neovim](#neovim)
    - [Key Bindings](#key-bindings-1)
    - [Vim-Plug](#vim-plug)
    - [Color Scheme](#color-scheme)
- [Contributing](#contributing)
- [License](#license)

## Requirement

- To use this Docker image, you need to install [Docker](https://docs.docker.com/).
- [Meslo Nerd Font patched](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#fonts) for Powerlevel10k.

## Usage

[Docker image link](https://hub.docker.com/r/logical05/zshtemplate)

- Getting this docker image
  ```zsh
  docker pull logical05/zshtemplate
  ```
  
- Run this docker image
  ```zsh
  docker run -it logical05/zshtemplate
  ```
  
- Reconnect to container
  1. List all the containers and find your container
     ```zsh
     docker ps -a
     ```
  3. Start the exited container
     ```zsh
     docker start <container ID>
     ```
  5. Attach to your container
     ```zsh
     docker attach <container ID>
     ```
- Usage within your Dockerfile
   ```zsh
   # Add non-root user
   ARG USERNAME=user
   ARG USER_UID=1000
   ARG USER_GID=$USER_UID
    
   RUN apt-get update && apt-get install -y sudo && \
       rm -rf /var/lib/apt/lists/* && \
       groupadd -g  $USER_GID $USERNAME && \
       useradd -m -u $USER_UID -g $USERNAME $USERNAME && \
       echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
       chmod 0440 /etc/sudoers.d/$USERNAME

   # Use a non-root user
   USER $USERNAME
   WORKDIR /home/$USERNAME

   # Use the installation script
   ARG path=/tmp
   
   ADD --chown=$USERNAME:$USERNAME https://github.com/Logical05/zsh-template.git $path
   RUN sudo chmod +x $path/setup-zsh.sh && $path/setup-zsh.sh $path
   ```
   - If your time is not set correctly, you can set it by adding these lines and changing the `TIMEZONE` value to your local time zone
     ```zsh
     ARG TIMEZONE=Asia/Bangkok
     RUN /bin/sh -c echo '$TIMEZONE' > /etc/timezone && \
         ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \ 
         apt-get update && apt-get install -y tzdata && \
         rm -rf /var/lib/apt/lists/*
     ```

## Post-Installation Actions

1. Reload the Tmux environment by pressing `Ctrl-s` + `Shift-i` while in Tmux.
2. Install the Neovim plugins by pressing `:` and typing `PlugInstall` while in Neovim.

## Configuration

This image comes with default configurations for Zsh, Tmux, and Neovim. You can customize these configurations by:

- ### Zsh
  Edit `~/.zshrc` for Zsh settings.
  
  - #### Alias
    | New  | Old                     | Description                                                                                                                                                             | 
    | :--- | :---------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | `vi` | `nvim`                  | Shorten the name                                                                                                                                                        |
    | `ls` | `exa --icons -h -g`     | lists files and directories with icons, human-readable file sizes, and detailed file information (including permissions, ownership, and timestamps) in a grouped format |
    | `l`  | `exa --icons -la -h -g` | Same as `exa --icons -h -g` but includes hidden ones                                                                                                                    |
    | `ll` | `exa --icons -ll -h -g` | Same as `exa --icons -h -g` but in a long listing style                                                                                                                 |
    
  - #### Oh My Zsh
    - Edit [plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/plugins) in `~/.zshrc`.
    - Used [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme. To customize prompt, run `p10k configure` or edit `~/.p10k.zsh`.

- ### Tmux
  Edit `~/.tmux.conf` for Tmux settings.
  
  - #### Key Bindings
    | Key      | New      | Old      | 
    | :------- | :------- | :------- |
    | `prefix` | `Ctrl-s` | `Ctrl-b` |

  - #### Tmux Plugin Manager
    - Edit [plugins](https://github.com/tmux-plugins/tpm) in `~/.tmux.conf`.
    - Used [Tmux powerline theme](https://github.com/wfxr/tmux-power) theme.
  
- ### Neovim
  Edit `~/.config/nvim/init.vim` for Neovim settings.

  - #### Key Bindings
    - Edit key bindings in `~/.config/nvim/maps.vim`.

  - #### Vim-Plug
    - Edit [plugins](https://github.com/junegunn/vim-plug) in `~/.config/nvim/plug.vim`.

  - #### Color Scheme
    - Edit color scheme in `~/.config/nvim/colors`.
    - Used [NeoSolarized](https://github.com/iCyMind/NeoSolarized).

## Contributing

Feel free to open issues or pull requests to improve this image. Contributions are welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
