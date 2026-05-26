# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/Users/ihrynkiv/.oh-my-zsh/custom/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

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

# eza (modern ls) — replaces lsd
alias ls='eza --icons=always --group-directories-first'
alias ll='eza -la --icons=always --group-directories-first --git'
alias la='eza -la --icons=always'
alias lt='eza --tree --icons=always --level=2'
alias l='eza -l --icons=always --group-directories-first'

# NVM bash completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Auto-switch nvm on directory change — works with zoxide jumps too
chpwd() {
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

# FZF — Catppuccin Mocha colors
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi --height=50% --border=rounded"



#the fuck alias
eval $(thefuck --alias)


export CYPRESS_RMS_HOME_URL=http://localhost:8081
export CYPRESS_RMS_API_URL=http://localhost:8082
export CYPRESS_RMS_SSR_URL=http://localhost:3005

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="/Users/ihrynkiv/.local/bin:$PATH"
alias nvchad="NVIM_APPNAME=nvchad nvim"
export PATH="$HOME/bin:$HOME/Library/Python/3.9/bin:$PATH"
eval "$(rbenv init - zsh)"

# Added by Windsurf
export PATH="/Users/ihrynkiv/.codeium/windsurf/bin:$PATH"

alias claude-remote='claude --channels plugin:telegram@claude-plugins-official'

# --- Tab icons (Ghostty) ---
# Ghostty injects 'title' into GHOSTTY_SHELL_FEATURES by default, which causes
# _ghostty_precmd (always last) to overwrite our tab titles with the current dir.
# Strip it here — we manage titles ourselves via _tab_precmd.
GHOSTTY_SHELL_FEATURES="${GHOSTTY_SHELL_FEATURES/,title/}"
GHOSTTY_SHELL_FEATURES="${GHOSTTY_SHELL_FEATURES/title,/}"
GHOSTTY_SHELL_FEATURES="${GHOSTTY_SHELL_FEATURES/title/}"

typeset -A _TAB_ICONS
_TAB_ICONS=(
  vim             "󰕷  Vim"
  nvim            "󰕷  Vim"
  nvchad          "󰕷  Vim"
  shell           " Shell"
  terminal        " Shell"
  vite            " Vite"
  slack           " Slack"
  spotify         "󰓇 Spotify"
  spotify_player  "󰓇 Spotify"
  docker          "󰡨 Docker"
  rust            " Rust"
  go              " GoLang"
)

_TAB_MANUAL=""

function _set_tab_title() { printf "\033]0;%s\007" "$1"; }

function tab() {
  local key="${1:l}"
  _TAB_MANUAL="${_TAB_ICONS[$key]:-$1}"
  _set_tab_title "$_TAB_MANUAL"
}

function _tab_preexec() {
  local cmd="${1%% *}"
  local title="${_TAB_ICONS[$cmd]}"
  [[ -n "$title" ]] && _set_tab_title "$title"
}

function _tab_precmd() { _set_tab_title "${_TAB_MANUAL:-🐚 Shell}"; }

add-zsh-hook preexec _tab_preexec
add-zsh-hook precmd  _tab_precmd

# zoxide (smart cd — replaces builtin cd with smart jump)
eval "$(zoxide init zsh --cmd cd)"

# atuin (smart shell history)
eval "$(atuin init zsh --disable-up-arrow)"
