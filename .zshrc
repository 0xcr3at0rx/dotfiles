if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[[ -f "$ZINIT_HOME/zinit.zsh" ]] || git clone --depth=1 https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"

fpath=(~/.zsh/completions $fpath)

autoload -Uz compinit
compinit -C -d "$HOME/.cache/zsh/zcompdump"

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit ice wait"1" lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"1" lucid
zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait"1" lucid
zinit light zsh-users/zsh-completions
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab
zinit ice wait"1" lucid
zinit light hlissner/zsh-autopair
zinit ice wait"1" lucid
zinit light MichaelAquilina/zsh-autoswitch-virtualenv

zinit ice wait"2" lucid
zinit snippet OMZP::extract
zinit snippet OMZP::command-not-found
zinit snippet OMZP::copyfile

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

bindkey '^K' history-search-backward
bindkey '^J' history-search-forward
bindkey '^@' autosuggest-accept
bindkey '^ ' autosuggest-accept
bindkey -s '^Z' 'zjs\n'

HISTFILE="$HOME/.cache/zsh/zhistory"
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt AUTO_CD
setopt COMPLETE_IN_WORD
setopt MENU_COMPLETE

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

alias ls="eza --group-directories-first --git"
alias ll="eza -lh --git"
alias la="eza -lah --git"
alias tree="eza --tree"
alias cat="bat --style=plain --paging=never"
alias grep="rg --color=always"
alias find="fd --color=always"
alias diff="delta"
alias hx="helix"
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias reload="exec zsh"
alias weather="curl wttr.in"
alias zj="zellij"
alias zjl="zellij list-sessions"
alias zja="zellij attach"
alias zjn="zellij --session"
alias zjk="zellij kill-session"
alias dev="zellij --layout default"
alias scratch="zellij --session scratch"
alias zr="zellij attach -c main"
alias nd="nix develop . --command $SHELL"
alias zshrc="helix ~/.zshrc"
alias pdf="zathura"

help() {
    if [ $# -eq 0 ]; then
        echo "Usage: cheat <topic>"
        return 1
    fi
    local query
    query=$(printf "%s+" "$@")
    query=${query%+}
    command curl -s "https://cheat.sh/$query?T" | bat --theme="ansi" -p -l bash 
}

man() {
    command man "$@" | bat --theme="ansi" -p -l man
}

zellij-switch() {
  local session
  session=$(zellij list-sessions 2>/dev/null | fzf)
  [[ -n "$session" ]] && zellij attach "$session"
}
alias zjs="zellij-switch"

export EDITOR=helix
export TERMINAL=xterm
export COLORTERM=truecolor
export CLICOLOR=1
export LESS=-R

export GOPATH="$HOME/.cache/go"
export GOBIN="$HOME/.local/bin"
export PATH="$GOBIN:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"

export FZF_DEFAULT_OPTS="--layout=reverse --height=40% --border"

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

[ -t 0 ] && export GPG_TTY=$(tty)
[[ -e ~/.nix-profile/etc/profile.d/nix.sh ]] && source ~/.nix-profile/etc/profile.d/nix.sh
