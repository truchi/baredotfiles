# Autocomplete on empty buffer (@see https://github.com/nachoparker/tab_list_files_zsh_widget)
my-empty-buffer-completions() {
    # $<TAB> -> change directory
    if [[ $#BUFFER == 0 ]]
    then
        BUFFER="cd "
        CURSOR=3
        zle list-choices
    # $<SPC><SPC><TAB> -> executables
    elif [[ $BUFFER =~ ^[[:space:]][[:space:]].*$ ]]
    then
        BUFFER="./"
        CURSOR=2
        zle list-choices
    # $<SPC><TAB> -> print file
    elif [[ $BUFFER =~ ^[[:space:]]*$ ]]
    then
        BUFFER="cat "
        CURSOR=4
        zle list-choices
    # $,<TAB> -> previous directories
    elif [[ $BUFFER =~ ^,*$ ]]
    then
        BUFFER="cd -"
        CURSOR=4
        zle list-choices
    # $.<TAB> -> parent directories
    elif [[ $BUFFER =~ '^(\.)*$' ]]
    then
        BUFFER="up "
        CURSOR=3
        zle list-choices
    # Defaults to usual completion
    else
        zle expand-or-complete
    fi
}

# Up: go to parent dir, with competions!
up () {
    if [[ $# == 0 ]]
    then
        cd ../
    else
        cd $1
    fi
}

_up() {
    local dir
    local parent
    local -a dirs
    local -a strs

    dir=$(pwd)
    parent=$(dirname $dir)
    dirs=($parent)
    strs=($parent)

    if [[ $parent == $dir ]]
    then
        return
    fi

    while [[ $parent != $dir ]]; do
        dir=$parent
        parent=$(dirname $dir)
        dirs=($dirs $parent)
        strs=($strs $parent)
    done

    compadd -l -V "" -d strs -a dirs
}

compdef _up up

