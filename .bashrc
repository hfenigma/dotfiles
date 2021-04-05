#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias rm="trash-put"
alias cp2="rsync -ah --progress"
alias free='free -h'
alias df='df -h'
alias ls='exa'
alias ll='exa -l'
alias cat='bat -pp'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias paclog='~/scripts/paclog.py'
alias music='mpv --volume=60 --shuffle --loop-playlist=inf --no-resume-playback --audio-display=no ~/Music/'
alias weather='curl -m 5 "https://wttr.in/${LOCATION_CITY}?lang=zh&format=v2"'
alias ncdu='ncdu --color dark'
alias dot='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
alias miniconda='source ~/.local/miniconda3/bin/activate $(echo -e "base\n$(ls ~/.local/miniconda3/envs)" | fzf)'
alias yaySc="yay -Sc --noconfirm"
alias scripts='$(fd -t x . ~/scripts/ | fzf)'

windows() {
    if ! command -v pgrep > /dev/null ; then
        echo "pgrep could not be found"
        return 1
    fi
    if pgrep -x sway > /dev/null ; then
        swaymsg -t get_tree | jq -r '.. | select( .class? ) | {class: .class, title: .title}'
        swaymsg -t get_tree | jq -r '.. | select( .app_id? ) | {app_id: .app_id, title: .name}'
    elif pgrep -x i3 > /dev/null ; then
        i3-msg -t get_tree | jq -r '.. | select( .class?) | {class: .class, title: .title}'
    fi
}

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

export VISUAL="vim"
export LESSHISTFILE=/dev/null
export EXA_COLORS='da=38;5;33'

# HSTR configuration
export HSTR_CONFIG=hicolor,raw-history-view       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignoreboth    # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between Bash memory and history file
export PROMPT_COMMAND='history -a; history -n'
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi

# completion for git alias
if [[ -r /usr/share/bash-completion/completions/git ]]; then
    . /usr/share/bash-completion/completions/git
    __git_complete dot __git_main
fi

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude .git --exclude node_modules'
export FZF_DEFAULT_OPTS="-1 --no-mouse --reverse --multi --inline-info"

# starship
eval "$(starship init bash)"

