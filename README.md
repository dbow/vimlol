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

* Plugin manager
    * Updates via pathogen are clunky. Should try
        * [minpac](https://github.com/k-takata/minpac) - minimal, uses native vim8 packages
        * [dein](https://github.com/Shougo/dein.vim) - successor to NeoBundle
        * [vim-plug](https://github.com/junegunn/vim-plug) - also pretty minimal, and widely supported
        * [vundle](https://github.com/VundleVim/Vundle.vim) - most widely used?
* Syntax
    * I like [yajs](https://github.com/othree/yajs.vim) (and especially its [es-next syntax](https://github.com/othree/es.next.syntax.vim)) for syntax but could not get [styled-components](https://github.com/styled-components/vim-styled-components) to highlight correctly with it.
* Auto-completion
    * maybe [vim-flow](https://github.com/flowtype/vim-flow) for a targeted thing
    * or [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) for a really over-the-top option...
    * or something more targeted to JS with [tern for vim](https://github.com/ternjs/tern_for_vim)
* Difftool
    * eventually would like to try using something built-in, like gitdiff?
    * find a good colorscheme for diffs... maybe [github's](https://github.com/endel/vim-github-colorscheme)?
