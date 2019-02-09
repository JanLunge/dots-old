#gruvbox vim theme
#https://github.com/morhetz/gruvbox/wiki/Installation
#
#export ZSH=$HOME/.oh-my-zsh
#ZSH_THEME=geometry/geometry
[[ $TERM = xterm* ]] && TERM='xterm-256color'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# # export MANPATH="/usr/local/man:$MANPATH"
#
#source $HOME/antigen.zsh
source $(brew --prefix)/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

antigen theme geometry-zsh/geometry
antigen apply
#source $ZSH/oh-my-zsh.sh

#

# # Example aliases
alias zshconfig="open ~/.zshrc"
alias settings="open ~/.bash_profile"
alias ohmyzsh="open ~/.oh-my-zsh"

alias sshvserver="ssh jan@heaper.de"
alias wstore="ssh jan@wstore.ddns.net"

alias composer="php /usr/local/bin/composer.phar"

# Go development
export GOPATH="${HOME}/.go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

#docker
function undockall {
    docker stop $(docker ps -a -q)
}
alias updock="docker-compose up -d"
alias lsdock="docker ps"
alias swdock="undockall && updock"

#maintainance
alias chmoddir="find . -type d -name \* -exec chmod 775 {} \;"
alias chmodfiles="find . -type f -exec chmod 644 {} \;"

#new vim
#alias vim="nvim"

#sudo
alias fuck='sudo $(fc -ln -1)'
alias _='sudo'
alias please='sudo'

#art
function rusto {
    figlet -f rusto $1 | lolcat
}
function rustofat {
    figlet -f rustofat $1 | lolcat
}
function slant {
    figlet -f slant $1 | lolcat
}
function cyberlg {
    figlet -f cyberlarge $1 | lolcat
}
function cybermd {
    figlet -f cybermedium $1 | lolcat
}
function cybersm {
    figlet -f cybersmall $1 | lolcat
}
function drpepper {
    figlet -f drpepper $1 | lolcat
}
function small {
    figlet -f small $1 | lolcat
}
function lolt {
    figlet -f $1 $2 | lolcat
}
#isometric1 -4
#poison
#rectangles
#rozzo
#smisome1
#stampatello
#colossal
#chunky

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
# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function c() {
	if [ $# -eq 0 ]; then
		code .;
	else
		code "$@";
	fi;
}

#bookmarks
function cdvn() {
	cd ~/Code/MyVan/;clear;slant 'MyVan'
}
function cdac() {
	cd ~/Code/AlwaysCurious/;clear;slant 'AlwaysCurious'
}
function cdlm() {
	cd ~/Code/lebenMitMS/;clear;slant 'Leben Mit MS'
}
alias pcat='pygmentize -f terminal256 -O style=native -g'
alias rechunk='brew services restart chunkwm'
alias chrome='open -a "Google Chrome"'

#setup
function setupconfs(){
    defaults write com.apple.Dock showhidden -bool true #was YES
}

slant 'hello Jan'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

alias craftman="/Users/jan/.craftman/bin/craftman"
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
 
notica() { curl --data "d:$*" https://notica.us/\?sY2iBUv8 ; }

alias sshfork="ssh fork@myvan.fork.de"
