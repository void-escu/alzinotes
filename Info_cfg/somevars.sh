#!/bin/bash


export PS1="[\u]\w> "

alias psgw='/usr/ucb/ps -axww | grep'
unmanglefct() { echo $1 | /opt/SS11/SUNWspro/bin/c++filt; }; alias unmangle=unmanglefct;


