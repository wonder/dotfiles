# Check for an interactive session
[ -z "$PS1" ] && return

PS1='\[\033[0;32m\]┌─[ \[\033[0m\033[0;32m\]\u\[\033[0m\] @ \[\033[0;36m\]\h\[\033[0m\033[0;32m\] ] - [ \[\033[0m\]\w\[\033[0;32m\] ]\n\[\033[0;32m\]└─[\[\033[0m\033[0;32m\]\$\[\033[0m\033[0;32m\]]>\[\033[0m\] '

export SVN_EDITOR=vim
export OOO_FORCE_DESKTOP=gnome

shopt -s checkwinsize

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias rm='rm -i'
alias tree='tree -Chs'
alias grep='grep -n --color=auto'

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
    cat "$(pwd)/namcap.log"
    echo "****End namcap log****"
}
build_t(){
    sudo makechrootpkg -cr /builds/arch64-testing
    echo "****Starting namcap log****"
    cat "$(pwd)/namcap.log"
    echo "****End namcap log****"
}

build32_t(){
    sudo linux32 makechrootpkg -cr /builds/arch32-testing
    echo "****Starting namcap log****"
    cat "$(pwd)/namcap.log"
    echo "****End namcap log****"
}

build32(){
    sudo linux32 makechrootpkg -cr /builds/arch32
    echo "****Starting namcap log****"
    cat "$(pwd)/namcap.log"
    echo "****End namcap log****"
}
update_chroots(){
    chroots="arch32 arch64 arch32-testing arch64-testing"
    for i in $chroots; do
	echo "**************Updating $i*************"
	sudo mkarchroot -u /builds/$i/root
    done
}
