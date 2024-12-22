#!/bin/sh

set -e

sudo apt-get update && sudo apt-get install -y software-properties-common && sudo rm -rf /var/lib/apt/lists/*
sudo add-apt-repository ppa:neovim-ppa/stable

sudo apt-get update && sudo apt-get install -y zsh wget git exa tmux neovim curl && sudo rm -rf /var/lib/apt/lists/*

sudo apt-get update && sudo apt-get upgrade -y && sudo rm -rf /var/lib/apt/lists/*
sudo apt-get autoremove -y
sudo apt-get clean -y

mv /tmp/asset/.[!.]* ~

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

sed -i 's/plugins=(git.*)/plugins=(\
git \
zsh-syntax-highlighting \
zsh-autosuggestions \
zsh-history-substring-search \
z \
)/' ~/.zshrc

echo '\n
export TERM=xterm-256color
export COLORTERM=truecolor
export LC_ALL=C.UTF-8' >> ~/.zshrc

echo '\n
alias vi=nvim
alias ls="exa --icons -h -g"
alias l="exa --icons -la -h -g"
alias ll="exa --icons -ll -h -g"' >> ~/.zshrc


git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux new-session -s _ -d
tmux source ~/.tmux.conf

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo '\n
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc