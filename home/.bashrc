# .bashrc
if [ -f /etc/bashrc ]; then # Source global definitions
	. /etc/bashrc
fi

# Color my PS1:
PS1='\[\e[1;34m\][\t \W]$ \[\e[m\]'
# https://www.linux.com/learn/how-make-fancy-and-useful-bash-prompt-linux
# e1:34 -  1=bold, 34=color.  
# \[\e[m\]  - stop color
# \t - time 
# \w - working dir.


# change prompt if in jhbuild shell
if [ -n "$UNDER_JHBUILD" ]; then
	    PS1="[jhbuild] $PS1"
fi
      

# Configue JAVA_HOME for building JNI
export JAVA_HOME=/usr/lib/jvm/java/

# by default, compile gtk3:
export GTK_VERSION=3.0

# Add my scripts to path:
export PATH=$PATH:~/git/LDT/path

# Configue my default editor:
export EDITOR=vim

# Colourize LESS:
## fix less:
export LESS="-eirMX"
# ALternatie
#export LESS=' -R'  # Color escape sequences are output in raw form.
#export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
#1) PyGmatize
# export LESSOPEN='|~/.lessfilter %s'
# http://superuser.com/questions/117841/get-colors-in-less-or-more
# 2) use 'most'
# install most
# export PAGER=most


# Add color to gcc:
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

##############
## Aliases
#############

# temp:
alias swt_webkit="set -x ;{ ./build.sh clean && make -f make_linux.mak make_webkit && ll | g .o$; }; set +x"

# .. cd 
alias ..="cd .. && pwd"

# bashrc editing
alias cbrc="cat ~/.bashrc"
alias vbrc="vim ~/.bashrc"
alias rbrc="source ~/.bashrc"

# a
alias a="alias"
alias ag="alias | g"
# b
alias backup_workspace="rsync -azh --info=progress2 ~/workspace_neon ~/workspace_neon_backup"

# c 
alias cd-swtbuild.sh="cd ~/git/eclipse.platform.swt/bundles/org.eclipse.swt/bin/library"
alias cd.="cd $(pwd)"
alias cut1="cut -f1 -d ' '"
alias lez="less -E"

# d - dnf
alias sdi="sudo dnf install" #Sudo dnf install
alias sdla="sudo dnf list available"
# e
# f
# g - Git, grep 
alias g="grep -i"
alias gs="git status"
alias grh="git reset --hard"
alias ggu="git add . && git commit -m 'general update' && git push"
alias not="grep -iv"
# h
# i
# j
# k
# l
alias la="ll -a"

# m
alias man="man -P most"
alias make=colormake

# n
# o
# p
# q
# r
alias rc="referenceGenerator.sh | toclip"
alias rcp="rsync -azh --info=progress2 "
# s
alias startssh="systemctl start sshd.service"
alias stopssh="systemctl stop sshd.service"
# t
# u
# v
alias vpn="sudo vpnc" 
alias v="vim"
# w


#################
## User functions
#################

gp () {
	git add .
	git commit -m "General update. Note: $1"
	git push
}

# f
ff () {
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
line () {
	sed -n $1p
}
