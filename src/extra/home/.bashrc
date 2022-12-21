# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P00F0F1C"  # black
    echo -en "\e]P1D22942"  # red
    echo -en "\e]P217B67C"  # green
    echo -en "\e]P3F2A174"  # yellow
    echo -en "\e]P48C8AF1"  # blue
    echo -en "\e]P5D78AF1"  # magenta
    echo -en "\e]P68ADEF1"  # cyan
    echo -en "\e]P7A2B1E8"  # white

    echo -en "\e]P81A1C31"  # light black
    echo -en "\e]P9DE4259"  # light red
    echo -en "\e]PA3FD7A0"  # light green
    echo -en "\e]PBEED49F"  # light yellow
    echo -en "\e]PCA7A5FB"  # light blue
    echo -en "\e]PDE5A5FB"  # light magenta
    echo -en "\e]PEA5EBFB"  # light cyan
    echo -en "\e]PFCAD3F5"  # light white
    clear
fi

pre_prompt_command() {
    version="1.0.0"
    entity=$(echo $(fc -ln -0) | cut -d ' ' -f1)
    [ -z "$entity" ] && return # $entity is empty or only whitespace
    $(git rev-parse --is-inside-work-tree 2> /dev/null) && local project="$(basename $(git rev-parse --show-toplevel))" || local project="Terminal"
    (~/.wakatime/wakatime-cli --write --plugin "bash-wakatime/$version" --entity-type app --project "$project" --entity "$entity" 2>&1 > /dev/null &)
}

PROMPT_COMMAND="pre_prompt_command; $PROMPT_COMMAND"
