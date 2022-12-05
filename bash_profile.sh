# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

export ORACLE_BASE=/oracle/app/oracle

export ORACLE_HOME=$ORACLE_BASE/product/19.3/db
export GRID_HOME=$ORACLE_BASE/oroduct/19.3/grid
export TNS_ADMIN=$ORACLE_HOME/network/admin

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH

export PATH=$ORACLE_HOME/bin:$GRID_HOME/bin:$PATH:$HOME/bin

export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export DISPLAY=localhost:10.0
export ORACLE_SID=OSID

export PS1='[\u@\h:`pwd`]#'

alias sqlplus='rlwrap sqlplus'
alias rman='rlwrap rman'
alias ggsci='rlwrap ggsci'
