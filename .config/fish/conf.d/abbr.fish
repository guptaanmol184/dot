abbr 000 'chmod -R 000'
abbr 644 'chmod -R 644'
abbr 666 'chmod -R 666'
abbr 755 'chmod -R 755'
abbr 777 'chmod -R 777'
abbr alert 'notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
abbr apt-get 'sudo apt-get'
abbr cat 'bat'
abbr cc 'gcc -Wall'
abbr ..... 'cd ../../../..'
abbr .... 'cd ../../..'
abbr ... 'cd ../..'
abbr .. 'cd ..'
abbr cd.. 'cd ..'
abbr checkcommand "type -t"
abbr cls 'clear'
abbr cn 'sudo -A connman_dmenu'
abbr countfiles "for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"
abbr cp 'cp -i'
abbr cpu "grep 'cpu ' /proc/stat | awk '{usage=(\$2+\$4)*100/(\$2+\$4+\$5)} END {print usage}' | awk '{printf(\"%.1f\n\", \$1)}'"
abbr da 'date "+%Y-%m-%d %A %T %Z"'
abbr diskspace "du -S | sort -n -r |more"
abbr dota 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME add -p'
abbr dotc 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME commit -m'
abbr dotd 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME diff'
abbr dot 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
abbr dotp 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME push origin'
abbr dots 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME status'
abbr e "$EDITOR"
abbr f "find . | grep "
abbr folders 'du -h --max-depth=1'
abbr folderssort 'find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
abbr freshclam 'sudo freshclam'
abbr gdota 'sudo git --git-dir=/.dot/ --work-tree=/ add'
abbr gdotc 'sudo git --git-dir=/.dot/ --work-tree=/ commit -m'
abbr gdotp 'sudo git --git-dir=/.dot/ --work-tree=/ push origin'
abbr gdots 'sudo git --git-dir=/.dot/ --work-tree=/ status'
abbr gdot 'sudo git --git-dir=/.dot/ --work-tree=/'
abbr g 'git'
abbr g 'git'
abbr h "history | grep "
abbr hlp 'less ~/.bashrc_help'
abbr home 'cd ~'
abbr ipview "netstat -anpl | grep :80 | awk {'print \$5'} | cut -d\":\" -f1 | sort | uniq -c | sort -n | sed -e 's/^ *//' -e 's/ *\$//'"
abbr labc 'ls -lap' #alphabetical sort
abbr la 'ls -Alh' # show hidden files
abbr lc 'ls -lcrh' # sort by change time
abbr ldir "ls -l | egrep '^d'" # directories only
abbr less 'less -R'
abbr lf "ls -l | egrep -v '^d'" # files only
abbr lk 'ls -lSrh' # sort by size
abbr ll 'ls -Fls' # long listing format
abbr lm 'ls -alh |more' # pipe through 'more'
abbr lr 'ls -lRh' # recursive ls
abbr ls 'ls --color=auto' # add colors and file type extensions
abbr lt 'ls -ltrh' # sort by date
abbr lu 'ls -lurh' # sort by access time
abbr lw 'ls -xAh' # wide listing format
abbr lx 'ls -lXBh' # sort by extension
abbr mkbz2 'tar -cvjf'
abbr mkdir 'mkdir -p'
abbr mkgz 'tar -cvzf'
abbr mktar 'tar -cvf'
abbr m 'ncmpcpp'
abbr mountedinfo 'df -hT'
abbr multitail 'multitail --no-repeat -c'
abbr mv 'mv -i'
abbr mx 'chmod a+x'
abbr openports 'netstat -nape --inet'
abbr pd 'cd "$OLDPWD"'
abbr pg "ps aux | grep "
abbr ping 'ping -c 10'
abbr pi 'pacman -Qi'
abbr pl 'pacman -Ql'
abbr po 'pacman -Qo'
abbr p 'pacman'
abbr ps 'ps auxf'
abbr psyu 'sudo pacman -Syu'
abbr q 'exit'
abbr rebootforce 'sudo shutdown -r -n now'
abbr rebootsafe 'sudo shutdown -r now'
abbr rfs '~/frozensynapse/runSynapse.sh'
abbr rmd '/bin/rm  --recursive --force --verbose '
abbr rm 'rm -iv'
abbr sbrc 'source ~/.bashrc'
abbr se "sudo $EDITOR"
abbr sha1 'openssl sha1'
abbr sp 'sudo pacman'
abbr svi 'sudo vi'
abbr topcpu "/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
abbr treed 'tree -CAFd'
abbr tree 'tree -CAhF --dirsfirst'
abbr unbz2 'tar -xvjf'
abbr ungz 'tar -xvzf'
abbr untar 'tar -xvf'
abbr vim 'nvim'
abbr vis 'vim "+set si"'
abbr vi 'vim'
abbr web 'cd /var/www/html'
abbr whatismyip "whatsmyip"
abbr wm 'sudo wifi-menu'
abbr yta "youtube-dl --extract-audio --audio-format mp3 --output '%(title)s.%(ext)s'" # Download only audio
abbr ytp "youtube-dl -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'" # Download playlist with numbering
abbr yt "youtube-dl --add-metadata -ic" # Download video link
abbr za 'zathura --fork'
