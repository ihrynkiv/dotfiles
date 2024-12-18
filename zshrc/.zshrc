export RMS=$HOME/rms
export FRONT=$RMS/front-end
export PATH="/opt/homebrew/bin:/usr/local/opt/mysql-client/bin:/Applications/Docker.app/Contents/Resources/bin/:$PATH"

alias python=python3
MY_PYTHON="/Users/ihrynkiv/Library/Python/3.9/bin"
PATH=$MY_PYTHON:$PATH

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
#
plugins=(
aliases
git
git-auto-fetch
zsh-autosuggestions
zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh
. "/Users/ihrynkiv/.deno/env"
# bun completions
[ -s "/Users/ihrynkiv/.bun/_bun" ] && source "/Users/ihrynkiv/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(starship init zsh)"

#LSD
alias ls="lsd"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Automatically use `.nvmrc` version
cd() {
  builtin cd "$@" || return
  if [ -f ".nvmrc" ]; then
    nvm use
  fi
}


alias spotify="spotify_player"

export PATH=/Users/ihrynkiv/.local/bin:$PATH

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


source ~/fzf-git.sh/fzf-git.sh

# Bat better cat
export BAT_THEME=Coldark-Dark



#the fuck alias
eval $(thefuck --alias)


