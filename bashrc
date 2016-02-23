# /etc/skel/.bashrc:
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
# if [[ -f ~/.dir_colors ]]; then
# 	eval `dircolors -b ~/.dir_colors`
# else
# 	eval `dircolors -b /etc/DIR_COLORS`
# fi
alias ls="ls --color=auto"

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
                PS1="\u@\h \W\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/[\1]/')\$ "
		;;
	screen*|screen-256color-bce)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
                PS1="\u@\h \W\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/[\1]/')\$ "
		;;
esac
umask 022

# Append any additional sh scripts found in /etc/profile.d/:
for profile_script in .profile.d/*.sh ; do
  if [ -x $profile_script ]; then
    . $profile_script
  fi
done
unset profile_script

# For non-root users, add the current directory to the search path:
if [ ! "`id -u`" = "0" ]; then
 PATH="$PATH:."
fi

# uncomment the following to activate bash-completion:
[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion


export PATH=/home/james/local/bin:/home/james/bin:/home/james/context/tex/texmf-linux-64/bin:$PATH:/home/james/.cabal/bin
export MANPATH=/home/james/local/share/man:$MANPATH
export VISUAL=nano
export EDITOR=nano
export PAGER=less
# export TEXINPUTS=figs//:styles//:$TEXINPUTS::
export BIBINPUTS=bib:$BIBINPUTS::
export BSTINPUTS=styles//:$BSTINPUTS::
export MAVEN_OPTS='-Xms256m -Xmx512m -XX:PermSize=64m -XX:MaxPermSize=128m'
export JAVA_HOME=/usr/lib64/java/jre

export TEXMFLOCAL=/home/james/texmf
TZ='America/Los_Angeles'; export TZ
#TZ='America/New_York'; export TZ
#TZ='Europe/Rome'; export TZ
#TZ='Europe/Paris'; export TZ

export CLOJURESCRIPT_HOME=/home/james/repos/clojurescript

alias e="emacsclient -a ''"
alias et="emacsclient -a '' -t"
alias ec="emacsclient -a '' -c"
export LESS=-MR
