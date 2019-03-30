#!/bin/bash

echo "# ========== BASHRC PS1 ========== #" 
# ---------- INSTANCE_NAME ----------
cat <<EOF> ~/instance_name
micro1
EOF
# ---------- EC2-USER ----------
cat <<EOF> ~/.bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
alias ll='echo \$(ls -Ahl | wc -l)'
alias lu="ls -a"
PS1='\[\033[00;32m\]\u\[\033[00m\]@\[\033[00;32m\]$(cat ~/instance_name):\[\033[00m\]\w\[\033[00;32m\]\$\[\033[0m\]\n'
EOF
# ---------- ROOT  ----------
cat <<EOF | sudo tee /root/.bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
alias ll='echo \$(ls -Ahl | wc -l)'
alias lu="ls -a"
PS1='\[\033[00;31m\]\u\[\033[00m\]@\[\033[00;31m\]$(cat ~/instance_name):\[\033[00m\]\w\[\033[00;31m\]\$\[\033[0m\]\n'
EOF
