if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
[[ -f "$ZINIT_HOME/zinit.zsh" ]] || git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light hlissner/zsh-autopair
zinit light MichaelAquilina/zsh-autoswitch-virtualenv

zinit snippet OMZP::command-not-found
zinit snippet OMZP::extract
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::copyfile
zinit snippet OMZP::thefuck

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
compinit -d $HOME/.cache/zsh/zcompdump
zinit cdreplay -q

bindkey '^Q' kill-region
bindkey '^K' history-search-backward
bindkey '^J' history-search-forward
bindkey '^@' autosuggest-accept
bindkey '^ ' autosuggest-accept
bindkey '^H' backward-char
bindkey '^L' forward-char

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=$HOME/.cache/zsh/zhistory

setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups
setopt hist_save_no_dups hist_find_no_dups
setopt inc_append_history extended_history
setopt autocd prompt_subst
setopt complete_in_word menu_complete auto_list list_packed

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{blue}%d%f'
zstyle ':completion:*:messages' format '%F{green}%d%f'
zstyle ':completion:*:warnings' format '%F{red}no matches%f'
zstyle ':completion:*:corrections' format '%F{yellow}%d (%e)%f'

zstyle ':completion:*:*:git:*' menu yes select
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags --border=sharp --height=40%
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'

alias ls="eza"
alias cat="bat"
alias vi="nvim"
alias vim="nvim"
alias grep="rg"
alias find="fd"
alias clear="printf '\\033c'"
alias reload="source $HOME/.zshrc"
alias ani-cli="ani-cli --dub"
alias music="kew"
alias nd="nix develop . --command $SHELL"
alias zshrc="nvim ~/.zshrc"

help() {
    if [ $# -eq 0 ]; then
        echo "Usage: cheat <topic>"
        return 1
    fi

    local query
    query=$(printf "%s+" "$@")
    query=${query%+}

    curl -s "https://cheat.sh/$query?T" | bat --theme="ansi" -p -l bash 
}

man() {
    command man "$@" | bat --theme="ansi" -p -l man
}

rm() {
    local RED='\033[1;31m'
    local YELLOW='\033[1;33m'
    local NC='\033[0m'

    if [[ $# -eq 0 ]]; then
        command rm
        return
    fi

    local CURRENT_DIR
    CURRENT_DIR="$(realpath "$PWD")"
    echo -e "${YELLOW}WARNING: You are deleting inside:${NC} $CURRENT_DIR"
    printf "Continue? [Y/n]: "
    read -r confirm

    case "$confirm" in
        ""|y|Y|yes|YES)
            command rm "$@"
            return $?
            ;;
        *)
            echo "Aborted."
            return 1
            ;;
    esac
}

if command -v gpg >/dev/null 2>&1; then
  export GPG_TTY=$(tty 2>/dev/null || echo)
fi
export CLICOLOR=1
export TERM=xterm-256color
export LESS=-R
export GROFF_NO_SGR=0
export COLORTERM=truecolor
export GOPATH="$HOME/.cache/go"
export GOBIN="$HOME/.local/bin"
export GOCACHE="$HOME/.cache/go-build"
export PATH="$PATH:$GOBIN"
export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
export FZF_DEFAULT_OPTS="
--layout=reverse
--border=sharp
--height=34%
--info=inline
--prompt='> '
--pointer='>'
--marker='*'
--color=fg:#cccccc,bg:#121212,hl:#1bfd9c,fg+:#ffffff,bg+:#2a2a2a,hl+:#66ffad,info:#49c4c4,prompt:#1bfd9c,pointer:#fd1b7c,marker:#fd1b7c,spinner:#49c4c4,header:#7a7a7a
"
export EZA_COLORS="\
uu=36:\
uR=31:\
un=35:\
gu=37:\
da=2;37:\
ur=37:\
uw=95:\
ux=36:\
ue=36:\
gr=37:\
gw=35:\
gx=36:\
tr=37:\
tw=35:\
tx=36:\
xx=95:"

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
  . ~/.nix-profile/etc/profile.d/nix.sh
fi

