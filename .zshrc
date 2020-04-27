# Home folder tracked in a bare git repo
# https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.baredotfiles/ --work-tree=$HOME'

# Starship prompt
# https://github.com/starship/starship
eval "$(starship init zsh)"

# NVM
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
