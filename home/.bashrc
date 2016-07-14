# .bashrc
if [ -f /etc/bashrc ]; then # Source global definitions
	. /etc/bashrc
fi

# change prompt if in jhbuild shell
if [ -n "$UNDER_JHBUILD" ]; then
	    PS1="[jhbuild] $PS1"
fi
      

# Configue JAVA_HOME for building JNI
# export JAVA_HOME=/usr/lib/jvm/java/


export PATH=$PATH:~/git/LDT/path
alias ..="cd .. && pwd"
#alias ...="cd ../.."
alias gs="git status"
alias la="ll -a"
alias cbrc="cat ~/.bashrc"
alias vbrc="vim ~/.bashrc"
alias rbrc="source ~/.bashrc"
alias sdi="sudo dnf install" #Sudo dnf install
alias sdla="sudo dnf list available"
alias cut1="cut -f1 -d ' '"
alias g="grep -i"
alias ccc="echo !! | toclip"

# User functions
line () {
	sed -n $1p
}

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
