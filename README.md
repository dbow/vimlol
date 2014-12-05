dbow's VIM setup

To use:
git clone to .vim/
git submodule init
git submodule update

Anytime you pull in changes to one of the submodules, run submodule update
Pathogen is submoduled into vim-pathogen and the autoload directory symlinks to it.

Dependencies:
Silver Searcher (Ag): https://github.com/ggreer/the_silver_searcher


Other dev environment stuff
---------------------------

.bashrc
```
# Git
source ~/.git-prompt.sh
source ~/.git-completion.sh

# Command prompt with git info.
PS1='\[\033[4;30m\]localhost:\w\[\033[0;34m\]\n$(__git_ps1 "(%s)")\$\[\033[0m\] '

# Node
source ~/.nvm/nvm.sh
```

.gitconfig (uses p4merge as difftool)
```
[diff]
	tool = p4mergetool
[difftool "p4mergetool"]
	cmd = /Applications/p4merge.app/Contents/Resources/launchp4merge $LOCAL $REMOTE
[difftool]
	prompt = false
[alias]
	dt = difftool
```

