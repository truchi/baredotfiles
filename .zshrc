# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ##################################### #
# > Variables                           #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

. "$HOME/dotfiles/zsh/functions.zsh"

DIR=~/dotfiles
NONE="$(tput sgr0)"
BOLD="$(tput bold)"
BLACK="$(tput setaf 0)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)" 
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
PURPLE="$(tput setaf 5)" 
CYAN="$(tput setaf 6)" 
WHITE="$(tput setaf 7)" 

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
# Command correction prompt
SPROMPT="${RED}%R${NONE}->${GREEN}%r${NONE}? [Nyae]"

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
bindkey '^ ' autosuggest-execute              # CTRL+SPC

# NPM completions caching
# https://github.com/sorin-ionescu/prezto/blob/master/modules/node/init.zsh#L31
cache_file=~/.cache/.node-cache.zsh
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
# > History                             #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Parameters
HISTFILE="$HOME/.cache/.zhistory_$USER" # History file location
HISTSIZE=1024                           # Max number of events stored in internal history list
SAVEHIST=$HISTSIZE                      # Max number of events stored in history file

# Options
setopt   SHARE_HISTORY                  # Shares history among sessions
setopt   EXTENDED_HISTORY               # Saves events with time and duration
setopt   HIST_IGNORE_DUPS               # Ignores successive dups
setopt   HIST_IGNORE_ALL_DUPS           # Removes older dups in history
setopt   HIST_SAVE_NO_DUPS              # Doesn't write dups
setopt   HIST_FIND_NO_DUPS              # Doesn't display dups when searching through history
setopt   HIST_REDUCE_BLANKS             # Removes superfluous blanks
setopt   HIST_IGNORE_SPACE              # Forgets commands with leading space (after next command)
setopt   HIST_NO_FUNCTIONS              # Forgets function definitions (after next command)
setopt   HIST_FCNTL_LOCK                # Locks with OS locking system

# Aliases
alias h='history'
alias hh='history -30 | tac | sk'

# History substring search plugin
# (https://github.com/zsh-users/zsh-history-substring-search)
# zsh-syntax-highlight has to be loaded before zsh-history-substring-search
zplug "zsh-users/zsh-history-substring-search"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ##################################### #
# > Keybindings                         #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Key remaps
setxkbmap -option                       # Removes previous mappings
setxkbmap -option caps:escape           # CAPS acts as ESC

# Parameters
KEYTIMEOUT=40                           # Multi char sequence timeout (ms)

# Keymap
bindkey -v                              # Vi keymap (-e for Emacs)

# Bindings
#   `read` or `showkey -a` to discover key sequences
#   `bindkey` to list bindings for current map
#   `zle -al` to list all zle widgets
# Move
bindkey "^[OA"      history-substring-search-up             # (UP       ) Searches substr up in history
bindkey "^[OB"      history-substring-search-down           # (DOWN     ) Searches substr down in history
bindkey "^[[1;2C"   end-of-line                             # (S-RIGHT  ) End of line
bindkey "^[[1;5C"   vi-forward-blank-word                   # (C-RIGHT  ) Beginning of next word
bindkey "^[[1;6C"   vi-forward-blank-word-end               # (C-S-RIGHT) End of word
bindkey "^[[1;3C"   vi-forward-word                         # (M-RIGHT  ) Beginning of next sub-word
bindkey "^[[1;4C"   vi-forward-word-end                     # (M-S-RIGHT) End of sub-word
bindkey "^[[1;2D"   beginning-of-line                       # (S-LEFT   ) Beginning of line
bindkey "^[[1;5D"   vi-backward-blank-word                  # (C-LEFT   ) Beginning of word TODO now this is same as M-LEFT... (with wordchars)
bindkey "^[[1;6D"   vi-backward-blank-word-end              # (C-S-LEFT ) End of previous word
bindkey "^[[1;3D"   vi-backward-word                        # (M-LEFT   ) Beginning of sub-word
bindkey "^[[1;4D"   vi-backward-word-end                    # (M-S-LEFT ) End of prev sub-word
# Kill & yank
bindkey "^V"        yank                                    # (C-V      ) Yank
bindkey "^[^H"      kill-buffer                             # (C-M-DEL  ) Kills whole buffer
bindkey "^[[3;5~"   kill-word                               # (C-DEL    ) Kills to end of word
bindkey "^[[3;3~"   kill-line                               # (M-DEL    ) Kills to end of buffer
bindkey "^H"        backward-kill-word                      # (C-BCK    ) Kills to beginning of word
bindkey "^[^?"      backward-kill-line                      # (M-BCK    ) Kills to beginning of buffer
# Undo & redo
bindkey "^Z"        undo                                    # (C-z      ) Undo
bindkey "^[z"       redo                                    # (M-z      ) Redo
# Good to know, in emacs keymap:
# (C-l) clear-screen
# (M-u) up-case-word
# (M-l) down-case-word
# (M-c) capitalize-word
# (C-w) backward-kill-word
# (M-s) spell-word
# (M-h) run-help
# NOTE
# beginning/end-of-line should have be C-M-LEFT/RIGHT but Ubuntu ...

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ##################################### #
# > Navigation & List                   #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Parameters
DIRSTACKSIZE=1000                       # Max size of directory stack

# Options
setopt   CHASE_LINKS                    # `cd` resovles symbolic links
setopt   AUTO_CD                        # Changes directory if command is not a command
setopt   AUTO_PUSHD                     # `cd` pushes to directory stack
setopt   PUSHD_IGNORE_DUPS              # Dedups directory stack
setopt   PUSHD_SILENT                   # Silences `pushd`
setopt   PUSHD_MINUS                    # `cd -` from most recent, `cd +n` from oldest
setopt   PUSHD_TO_HOME                  # `pushd` without args goes to $HOME

# Completions for . (-> ./) and .. (-> ../)
zstyle ':completion:*' special-dirs true

# Empty buffer completions
zle -N my-empty-buffer-completions
bindkey '^I' my-empty-buffer-completions # (TAB)

# Auto ls after cd
chpwd_functions+=(exa_function)

# Alias
alias sudo='sudo '
alias svim="nvim" # ~/.vim -> /home/romain/.SpaceVim
# alias lvim="lvim" # lunarvim has its own executable
alias nvid="neovide --maximized --frame=none --multigrid"
alias s="nvid --neovim-bin /usr/bin/nvim"
alias l="nvid --neovim-bin ~/.local/bin/lvim"
alias ll="exa --all --long --group --classify --icons --group-directories-first"
alias ,='cd -1'                         # Previous directory
alias ,,='cd -2'                        # Prev 2
alias ,,,='cd -3'                       # Prev 3
alias ,,,,='cd -4'                      # Prev 4
alias ,,,,,='cd -5'                     # Prev 5
alias ,,,,,,='cd -6'                    # Prev 6
alias ,,,,,,,='cd -7'                   # Prev 7
alias ,,,,,,,,='cd -8'                  # Prev 8
alias .=../                             # Parent directory
alias ..=../../                         # Up 2
alias ...=../../../                     # Up 3
alias ....=../../../../                 # Up 4
alias .....=../../../../../             # Up 5
alias ......=../../../../../../         # Up 6
alias .......=../../../../../../../     # Up 7
alias ........=../../../../../../../../ # Up 8

# Exa
# https://github.com/ogham/exa
export EXA_STRICT="true"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ##################################### #
# > Aliases / Functions                 #
# ##################################### #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# https://github.com/MichaelAquilina/zsh-you-should-use
zplug "MichaelAquilina/zsh-you-should-use"
export YSU_MESSAGE_FORMAT="${BOLD}${YELLOW}*** ${RED}%command${YELLOW} => ${GREEN}%alias${PURPLE} (%alias_type) ${YELLOW}***${NONE}"
export YSU_HARDCORE=1

# Home folder tracked in a bare git repo
# https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.baredotfiles/ --work-tree=$HOME'

# Dust
# https://github.com/bootandy/dust
alias du="dust"

# Procs
# https://github.com/dalance/procs
alias ps="procs --sortd cpu"
alias top="ps --watch"

# fd
# https://github.com/sharkdp/fd
alias find="fd"

# bat
# https://github.com/sharkdp/bat
alias cat="bat"

#########################################
#########################################
#########################################

# https://github.com/truchi/depmanager
zplug "truchi/depmanager", as:command, use:"dist/depmanager.sh", rename-to:"depmanager"

# Ripgrep config file
# https://github.com/BurntSushi/ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"

# Skim
# https://github.com/lotabout/skim
export SKIM_DEFAULT_COMMAND="fd --type file --color=always"
export SKIM_DEFAULT_OPTIONS="--ansi --no-mouse"

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

source /home/romain/.config/broot/launcher/bash/br
