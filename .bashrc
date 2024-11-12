# .bashrc

# User specific aliases and functions

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#Set my prompt
PS1='[\h] ${PWD} > '

# Read in my aliases as set in the file .aliases in my home directory
source ~/.aliases

# Home brew
eval "$(/opt/homebrew/bin/brew shellenv)"



# was
#export ROOTSYS=$HOME/root

# now:
#. $(brew --prefix root)/libexec/thisroot.sh
#source /Users/johnda/rootNew/temp/ROOT/bin/thisroot.sh
#source /Applications/root_v5.34.30/bin/thisroot.sh 



#export ROOTSYS=/home/johnda/root_v5.25.04/root
#export CMBEASYDIR=/scratch/CosmoProject/CMBEasy/cmbeasy
#export GSLCMBDIR=/gsl/gsl-1.10
#export LD_LIBRARY_PATH=$ROOTSYS/lib:/usr/local/lib:
#export PYTHONDIR=/home/johnda/Python-2.4.4
#export PYTHONPATH=$ROOTSYS/lib:$ROOTSYS/bin:$HOME/AtlasDocumentation/diveintopython-5.4/py:$HOME/pyroot:$HOME:$HOME/PyHelpers:/Users/johnda/ROOTHelpers:/Users/johnda/ROOTHelpers/iStack/models:/Users/johnda/ROOTHelpers/iStack
#export PYTHONPATH=/Users/johnda/Library/Python/3.6/lib/python/site-packages:$ROOTSYS/lib:$ROOTSYS/bin:$HOME/pyroot:$HOME:$HOME/PyHelpers:/Users/johnda/ROOTHelpers:/Users/johnda/ROOTHelpers/iStack/models:/Users/johnda/ROOTHelpers/iStack
#export PYTHONPATH=$ROOTSYS/lib:$ROOTSYS/bin:$HOME/pyroot:$HOME:$HOME/PyHelpers
#export PYTHONPATH=$ROOTSYS/lib:$ROOTSYS/bin:$HOME:/Users/johnda/ROOTHelpers/iStack:/Users/johnda/ROOTHelpers/iStack/models:/Users/johnda/ROOTHelpers:/Users/johnda/PyHelpers/
export PYTHONPATH=$ROOTSYS/lib:$ROOTSYS/bin:/Users/johnda/ROOTHelpers:/Users/johnda/PyHelpers/


#export PYTHONPATH27=/usr/local/Cellar/root/5.34.36_2/lib/root:/Users/johnda/Library/Python/2.7/lib/python/site-packages:$ROOTSYS/lib:$ROOTSYS/bin:$HOME/pyroot:$HOME:$HOME/PyHelpers:/Users/johnda/ROOTHelpers:/Users/johnda/ROOTHelpers/iStack/models:/Users/johnda/ROOTHelpers/iStack

#:/usr/local/lib/python2.7/site-packages
export PYTHONSTARTUP=$HOME/.pythonrc.py
#AFS=/afs/cern.ch/user/j/johnda
#afs=/afs/cern.ch/user/j/johnda/public
#Sets the correct latex path
#export afs=/afs/cern.ch/user/j/johnda/
#export TEXINPUTS=./:/usr/local/texlive/2013/texmf-dist/tex//:/Users/johnda/papers/latexBaseFiles
#export TEXINPUTS=./:/usr/local/texlive/2018/texmf-dist/tex//:/Users/johnda/papers/latexBaseFiles
#export TEXINPUTS=./:/usr/local/texlive/2024basic/texmf-dist/tex//:/Users/johnda/papers/latexBaseFiles:/opt/homebrew/Cellar/texlive/20240312_3/bin/tex
#export TEXINPUTS=./:/usr/local/texlive/2024/texmf-dist/tex/:/Users/johnda/papers/latexBaseFiles:/opt/homebrew/Cellar/texlive/20240312_3/bin/tex
## export TEXINPUTS=./:/usr/local/texlive/2024/texmf-dist/tex//:/Users/johnda/papers/latexBaseFiles:/opt/homebrew/Cellar/texlive/20240312_3/bin/tex/:/opt/homebrew/bin/pdflatex/:/usr/local/texlive/2024/texmf-dist/tex/latex//
export TEXINPUTS=./:/usr/local/texlive/2024/texmf-dist/tex//:/Users/johnda/papers/latexBaseFiles

export PATH=$PATH:/Users/johnda/Library/Python/3.6/bin:/sbin:$ROOTSYS/bin:$HOME/AtlasWork/iStack:/usr/local/bin:/opt/X11/bin:/usr/local/root/bin:/usr/local/texbin:
export PATH=$PATH:~/AWK/plotting/
#export PATH=/usr/local/bin:$PATH:/sbin:$ROOTSYS/bin:$HOME/AtlasWork/iStack:/opt/X11/bin:/usr/local/root/bin
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH

export PENNSVN=svn+ssh://svn.cern.ch/reps/penn
export UCSVN=svn+ssh://svn.cern.ch/reps/atlasinst/Institutes/UChicago/johnda
export UCT3=uct3.uchicago.edu
export lxplusPage=lxplus.cern.ch:/eos/user/j/johnda/www/
export protonpack=protonpack.hep.upenn.edu

#export LPC=jda102@cmslpc-sl6.fnal.gov
#export LPC=jda102@cmslpc-sl7.fnal.gov
export LPC=jda102@cmslpc-el9.fnal.gov
export AUTON='-i ~/.ssh/autoncluster jalison@lop2.autonlab.org'

export LXP=johnda@lxplus.cern.ch
export CERNBOX=lxplus.cern.ch:/eos/user/j/johnda/public/
#echo bashrc has run;

#for the MAc
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export ForbiddenFruitPro=/Volumes/LaCie/Backups.backupdb/ForbiddenFruitPro/Latest/Macintosh*HD/Users/johnda/


#source /sw/bin/init.sh

# Switching over to 64-bit athena builds (or 32-bit, if requested)
#function setupPyROOT() {
#    export PYTHONPATH=$PYTHONPATH27
#}


# Source global definitions

# Set-up git tab complete
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}


#if [ -f ~/.git-completion.bash ]; then
#  . ~/.git-completion.bash
#fi


#. $(brew --prefix root)/bin/thisroot.sh

