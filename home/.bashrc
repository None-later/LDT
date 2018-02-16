#################
# Development helpers. (most is temporary code)
#################
export SWT_WEBKIT2=1
export SWT_LIB_VERSIONS=1
export SWT_WEBKIT_DEBUG_MSGS=1


##################
## Terminal Conig
##################

# .bashrc
if [ -f /etc/bashrc ]; then # Source global definitions
	. /etc/bashrc
fi

# change prompt if in jhbuild shell
if [ -n "$UNDER_JHBUILD" ]; then
	    PS1="[jhbuild] $PS1"
fi
      
# Add my scripts to path:
export PATH=$PATH:~/git/LDT/path

# Configue my default editor:
export EDITOR=vim


##############
### History
#############
# Keep long history and
# sync history between tabs.
# src: https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows#answer-48116
# USAGE:
# history | grep CMD
# !1234
HISTSIZE=100000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

_bash_history_sync() {
  builtin history -a         #1
  HISTFILESIZE=$HISTSIZE     #2
  builtin history -c         #3
  builtin history -r         #4
}

history() {                  #5
  _bash_history_sync
  builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync

shopt -s histverify  # 'history' & !ID will present command for editing before running it.
shopt -s histreedit  #not really sure, but redit line if history exec failed?


##############
## Key bindings inside terminal
##############
# use 'ctrl-v' press KEY to find keycode.
# substitute ^[ with \e
# bind 
# bind -x  for executing commands.

bind -x '"\eOP":"ll -a"'                  # F1 = ls -a
bind '"\eOQ": " $(!!) "'                  # F2 = $(!!) 
bind -x '"\eOR":" cd ~/ && pwd"'          # F3 = cd ~/
bind -x '"\eOS":" cd ~/git/ && pwd"'      # F4 = cd ~/git
bind '"\e[15~":" 2> /dev/null > /dev/null &"' # F5 = run in backgrounud, no output.

##############
## Aliases
#############

# temp:
# alias swt_webkit="set -x ;{ ./build.sh clean && make -f make_linux.mak make_webkit && ll | g .o$; }; set +x"

# .. cd 

# bashrc editing
alias vbrc="vim ~/.bashrc && source ~/.bashrc && echo 'bashrc reloaded'"
alias rbrc="source ~/.bashrc"

# a
alias a="alias"
alias ag="alias | g"

# b
alias l.bzfollwoup='VAR=`for i in $(seq 2 $(date +%W)); do printf ",W%02d" $i; done; echo ""`; firefox "https://bugs.eclipse.org/bugs/buglist.cgi?quicksearch=%40luf tag:W01$VAR"'

#alias backup_workspace="rsync -azh --info=progress2 ~/workspace_neon ~/workspace_neon_backup"
# c 
alias ..="cd .. && pwd"
alias cd.="cd $(pwd)"
alias cr='printf "\033c"'

# d - dnf
alias sdi="sudo dnf install" #Sudo dnf install
alias sdla="sudo dnf list available"
alias sdli="sudo dnf list installed"
alias sdl="sudo dnf list"
alias sds="sudo dnf search"
# e
# f
# g - Git, grep 
alias g="grep --color=always -i -I -s"  #i= ignore uppercase. I=Ignore binary s= suppress error messages.
alias ga.="git add ."
alias gcm="git commit -m"
alias gs="git status"
alias grh="git reset --hard"
alias ggu="git add . && git commit -m 'general update' && git push"

alias ngrep="grep -iv"
# h
# i
# j
# k
# l
alias lla="ll -a"
#alias lld="ll --group-directories-first"
alias lld="ll -d */"
alias lsd="ls -d */"
alias less="less -r"  # read coloured output.
# alias lock="gnome-screensaver-command -l"

# list date/time file only.
alias lst='ls -alh | while read perm bsize user group size month day time file; do echo $size $month $day $time $file; done'

# m
#alias man="man -P most"
alias make=colormake

# n
# o
# p
# q
alias quiet="&> /dev/null "
# r
alias rc="referenceGenerator.sh | setclip"
alias rcp="rsync -azh --info=progress2 "
# alias rsync-workspace="rsync -r --delete ~/workspace/ ~/workspacecopy"

# s
alias s="sudo"
alias startssh="systemctl start sshd.service"
alias stopssh="systemctl stop sshd.service"
# t
# u
# v
alias vim=vimx
# w

#################################
############## COLOURING 
#################################

###################
### Color my Prompt
###################
PS1='\[\e[1;34m\][\t \W]$ \[\e[m\]'
# https://www.linux.com/learn/how-make-fancy-and-useful-bash-prompt-linux
# e1:34 -  1=bold, 34=color.  
# \[\e[m\]  - stop color
# \t - time 
# \w - working dir.

####################
#### Colourize LESS:
####################
# *) TERM_CAP method
# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"
# Use colors for less, man, etc.
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green 
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan 
export LESS_TERMCAP_me=$(tput sgr0) 
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue 
export LESS_TERMCAP_se=$(tput rmso; tput sgr0) 
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white 
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0) 
export LESS_TERMCAP_mr=$(tput rev) 
export LESS_TERMCAP_mh=$(tput dim) 
export LESS_TERMCAP_ZN=$(tput ssubm) 
export LESS_TERMCAP_ZV=$(tput rsubm) 
export LESS_TERMCAP_ZO=$(tput ssupm) 
export LESS_TERMCAP_ZW=$(tput rsupm) 
# src: https://unix.stackexchange.com/questions/119/colors-in-man-pages

# Alternatives

#export LESS="-eirMX"  # Seems to work mostly

#export LESS=' -R'  # Color escape sequences are output in raw form.
#export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"

# 1) PyGmatize
# export LESSOPEN='|~/.lessfilter %s'
# http://superuser.com/questions/117841/get-colors-in-less-or-more

# 2) use 'most'
# install most
# export PAGER=most

###################
#### Colourize GCC
##################
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"


##################
#### User function
##################



##########
### Finding and enumirating output:
########## 
# https://unix.stackexchange.com/questions/378270/find-command-enumerate-output-and-allow-selection/378277?noredirect=1#comment673124_378277

# V1
# find -name feature.xml | nl
# vim $(!!s 2)
nls () { head -n $1 | tail -n 1 ;}

# V2
# num find -name feature.xml | sel 2
# vim $(!!)
num () { "$@" | sed 's!^\./!!' | nl; }
sel () {  sed -nr "$1"'{s/^\s+'"$1"'\t//p;q}'; }

# V3
findexec () {
        # Usage: findexec <cmd> <name/pattern>
	# ex: findexec vim pom.xml
	IFS=$'\n'; 
	select file in $(find -type f -name "$2"); do
  		#$EDITOR "$file"
  		"$1" "$file"
		break
	done; 
	unset IFS
}

##############################################################################
###################################################################### END
###############################################################################
### DEPRECATED BELOW
####################


# DEPRECATED:
# Configue JAVA_HOME for building JNI
# export JAVA_HOME=/usr/lib/jvm/java/

#################
## User functions (Deprecated)
#################

# Git branches with descriptions
# https://github.com/bahmutov/git-branches#adding-to-bash_profile
deprecated_gitb () {
    branch=""
    branches=`git branch --list`
    while read -r branch; do
    clean_branch_name=${branch//\*\ /}
    description=`git config branch.$clean_branch_name.description`
    printf "%-35s %s\n" "$branch"  "$description"
    done <<< "$branches"
}
deprecated_gbd () {
	git branch --edit-description 
}


deprecated_gp () {
	git add .
	git commit -m "General update. Note: $1"
	git push
}

# f
deprecated_ff () {
	# Find File
	# - Dependencies: line
	# - About:
	# if $2 is given, then navigate into the folder of that file.
	# I should probably make this more generic, i.e $2 should only produce filename, then use some other flag for cd-ing..
	if [ -n "$2" ]
	then
		cd "$(find . | grep -i "$1" | line "$2" | xargs -0 dirname)"
	else 
		find . | grep -i "$1" | nl -nln | grep -i "$1"
	fi
}

# l
deprecated_line () {
	sed -n $1p
}

