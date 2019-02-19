#zmodload zsh/zprof

# Requrements:
# brew install exa
# Json helper from the appstore


# tools:
# go get -u github.com/fogleman/primitive

# quicklook for .md, .json, better images, colored code, unknown text files
# from https://github.com/sindresorhus/quick-look-plugins
# brew cask install qlcommonmark
# brew cask install quicklook-json
# brew cask install qlimagesize ?? gone
# brew cask install qlcolorcode
# brew cask install qlstephen
# brew cask install quicklook-csv
# to remember: stl http://www.elektriktrick.com/sw_quicklook.html, https://www.thingiverse.com/thing:376361
#
#

# ZSH Setup
case `uname` in
  Darwin)
    platform='mac'
  ;;
  Linux)
    platform='linux'
  ;;
esac

[[ $TERM = xterm* ]] && TERM='xterm-256color'

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

e_header()  { echo -e "\n\033[1m$@\033[0m"; }
e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }

# Load zgen only if a user types a zgen command
zgen () {
	  if [[ ! -s ${HOME}/.zgen/zgen.zsh ]]; then
		    git clone --recursive https://github.com/tarjoilija/zgen.git ${ZDOTDIR:-${HOME}}/.zgen
	  fi
	  source ${HOME}/.zgen/zgen.zsh
	  zgen "$@"
}
# check if there's no init script
if [[ ! -s ${HOME}/.zgen/init.zsh ]]; then
    echo "Creating a zgen save"
    # specify plugins here
    zgen prezto
    #zgen prezto git
    #zgen prezto command-not-found
	  zgen prezto tmux
    zgen prezto syntax-highlighting

    #zgen load TBSliver/zsh-plugin-colored-man
    zgen load zdharma/fast-syntax-highlighting
    #zgen load trapd00r/zsh-syntax-highlighting-filetypes
    #zgen load zsh-users/zsh-syntax-highlighting
    zgen load tarruda/zsh-autosuggestions
    zgen load zsh-users/zsh-completions

    zgen load geometry-zsh/geometry
    # generate the init script from plugins above
    zgen save
    zcompile ${HOME}/.zgen/init.zsh
else
    source ${HOME}/.zgen/init.zsh
fi

# User configs
alias sshvserver="ssh jan@heaper.de"
alias wstore="ssh jan@www.wsto.re"

# Go development
#TODO: add support for linux with install instructions
export GOPATH="${HOME}/.go"
# export GOROOT="/usr/local/Cellar/go/1.11.1/libexec"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
#TODO: dont check every time 
#test -d "${GOPATH}" || mkdir "${GOPATH}"
#test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

#docker
function undockall {
    docker stop $(docker ps -a -q)
}
alias updock="docker-compose up -d"
alias lsdock="docker ps"

# maintainance
alias chmoddirs="find . -type d -name \* -exec chmod 775 {} \;"
alias chmodfiles="find . -type f -exec chmod 644 {} \;"

#sudo
alias fuck='sudo $(fc -ln -1)'
alias _='sudo'
alias please='sudo'

#art
function rusto {
    figlet -f rusto $1 | lolcat
}
function slant {
    figlet -f slant $1 | lolcat
}

#isometric1 -4
#poison
#rectangles
#rozzo
#smisome1
#stampatello
#colossal
#chunky
#small
#drpepper
#cybersmall
#cybermedium
#cyberlarge
#rustofat

#git
alias ga="git add"
alias gam="git ls-files --modified | xargs git add"
alias gc="git commit -m"
alias gs="git status"
alias gd="git diff"
alias gf="git fetch"
alias gm="git merge"
alias gr="git rebase"
alias gp="git push"
alias gpl="git pull"
alias gu="git unstage"
alias gg="git graph"
alias gco="git checkout"
alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"


#finder
alias hide='chflags hidden'
alias unhide='chflags nohidden'
alias showfinderhidden="defaults write com.apple.Finder AppleShowAllFiles true && killall Finder"
alias hidefinderhidden="defaults write com.apple.Finder AppleShowAllFiles false && killall Finder"

#create dir and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}
# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
	cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

alias pcat='pygmentize -f terminal256 -O style=native -g'

function updateMusic(){
  cd ~/Music/Youtube/
  youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --no-post-overwrites -ciwx --embed-thumbnail --add-metadata --download-archive downloaded.txt --output '%(playlist)s/%(title)s - %(id)s.%(ext)s' PLdbIj_aeQsBZnF-dX8Pk_BrU-AidCUP_G
}

#slant 'hello Jan'

#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
#use pushbullet pls
#notica() { curl --data "d:$*" https://notica.us/\?sY2iBUv8 ; }

#use mpv pls
#alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
#alias cvlc='/Applications/VLC.app/Contents/MacOS/VLC -I rc'

# Sudo
ZSH_HIGHLIGHT_PATTERNS+=('sudo ' 'fg=white,bold,bg=214')
#zprof
