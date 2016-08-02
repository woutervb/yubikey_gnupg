#!/bin/bash

GPGVERS=$(gpg2 --version |grep gpg|awk '{print $3}'|cut -d"." -f2 )
if [ $GPGVERS -ge 1 ]; then
  gpg-connect-agent /bye
  if [ -S /run/user/$UID/gnupg/S.gpg-agent.ssh ] ; then
    export SSH_AUTH_SOCK=/run/user/$UID/gnupg/S.gpg-agent.ssh
  else
    export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
  fi
else
  # Copyright (c) 2010 Diego E. Pettenò <flameeyes@gmail.com>
  # Available under CC-BY license (Attribution)

  if ! [ -f "${HOME}/.gpg-agent-info" ] ||
     ! pgrep -u ${USER} gpg-agent >/dev/null; then
  	gpg-agent --daemon --enable-ssh-support --scdaemon-program /usr/libexec/scdaemon --use-standard-socket --log-file ~/.gnupg/gpg-agent.log --write-env-file
  fi

  # for ssh-agent forwarding, override gnome-keyring though!
  if [ -n ${SSH_AUTH_SOCK} ] && \
      [ ${SSH_AUTH_SOCK#/tmp/keyring-} = ${SSH_AUTH_SOCK} ]; then
  
      fwd_SSH_AUTH_SOCK=${SSH_AUTH_SOCK}
  fi

  export SSH_AUTH_SOCK

  if [ "${fwd_SSH_AUTH_SOCK}" != "" ]; then
      SSH_AUTH_SOCK=${fwd_SSH_AUTH_SOCK}
      export SSH_AUTH_SOCK
  fi

  source ${HOME}/.gpg-agent-info
  export GPG_AGENT_INFO
  export SSH_AGENT_PID

  GPG_TTY=$(tty)
  export GPG_TTY
fi
