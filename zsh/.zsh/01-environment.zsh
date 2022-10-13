#                 ██      
#                ░██      
#  ██████  ██████░██      
# ░░░░██  ██░░░░ ░██████  
#    ██  ░░█████ ░██░░░██ 
#   ██    ░░░░░██░██  ░██ 
#  ██████ ██████ ░██  ░██ 
# ░░░░░░ ░░░░░░  ░░   ░░  
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░
#
#█▓▒░ timestamps
#HIST_STAMPS=yyyy/mm/dd

#█▓▒░ paths
export PATH=/usr/local/bin:$HOME/bin:$HOME/bin/build-wrapper-linux-x86:$HOME/.gem/ruby/2.5.0/bin:$HOME/.gem/ruby/2.6.0/bin/:$HOME/src/go/bin/:$HOME/.local/bin:$PATH
#export MANPAGER="vim -c 'set ft=man' -"
#export MANPATH=/usr/local/man:$MANPATH

#█▓▒░ VALUT
export VAULT_ADDR=https://vault-amer.adobe.net

#█▓▒░ preferred text editor
export EDITOR="code --wait"
export VISUAL="code --wait"

#█▓▒░ language
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LESSCHARSET=utf-8

#█▓▒░ go lang
export GOPATH=$HOME/src/go
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

#█▓▒░ Node
eval "$(nodenv init -)"

#█▓▒░ java fixes
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"

#█▓▒░ no mosh titles
export MOSH_TITLE_NOPREFIX=1
