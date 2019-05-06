dbow's VIM setup

### To use

* git clone to .vim/
* Install dependencies below
* `:PlugInstall` inside vim/nvim

### Plugins

This uses [vim-plug](https://github.com/junegunn/vim-plug/) to manage vim plugins.

To add/update/remove a plugin, follow instructions in the [tutorial](https://github.com/junegunn/vim-plug/wiki/tutorial)

### Dependencies

* [Silver Searcher (Ag)](https://github.com/ggreer/the_silver_searcher)
* [fzf](https://github.com/junegunn/fzf)

### Colors

Currently [Base2Tone Pool](http://base2t.one/demo/pool/) (Space and Evening aren't bad either...)

Other options:

* Great way to find schemes: [http://vimcolors.com/](http://vimcolors.com/)
* Good variations: [https://nightsense.github.io/vimspectr/](https://nightsense.github.io/vimspectr/)
* Oceanic Next (classic option): [https://github.com/mhartington/oceanic-next](https://github.com/mhartington/oceanic-next)
* Gruvbox (also classic): [https://github.com/morhetz/gruvbox](https://github.com/morhetz/gruvbox)


### Other dev environment stuff

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

#### TODOs

* Auto-completion
    * maybe [vim-flow](https://github.com/flowtype/vim-flow) for a targeted thing
    * or [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) for a really over-the-top option...
    * or something more targeted to JS with [tern for vim](https://github.com/ternjs/tern_for_vim)
* Difftool
    * eventually would like to try using something built-in, like gitdiff?
    * find a good colorscheme for diffs... maybe [github's](https://github.com/endel/vim-github-colorscheme)?
