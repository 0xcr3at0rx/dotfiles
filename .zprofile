export EDITOR="nvim"
export VISUAL="emacsclient -c"
export TERMINAL="alacritty"

export COLORTERM="truecolor"
export CLICOLOR="1"

export MANPAGER="nvim +Man!"
export ZSH_GIT_REPO_MANAGER_CODE_HOME=~/src

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"
export PATH="/nix/var/nix/profiles/default/bin:$PATH"
export GOPATH="$HOME/.cache/go"
export GOBIN="$HOME/.local/bin"

export FZF_DEFAULT_OPTS="
--layout=reverse
--height=40%
--border=none
--margin=0
--padding=0
--info=inline
--prompt=❯
--pointer=▶
--marker=✓
--color=fg:#908caa,bg:#191724,hl:#ebbcba
--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
--color=border:#403d52,header:#31748f,gutter:#191724
--color=spinner:#f6c177,info:#9ccfd8
--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
"

if [[ -t 0 ]]; then
  export GPG_TTY=$(tty)
fi

if [[ -f "$nix_profile" ]]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if [[ -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
  if command -v rfkill >/dev/null 2>&1; then
    rfkill unblock all
  fi

  exec startx
fi
