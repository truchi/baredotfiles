# Path
path+=("$HOME/dotfiles/bin" "$HOME/.config/composer/vendor/bin")
path+=("$HOME/perso/rust/cargo-den/target/debug")
export PATH

# Apps
export VISUAL=lvim
export EDITOR=$VISUAL
export PAGER='less'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export GIT_PAGER="delta"
export BAT_THEME="OneHalfLight"

# Man pages colors
export LESS_TERMCAP_mb=$'\e[1;31m'      # begin bold
export LESS_TERMCAP_md=$'\e[1;36m'      # begin blink
export LESS_TERMCAP_me=$'\e[0m'         # reset bold/blink
export LESS_TERMCAP_so=$'\e[01;44;33m'  # begin reverse video
export LESS_TERMCAP_se=$'\e[0m'         # reset reverse video
export LESS_TERMCAP_us=$'\e[1;32m'      # begin underline
export LESS_TERMCAP_ue=$'\e[0m'         # reset underline

# Ls colors
. "$HOME/dotfiles/zsh/lscolors.sh"
