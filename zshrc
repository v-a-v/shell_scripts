##################################################
##		 My /etc/zshrc			##
##################################################
##
case $TERM in linux)
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
bindkey " " magic-space ## do history expansion on space
;;
*xterm*|rxvt|(dt|k|E)term)
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
bindkey " " magic-space ## do history expansion on space
;;
esac

# Use hard limits, except for a smaller stack and no core dumps 
unlimit
limit stack 8192
limit core 0
limit -s

#######
umask 022

# Some environment variables
export NNTPSERVER='3.europe.pool.ntp.org'
export MAIL=/var/mail/$USERNAME
export LESS=-cex3M
export HELPDIR=/usr/local/share/doc/zsh  # directory for run-help function to find docs
export LESS="-R"
export ORACLE_HOME=/usr/lib/oracle/11.2/client64
export NLS_LANG=RUSSIAN_CIS.UTF8;

# The options {{{
# Watch for logins
watch=(dope root)
# Watch for my friends
#watch=( $(<~/.friends) )       # watch for people in .friends file
#watch=(notme)                   # watch for everybody but me

# The format of login / logout reports if the watch parameter is set.
# Default is `%n has %a %l from %m'.
# Recognizes the following escape sequences:
#   %n = name of the user that logged in/out.
#   %a = observed action, i.e. "logged on" or "logged off".
#   %l = line (tty) the user is logged in on.
#   %M = full hostname of the remote host.
#   %m = hostname up to the first `.'.
#   %t or %@ = time, in 12-hour, am/pm format.
#   %w = date in `day-dd' format.
#   %W = date in `mm/dd/yy' format.
#   %D = date in `yy-mm-dd' format.
# WATCHFMT='%n %a %l from %m at %t.'
# WATCHFMT='*knock* *knock* Follow the white rabbit => %n %a %l from %m at %t.'
# WATCHFTM=print '\e[1;35m%B[%b\e[1;32m%B%n%b\e[1;35m%B]%b \e[1;34m%U%a%u \e[1;35mfrom terminal \e[1;31m%M \e[1;35mat \e[1;33m%U%T%u\e[0m''
#WATCHFMT="[%B%t%b] %B%n%b has %a %B%l%b from %B%M%b"
#WATCHFMT='%n %a %l from %m at %t.'
LOGCHECK=600                    # check every 10 min for login/logout activity
WATCHFMT="%B->%b %n has just %a %(l:tty%l:%U-Ghost-%u)%(m: from %m:)"

# $LS_COLORS {{{
# $ cd /usr/ports/misc/fileutils
# $ make install clean
#  di = directory
#  fi = file
#  ln = symbolic link
#  pi = fifo file
#  so = socket file
#  bd = block (buffered) special file (block device)
#  cd = character (unbuffered) special file (character device)
#  or = symbolic link pointing to a non-existent file (orphan)
#  mi = non-existent file pointed to by a symbolic link (visible when you type ls -l)
#  ex = file which is executable (ie. has 'x' set in permissions (executable)).
#
# 0   = default colour
# 1   = bold
# 4   = underlined
# 5   = flashing text
# 7   = reverse field
# 31  = red
# 32  = green
# 33  = orange
# 34  = blue
# 35  = purple
# 36  = cyan
# 37  = grey
# 40  = black background
# 41  = red background
# 42  = green background
# 43  = orange background
# 44  = blue background
# 45  = purple background
# 46  = cyan background
# 47  = grey background
# 90  = dark grey
# 91  = light red
# 92  = light green
# 93  = yellow
# 94  = light blue
# 95  = light purple
# 96  = turquoise
# 100 = dark grey background
# 101 = light red background
# 102 = light green background
# 103 = yellow background
# 104 = light blue background
# 105 = light purple background
# 106 = turquoise background
export LS_COLORS='*.swp=00;44;37:*,v=5;34;93:*.vim=35:no=0:fi=0:di=94:ln=36:or=1;40:mi=1;40:pi=31:so=33:bd=44;37:cd=44;37:ex=35:*.jpg=1;32:*.jpeg=1;32:*.JPG=1;32:*.gif=1;32:*.png=1;32:*.jpeg=1;32:*.ppm=1;32:*.pgm=1;32:*.pbm=1;32:*.c=1;32:*.C=1;33:*.h=1;33:*.cc=1;33:*.awk=1;33:*.pl=1;33:*.gz=31:*.tar=31:*.zip=31:*.lha=1;31:*.lzh=1;31:*.arj=1;31:*.bz2=31:*.tgz=31:*.taz=1;31:*.html=36:*.htm=1;34:*.doc=1;34:*.txt=1;34:*.o=1;36:*.a=1;36'
# }}}

## alias
alias mvr='nocorrect mv -R'
alias cp='nocorrect cp -R'
alias rm='nocorrect rm -i'
alias rmf='nocorrect rm -f'
alias rmrf='nocorrect rm -fR'
alias mkdir='nocorrect mkdir'

##xterm
alias xterm='xterm -bg black -fg white'



#Oracle
alias sqlplus='rlwrap sqlplus64'

##
alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias zshrc='$EDITOR ~/.zshrc' # Quick access to the ~/.zshrc file
alias vi=vim

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

##
alias utar="tar -xvzf"
alias df='df -m'
alias less='less -M'
alias ispell='ispell -d russian'
alias x='exit'
#alias .='pwd'
alias dud='du -d 1 -h'
alias ducur='du --max-depth=1 | sort -nr | cut -f2- | xargs -I {} du -hs {}'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# ls, the common ones I use a lot shortened for rapid fire usage
alias ls='ls --color'
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -la'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias li='ls -ial'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'

## User Alias
alias crontabedit='EDITOR=/usr/bin/mcedit crontab -e'
alias crontablist='crontab -l | more'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"
alias -g CC="2>&1 | ccze --mode ansi"

alias -g rdp='rdesktop -g 1240x960 '
alias myWatch='_() { while :; do clear; $2; sleep $1; done }; _'

#
alias t='tail -f'
alias log_apache='multitail -cS apache /var/log/httpd/access_log -i /var/log/httpd/error_log'
alias log_nginx='tail -f /var/log/nginx/access.log | ccze --mode ansi'
alias log_nginx_uniq_ip='cat /var/log/nginx/access.log | cut -d " " -f1 | sort | uniq -c | sort -n | tail -n 30 | sort -nrk 1'
alias log_nginx_uniq_ip_tail_10k='tail -10000 /var/log/nginx/access.log | cut -d " " -f1 | sort | uniq -c | sort -n | tail -n 30 | sort -nrk 1 | awk '\''{print "echo -n " $1 "; echo -n \"\t\"; echo -n " $2 "; echo -n \"\t\"; host " $2}'\'' | sh'
alias log_nginx_long_running_query='cat /var/log/nginx/access.log| grep -v " -]" | cut -d " " -f 1,2,8,10 | sed -e "s/\]//"| sort -nr -k3,3 | head -n 70'
alias log_mail='tail -f /var/log/maillog | ccze --mode ansi'
alias log_sys='tail -f /var/log/messages | ccze --mode ansi'

#Fail2ban
alias f2b_unbanip='fail2ban-client set sshd unbanip'
alias f2b_status='fail2ban-client status sshd'

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# MAN PATH
manpath="/usr/man:/usr/share/man:/usr/local/man:/usr/X11R6/man:/opt/qt/doc:/compat/linux/usr/share/man"
export MANPATH

##
hosts=('root@192.168.1.5')
compctl -k hosts ssh sftp

##############################
# ##### PROMPT SECTION ##### #
##############################
# Shell functions
setenv() { export $1=$2 }  # csh compatibility

# Color definitions
RED="%{\e[1;31m%}"
GREEN="%{\e[1;32m%}"
YELLOW="%{\e[1;33m%}"
BLUE="%{\e[1;34m%}"
PINK="%{\e[1;35m%}"
CYAN="%{\e[1;36m%}"
WHITE="%{\e[1;37m%}"

# Set prompts
PS1=$'%{\e[1;32m%}%n@%{\e[1;31m%}%m%{\e[1;33m%}:%{\e[1;37m%}%c %{\e[1;32m%}%#>%{\e[0m%} '
RPS1=$' %{\e[1;33m%}%* %D{%a %d/%m} %{\e[1;32m%}%y%b'

# prompt for right side of screen
#RPS1=$'%{\e[1;31m%} <%B%h%b%{\e[1;31m%}>%{\e[0m%}'
#RPS1=$'%{\e[1;31m%} <%D{%a %y/%m}>%{\e[0m%}'
#PROMPT='[%n@%m]$ '
#RPROMPT=' %~'
## root
#PROMPT='%m:%c %#> '
##
#PROMPT2='%i%U> '
## time ttys
#RPROMPT=' %T %y%b'

#########################
# ## History section ## #
#########################
HISTFILE=~/.zsh_history
HISTSIZE=65536
SAVEHIST=65536
DIRSTACKSIZE=10
setopt  APPEND_HISTORY
setopt  HIST_IGNORE_ALL_DUPS
setopt  HIST_IGNORE_SPACE
setopt  HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

#########################
# ### Shell options ### #
#########################
TIMEFMT=$'real\t%*Es\nuser\t%*Us\nsys \t%*Ss\ncpu \t%P'
setopt 	ignoreeof
setopt 	interactivecomments
setopt 	nobanghist
setopt 	noclobber

setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd cdablevars recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus pushdsilent pushdtohome extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

## Error Beep 
setopt  nobeep

##  Control+C
setopt  IGNORE_EOF

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

##
bindkey -v    # vi
bindkey -e      # emacs

bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

## cd d/e  docs/editors
autoload -U compinit
compinit
# cd && ls
function cl() { cd $1 && ls -a }

########################
## Completion Styles  ##
########################
# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)
# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
# add colors to completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
