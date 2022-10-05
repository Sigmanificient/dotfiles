# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P01E2030"
    echo -en "\e]P1B62A2A"
    echo -en "\e]P2338F4B"
    echo -en "\e]P3BD7E3A"
    echo -en "\e]P45B5BBE"
    echo -en "\e]P58B437A"
    echo -en "\e]P67AB5C1"
    echo -en "\e]P7D6D6D2"
    echo -en "\e]P86272A3"
    echo -en "\e]P9F11D1D"
    echo -en "\e]PA50FA7B"
    echo -en "\e]PBFFB86C"
    echo -en "\e]PC7C7CFF"
    echo -en "\e]PDC969B2"
    echo -en "\e]PE8BE9FD"
    echo -en "\e]PFF8F8F2"
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
