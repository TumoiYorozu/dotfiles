sps() {
   pwd | sed "s@^${HOME}@~@" | sed -r 's@([^/][^/])[^/][^/]+/@\1*/@g'
}

PS1="\`if [ \$? = 0 ];
then echo -n \[\e[1m\]\[\e[33m\]\u\[\e[22m\]\[\e[2m\]@\h:\[\e[22m\]\[\e[4m\];
else echo -n \[\e[1m\]\[\e[31m\]\u\[\e[22m\]\[\e[2m\]@\h:\[\e[22m\]\[\e[4m\];
fi; eval sps | rev |sed \"s@/@/|@\" | rev | sed \"s@|/@\[\e[24m\]/\[\e[1m\]@\";\`\[\e[0m\]$ "

_termtitle="[\`pwd|sed \"s@^${HOME}@~@\"|rev|cut -d'/' -f1-2|rev\`] \h"

PS1="${PS1}\[\e]0;${_termtitle}\007\]"

