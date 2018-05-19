dbow's VIM setup

### To use

* git clone to .vim/
* `git submodule init`
* `git submodule update`

### Submodules

Anytime you pull in changes to one of the submodules, run `git submodule update`

To add a new submodule, run `git submodule add [the git URL] bundle/[directory]` and commit the result.

To remove a submodule, run `git submodule deinit bundle/[directory]` and then `git rm bundle/[directory]` and commit the result.

Pathogen is submoduled into vim-pathogen and the autoload directory symlinks to it.

### Dependencies

* Silver Searcher (Ag): https://github.com/ggreer/the_silver_searcher
* fzf: https://github.com/junegunn/fzf

### Colors

Currently [Base2Tone Pool](http://base2t.one/demo/pool/) (Space and Evening aren't bad either...)

Other options:

* Great way to find schemes: [http://vimcolors.com/](http://vimcolors.com/)
* Good variations: [https://nightsense.github.io/vimspectr/](https://nightsense.github.io/vimspectr/)
* Oceanic Next (classic option): [https://github.com/mhartington/oceanic-next](https://github.com/mhartington/oceanic-next)
* Gruvbox (also classic): [https://github.com/morhetz/gruvbox](https://github.com/morhetz/gruvbox)

Other dev environment stuff
---------------------------

.bashrc
```
# Git
source ~/.git-prompt.sh
source ~/.git-completion.sh

# Command prompt with git info.
PS1='\[\033[1;34m\]localhost:\w\[\033[0;34m\]\n$(__git_ps1 "(%s)")\$\[\033[0m\] '

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

