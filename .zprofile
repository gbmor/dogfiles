export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# use gpg-agent for ssh
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye > /dev/null
#gpgconf --launch gpg-agent
gpgconf --create-socketdir

ulimit -n 8096
