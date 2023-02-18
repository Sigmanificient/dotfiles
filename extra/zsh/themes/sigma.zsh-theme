ZSH_THEME_GIT_PROMPT_PREFIX=" - %F{blue}[%F{red}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue}]%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{green}+"
ZSH_THEME_GIT_PROMPT_CLEAN=""

local pwd="%F{blue}[%f%F{grey}%~%F{blue}]%f"
local user="%F{blue}[%F{green}%n%f@%F{cyan}%m%F{blue}]%f"
local count="%F{blue}[%b%F{yellow}%!%F{blue}%B]%f"
local decoration="%F{magenta}$%F{blue}"

local sep="%b-%B"
PROMPT=$'%B%F{blue}┌─$user $sep $pwd$(git_prompt_info) $sep $count%B%F{blue}\n└─[$decoration]%f '
RPROMPT="[%*]"
PS2="%F{magenta}>%f "
PS3="%F{magenta}>%f "
