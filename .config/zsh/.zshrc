#!/bin/sh
# Basic colors
TERM=xterm-256color
autoload -Uz colors && colors

# Zsh completion config
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' group-name ''
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots) # Show dotfiles

# Vcs for git prompt info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "[%{$fg[blue]%}%b%{$reset_color%}] (%{$fg[yellow]%}%c%{$fg[green]%}%u%{$reset_color%}) %{$fg[yellow]%}%s%{$fg[blue]%}:%r%{$reset_color%}"

# Commands to run
function precmd() {
    vcs_info
    window_title="\033]0;${PWD} - $(echo /usr/local/bin/zsh | rev | cut -d '/' -f 1 | rev | awk '{ print toupper($0) }')\007"
    echo -ne "$window_title"
} # Run before each prompt

# Vim commandline mode config
bindkey -v
export KEYTIMEOUT=1
vim_ins_mode="%{$fg[yellow]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[cyan]%}[CMD]%{$reset_color%}"
# vim_vis_mode="%{$fg[red]%}[VIS]%{$reset_color%}"
vim_mode=$vim_ins_mode
function zle-line-init zle-keymap-select {
    case ${KEYMAP} in
        (vicmd) vim_mode=$vim_cmd_mode && echo -ne '\e[1 q' ;;
        (main|viins) vim_mode=$vim_ins_mode && echo -ne '\e[5 q' ;;
        # (visual|viopp) vim_mode=$vim_vis_mode ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Vim keys in tab complete menu:
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -v "^?" backward-delete-char

# Vim bindings in quotations
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

# Vim bindings in brackets
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done

# Edit command in vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

# Prompt styling
setopt PROMPT_SUBST
PROMPT="%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M:%{$fg[magenta]%}%c%{$fg[red]%}]%{$reset_color%}$ "
RPROMPT='${vim_mode} ${vcs_info_msg_0_}'

# Expand aliases to actual commands
function expand-alias() {
	zle _expand_alias
	zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias

# History file
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/history

# Quick bindings
bindkey -s "^o" "lfcd\n"

# Pip completion
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip3

# Source files
[ -f "$HOME/.config/zsh/.zprofile" ] && source "$HOME/.config/zsh/.zprofile"
[ -f "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" ] && source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
[ -f "$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ] && source "$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"

# Alias overwrite
alias repr="source $HOME/.config/zsh/.zshrc"

# Prompt syntax highlight
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=red,underline'

# Miniconda3
__conda_setup="$('/Users/frank/Miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/frank/Miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/frank/Miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/frank/Miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
