# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ##################################### #
# > Variables                           #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

DIR=~/dotfiles
NONE="$(tput sgr0)"
BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)" 
YELLOW="$(tput setaf 3)"
PURPLE="$(tput setaf 5)" 

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ##################################### #
# > Plugin Managment                    #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# https://github.com/zplug/zplug
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ##################################### #
# > Completions                         #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Parameters
SPROMPT='%R->%r? [Nyae]'                # Command correction prompt

# Options
setopt   CORRECT                        # Tries to correct misspelled commands (no,yes,abort,edit)
unsetopt AUTO_REMOVE_SLASH              # Remove slashes at end of completions
setopt   EXTENDED_GLOB                  # ‘#’, ‘~’ and ‘^’ treated as pattern part for file extension
setopt   GLOB_DOTS                      # Matches dotfiles

# https://github.com/mattjj/my-oh-my-zsh/blob/master/completion.zsh
# Highlight current completion
zstyle ':completion:*' menu select

# Approximate completions
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# Group matches and describe
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Command not found
source '/etc/zsh_command_not_found'

# Auto suggestions plugin 
# https://github.com/zsh-users/zsh-autosuggestions
zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=black"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^ ' autosuggest-accept              # CTRL+SPC

# NPM completions caching
# https://github.com/sorin-ionescu/prezto/blob/master/modules/node/init.zsh#L31
cache_file="$DIR/caches/.node-cache.zsh"
if [[ "$commands[npm]" -nt "$cache_file" || ! -s "$cache_file" ]]
then
  npm completion >! "$cache_file" 2> /dev/null
fi
source "$cache_file"
unset cache_file

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ##################################### #
# > Prompts                             #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Options
setopt   INTERACTIVE_COMMENTS           # Allows comments in interactive shells

# Starship prompt
# https://github.com/starship/starship
eval "$(starship init zsh)"

# Syntax highlight plugin
# https://github.com/zsh-users/zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:2
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Autopair
# https://github.com/hlissner/zsh-autopair
zplug "hlissner/zsh-autopair"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ##################################### #
# > Aliases / Functions                 #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# https://github.com/MichaelAquilina/zsh-you-should-use
zplug "MichaelAquilina/zsh-you-should-use"
export YSU_MESSAGE_FORMAT="${BOLD}${YELLOW}*** ${RED}%command${YELLOW} => ${GREEN}%alias${PURPLE} (%alias_type) ${YELLOW}***${NONE}"
export YSU_HARDCORE=1

#########################################
#########################################
#########################################

# https://github.com/truchi/alwaysontop
# zplug "truchi/alwaysontop", defer:2

# Home folder tracked in a bare git repo
# https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.baredotfiles/ --work-tree=$HOME'

# NVM
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# ZPLUG install
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
