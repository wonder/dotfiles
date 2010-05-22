# Check for an interactive session
[ -z "$PS1" ] && return

if [ "$UID" -eq 0 ]; then
    PS1='\[\033[0;31m\]┌─[ \[\033[0m\033[0;31m\]\u\[\033[0m\] @ \[\033[0;36m\]\h\[\033[0m\033[0;31m\] ] - [ \[\033[0m\]\w\[\033[0;31m\] ]\n\[\033[0;31m\]└─[\[\033[0m\033[0;31m\]\$\[\033[0m\033[0;31m\]]>\[\033[0m\] '
else
    PS1='\[\033[0;32m\]┌─[ \[\033[0m\033[0;32m\]\u\[\033[0m\] @ \[\033[0;36m\]\h\[\033[0m\033[0;32m\] ] - [ \[\033[0m\]\w\[\033[0;32m\] ]\n\[\033[0;32m\]└─[\[\033[0m\033[0;32m\]\$\[\033[0m\033[0;32m\]]>\[\033[0m\] '
fi

export SVN_EDITOR=vim
export OOO_FORCE_DESKTOP=gnome


shopt -s checkwinsize

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias rm='rm -i'
alias tree='tree -Chs'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
checkout(){
	svn checkout -N "svn+ssh://$1.archlinux.org/srv/svn-packages"
}

#aur
aurget(){
	pkg=$@
	wget http://aur.archlinux.org/packages/$pkg/$pkg.tar.gz && tar -xvf $pkg.tar.gz && cd $pkg
}
#build in chroot
build(){
    sudo makechrootpkg -cr /builds/arch64
    echo "****Starting namcap log****"
    cat "namcap.log"
    echo "****End namcap log****"
}
build_t(){
    sudo makechrootpkg -cr /builds/arch64-testing
    echo "****Starting namcap log****"
    cat "namcap.log"
    echo "****End namcap log****"
}

build32_t(){
    sudo linux32 makechrootpkg -cr /builds/arch32-testing
    echo "****Starting namcap log****"
    cat "namcap.log"
    echo "****End namcap log****"
}

build32(){
    sudo linux32 makechrootpkg -cr /builds/arch32
    echo "****Starting namcap log****"
    cat "namcap.log"
    echo "****End namcap log****"
}
update_chroots(){
    chroots="arch32 arch64 arch32-testing arch64-testing"
    for i in $chroots; do
	echo "**************Updating $i*************"
	sudo mkarchroot -u /builds/$i/root
    done
}

scan () {
    pacman -Qlq $1 | xargs file | grep ELF | awk -F: '{print $1}' |
    	while read elfobj;
	    do readelf -d $elfobj | grep NEEDED | sed 's/\[//;s/\]//' | nl |
		while read c1 c2 c3 c4 c5 c6; do echo $elfobj -- $c6;
		done;
	    done

}
