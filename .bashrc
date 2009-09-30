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
have tree && alias tree='tree -Chs'

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# search packages with pacman and display colors
pacsearch(){
	echo -e "$(pacman -Ss $@ | sed \
	-e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
	-e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
	-e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
	-e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}
#aur
aurget(){
	pkg=$@
	wget http://aur.archlinux.org/packages/$pkg/$pkg.tar.gz && tar -xvf $pkg.tar.gz && cd $pkg
}
#build in chroot
build(){
    sudo makechrootpkg -cr ~/arch/arch64
    echo "****Starting namcap log****"
    cat ~/arch/arch64/rw/pkgdest/namcap.log
    echo "****End namcap log****"
}
build32(){
    sudo linux32 makechrootpkg -cr ~/arch/arch32
    echo "****Starting namcap log****"
    cat ~/arch/arch32/rw/pkgdest/namcap.log
    echo "****End namcap log****"
}
update_chroots(){
    chroots="arch32 arch64 arch32-testing arch64-testing"
    for i in $chroots; do
	echo "**************Updating $i*************"
	sudo mkarchroot -u ~/arch/$i/root
    done
}
