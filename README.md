INSTALLATIONS
============

## THE BASICS

* [Iterm2](https://www.iterm2.com/)
* XCode: AppStore
    * an integrated development environment (IDE) containing a suite of software development tools developed by Apple for developing software.
* [Brew](http://brew.sh/)
    * Homebrew installs the stuff you need that Apple didn’t.
    * Brew install these: brew install node git postgresql redis zsh rabbitmq
* [OSX GCC Installer](https://github.com/kennethreitz/osx-gcc-installer) (Bundler etc)
    * allows you to install the essential compilers from either pre-built binary packages or helps you create your own installer.
* Zsh: install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)
    * Replaces the default Bash shell with Zsh
    * Oh My Zsh is special configurations for Zsh
    * Place robbyrussel.zsh-themes into custom themes
* [ProfontX](http://faisal.com/software/profontx/)
    * A font that clearly distinguishes between O and 0, as well as i, l, and 1.


## GOLANG
##### Make sure to have git installed locally before downloading
##### If you are upgrading from an older version of Go you must first [remove the existing version](https://golang.org/doc/install#uninstall).

### Quick-Guide Checklist: 

* Download the most current version of the main Golang binaries
    * Download the latest go version [here](https://golang.org/dl/)
* [Set up go path](https://golang.org/doc/code.html#GOPATH)
    * example: 
    ```
    export GOPATH=$HOME/go-workspace
    export PATH=$PATH:$GOPATH/bin`
    ```
* [Test your installation](https://golang.org/doc/install/source#testing)
* Install additional go tools
    * `go get golang.org/x/tools/cmd/...`

For a full setup or custom installation, follow the guide [here](https://golang.org/doc/install).

## VIM
* Vim: (brew install luajit) brew install vim --with-luajit
* [vimplug](https://github.com/junegunn/vim-plug) - run :PlugInstall in vim to install all plugs
* [remap capslock to esc](http://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x)
* Exuberant CTAGS: brew install ctags

###Useful outside packages
ORM
* [Gorm](https://github.com/jinzhu/gorm)

Testing/Mocking Package
* [Assert](https://github.com/stretchr/testify)

Dependencies tool
* [Godep](https://github.com/tools/godep)

## RUBY 
* RVM (ruby version manager)
* rvm install (rubyversiongoeshere)
* gem install bundler
* gem install rails

## Leisure
* [thefuck](https://github.com/nvbn/thefuck)
    * App that corrects your previous console command
