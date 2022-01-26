set fish_greeting

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x LANGUAGE en_US.UTF-8

# use gpg-agent for ssh
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --create-socketdir
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null

ulimit -n 8096

function ls
  command /usr/bin/ls --color=auto $argv
end
function pip
  command /usr/bin/pip3 $argv
end
function dotfiles
  command /usr/bin/git --git-dir $HOME/.dotfiles/ --work-tree $HOME $argv
end
function pkgs
  command /usr/bin/apt search --names-only $argv
end

# misc dev   commandes
function rebase
  command interactive-rebase-tool $argv
end
#  command rust-musl-builder docker run --rm -it -v $(pwd) /home/rust/src ekidd/rust-musl-builder
function cargogen
  command cargo generate --git 'https://github.com/gbmor/cargo-template' --name $argv
end
function python
  command python3 $argv
end

# some   commandes for cd use
function dev_cd
  if [ "$argv[2]" = "" ]
    cd "$argv[1]"
  else
    cd "$argv[1]/$argv[2]"
  end
end
function devgb
  dev_cd ~/dev/git.gbmor.org
end
function devg
  dev_cd ~/dev/github "$argv"
end
function devgg
  dev_cd ~/dev/github/gbmor "$argv"
end
function devggf
  dev_cd ~/dev/github/gbmor-forks "$argv"
end
function devgi
  dev_cd ~/dev/github/tildeinstitute "$argv"
end
function devs
  dev_cd ~/dev/srht "$argv"
end
function devsg
  dev_cd ~/dev/srht/gbmor/ "$argv"
end
function devt
  dev_cd ~/dev/tmp "$argv"
end
function devtilde
  dev_cd ~/dev/tildegit "$argv"
end

# misc environment modifications
set -x VISUAL vim
set -x EDITOR $VISUAL
#set -x PAGER "$HOME/.cargo/bin/bat -p"
set -x BROWSER firefox
set -x TERM xterm-256color
set -x MANPATH /usr/local/man $MANPATH
set -x MANPATH /usr/share/man $MANPATH
set -x PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig /usr/local/lib/x86_64-linux-gnu/pkgconfig /usr/share/pkgconfig
set -x DENO_INSTALL $HOME/.deno

set -x GDK_BACKEND x11
set -x RANGER_LOAD_DEFAULT_RC false

# path modifications
set -x PATH $HOME/.emacs.d/bin $PATH
set -x PATH /snap/bin $PATH
set -x PATH $HOME/dev/go/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/bin $PATH
set -x PATH $HOME/.ghcup/bin $PATH
set -x PATH /snap/bin $PATH
set -x PATH $HOME/.local/share/gem/ruby/2.7.0/bin $PATH
set -x PATH $DENO_INSTALL/bin $PATH
set -x PATH $HOME/.pyenv/bin $PATH
set -x PATH $HOME/.poetry/bin $PATH

# hub, the github cli tool
set -x HUB_CONFIG $HOME/.config/hub
set -x HUB_PROTOCOL ssh

# pyenv
#status is-login; and pyenv init --path | source
#status is-interactive; and pyenv init - | source

# rust env
#set -x RUST_SRC_PATH ~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library

# go env
set -x GOPATH $HOME/dev/go
set -x GTAGSLABEL ctags
set -x GO111MODULE on
set -x GOMAXPROCS 4
function godoc
  command godoc -v -index -http  6060
end

# clojure
set -x BOOT_CLOJURE_NAME org.clojure/clojure
set -x BOOT_VERSION 2.8.3
set -x BOOT_CLOJURE_VERSION 1.8.0

# ocaml
source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# when calling vim, don't load spacevim. for neovim, load it.
function vim
  command vim -u NONE $argv
end

# nix package manager configuration
set -x NIX_LINK $HOME/.nix-profile
set -x NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"
set -x NIX_SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
set -x MANPATH $NIX_LINK/share/man $MANPATH
set -x PATH $NIX_LINK/bin $PATH
set -x LOCALE_ARCHIVE $HOME/.nix-profile/lib/locale/locale-archive
set -x NIXPKGS_ALLOW_UNFREE 1
set -e NIX_LINK

