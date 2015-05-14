# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export TEMP=$HOME/tmp
export PATH=/opt/ActivePerl-5.8/bin:$HOME/apache-maven/bin:$PATH
export SITE=

source ~/env/envDev.sh
source ~/.aliases

#export http_proxy=http://proxy
export http_proxy=http://proxy
export https_proxy=http://proxy
export ftp_proxy=http://proxy
#gopher_ wais_
export no_proxy="localhost,127.0.0.1,10.0.0.0/8"

#sudo
#Defaults env_keep +="http_proxy https_proxy ftp_proxy"

# User specific aliases and functions

export SciTE_HOME=~/bin/gscite

PS1='\[\033[$([ $? == 0 ] && echo "32m" || echo "31m" )\][$(date +%H:%M)][\u@\h:\w]$\[\033[0m\] '
export PS1_save='\[\033[$([ $? == 0 ] && echo "32m" || echo "31m" )\][$(date +%H:%M)][\u@\h:\w]$\[\033[0m\] '
export PS1=$PS1_save
