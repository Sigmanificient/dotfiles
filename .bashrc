# ~/.bashrc
#

if [ $TERM = "linux" ]; then
  setfont ter-116n
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

pre_prompt_command() {
  version="1.0.0"
  entity=$(echo $(fc -ln -0) | cut -d ' ' -f1)
  [ -z "$entity" ] && return # $entity is empty or only whitespace
  $(git rev-parse --is-inside-work-tree 2>/dev/null) && local project="$(basename $(git rev-parse --show-toplevel))" || local project="Terminal"
  (~/.wakatime/wakatime-cli --write --plugin "bash-wakatime/$version" --entity-type app --project "$project" --entity "$entity" 2>&1 >/dev/null &)
}

PROMPT_COMMAND="pre_prompt_command; $PROMPT_COMMAND"
