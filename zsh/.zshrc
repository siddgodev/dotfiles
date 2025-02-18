# =============================================================================
#                         Essential Early Initialization
# =============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
#                              Environment Variables
# =============================================================================
# Editor configuration
export EDITOR=nvim

# Neovim virtual environment configuration
export NVIM_PYTHON_VENV="$HOME/.local/virtualenvs/nvim"

# History configuration
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# =============================================================================
#                                 Path Settings
# =============================================================================
# Add Neovim virtual environment to start of PATH
path=("$NVIM_PYTHON_VENV/bin" $path)

# Additional PATH components
path+=(
    /usr/local/go/bin
    $HOME/go/bin
    $HOME/.cargo/bin
    /usr/local/zig
    $HOME/.local/bin
    $HOME/.pyenv/bin
)

# Ensure PATH is unique and export it
typeset -U path
export PATH

# =============================================================================
#                              Plugin Management
# =============================================================================
# Initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Oh-My-Zsh snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::podman
zinit snippet OMZP::npm

# =============================================================================
#                            History Configuration
# =============================================================================
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# =============================================================================
#                           Completion Configuration
# =============================================================================
# Initialize completion system
autoload -U compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# =============================================================================
#                              Tool Integration
# =============================================================================
# asdf version manager
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# Additional tools
# Shell integrations(requires fzf)
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# =============================================================================
#                                 Key Bindings
# =============================================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# =============================================================================
#                                  Aliases
# =============================================================================
alias ls='ls --color'
alias cp="cp -iv"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
alias ll="ls -FGlAhp"
alias ..="cd .."
alias ...="cd ../../"
alias .3="cd ../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../../"
alias .6="cd ../../../../../../"
alias c="clear"
alias path="echo $PATH | tr ':' '\n'"

# =============================================================================
#                            Final Configurations
# =============================================================================
# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Ensure zinit completions are properly loaded
zinit cdreplay -q

# pnpm
export PNPM_HOME="/home/sidd/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
