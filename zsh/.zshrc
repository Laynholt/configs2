# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export ZDOTDIR=$HOME/.config/zsh
# source "$ZDOTDIR/plugins"

# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY 
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/root/.config/zsh/.zshrc'

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# Plugins
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source ~/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.config/zsh/plugins/sudo/sudo.plugin.zsh

source ~/.config/zsh/plugins/libs/clipboard.zsh
source ~/.config/zsh/plugins/copyfile/copyfile.plugin.zsh
source ~/.config/zsh/plugins/copypath/copypath.plugin.zsh

source ~/.config/zsh/plugins/jsontools/jsontools.plugin.zsh
source ~/.config/zsh/plugins/gitignore/gitignore.plugin.zsh

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#b29daf,bg=#3a3231"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#b29daf,bg=#2b2524"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Change vim dir
export VIMINIT="source ~/.config/vim/.vimrc"

# Aliases
alias py=python3
alias python=python3
alias vim-r='source ~/.config/vim/.vimrc'
alias zsh-r='source ~/.config/zsh/.zshrc'
alias cls=clear

alias cpf=copyfile
alias cpp=copypath

# ls
TREE_IGNORE="cache|log|logs|node_modules|vendor"

alias ls=' exa --group-directories-first --icons --grid'
alias lsa=' ls -a'
alias la='ls -a'
alias lsl=' ls -l --header'
alias lst=' ls --tree -D -L 2 -I ${TREE_IGNORE}'
alias ls2t=' ls --tree -D -L 3 -I ${TREE_IGNORE}'
alias ls3t=' ls --tree -D -L 4 -I ${TREE_IGNORE}'
alias ls4t=' ls --tree -D -L 5 -I ${TREE_IGNORE}'
alias tree=' exa --tree --group-directories-first --icons --grid'

# utf locale
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# for VIM and TMUX
if [ "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi
#alias tmux='tmux -2u'  # for 256color and to get rid of unicode rendering problem

