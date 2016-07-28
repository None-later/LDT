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
# export JAVA_HOME=/usr/lib/jvm/java/


export PATH=$PATH:~/git/LDT/path


##############
## Aliases
#############

# .. cd 
alias ..="cd .. && pwd"

# bashrc editing
alias cbrc="cat ~/.bashrc"
alias vbrc="vim ~/.bashrc"
alias rbrc="source ~/.bashrc"

# c 
alias cut1="cut -f1 -d ' '"

# d - dnf
alias sdi="sudo dnf install" #Sudo dnf install
alias sdla="sudo dnf list available"

# g - Git, grep 
alias g="grep -i"
alias gs="git status"
alias grh="git reset --hard"

# l
alias la="ll -a"

# v
alias vpn="sudo vpnc" 

#################
## User functions
#################

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
