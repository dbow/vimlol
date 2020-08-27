dbow's dev/vim setup

### To use

* git clone to .vim/
* Install dependencies below
* `:PlugInstall` inside nvim

### Plugins

This uses [vim-plug](https://github.com/junegunn/vim-plug/) to manage vim plugins.

To add/update/remove a plugin, follow instructions in the [tutorial](https://github.com/junegunn/vim-plug/wiki/tutorial)

### Dependencies

(install w/ homebrew)
* [neovim](https://neovim.io/)
* [Silver Searcher (Ag)](https://github.com/ggreer/the_silver_searcher)
* [fzf](https://github.com/junegunn/fzf)

also install [nvm](https://github.com/nvm-sh/nvm) via the script

### Typography

* [space mono](https://fonts.google.com/specimen/Space+Mono)

### Tools

* [iTerm2](https://www.iterm2.com/)
  * git clone [color scheme](https://github.com/atelierbram/Base2Tone-iterm2) and then import color preset in preferences.
  * adjust typography in preferences
* [VimR](https://github.com/qvacua/vimr)
  * put `vimr` executable in /usr/local/bin/
  * adjust typography in preferences (prefs override vimrc)

### Colors

Currently [Base2Tone Pool](http://base2t.one/demo/pool/) (Space and Evening aren't bad either...)

Other options:

* Great way to find schemes: [http://vimcolors.com/](http://vimcolors.com/)
* Good variations: [https://nightsense.github.io/vimspectr/](https://nightsense.github.io/vimspectr/)
* Oceanic Next (classic option): [https://github.com/mhartington/oceanic-next](https://github.com/mhartington/oceanic-next)
* Gruvbox (also classic): [https://github.com/morhetz/gruvbox](https://github.com/morhetz/gruvbox)


### Other dev environment stuff

.zshrc
```
# Git
source ~/.git-prompt.sh
# https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh
fpath=(~/.zsh $fpath)

# Command prompt with git info i.e.
#   localhost:~/.vim
#   (master)$
setopt PROMPT_SUBST;
PS1='%F{blue}%Blocalhost:%~%b
$(__git_ps1 "(%s)")$ %f'

# Node/NVM
source ~/.nvm/nvm.sh
```

.gitconfig
* uses p4merge as difftool
* nvim as editor
```
[diff]
  tool = p4mergetool
[difftool "p4mergetool"]
  cmd = /Applications/p4merge.app/Contents/Resources/launchp4merge $LOCAL $REMOTE
[difftool]
  prompt = false
[alias]
  dt = difftool
[core]
  editor = /usr/local/bin/nvim
```

Also install [git-lfs](https://git-lfs.github.com/) (which will update .gitconfig)

#### TODOs

* Auto-completion - anything beyond ale?
* Go to definition?
* Difftool
    * eventually would like to try using something built-in, like gitdiff?
    * find a good colorscheme for diffs... maybe [github's](https://github.com/endel/vim-github-colorscheme)?
