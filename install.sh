#!/usr/bin/env bash

dotdir=$HOME/dotfiles

# This is what you are.
uname=$(uname -a)
if [[ $uname =~ "Darwin" ]]; then
  os="mac"
elif [[ $uname =~ "[Mm]icrosoft" ]]; then
  os="wsl"
else
  os="linux"
fi

# Install packages.
if [[ $os == "mac" ]]; then
  installer="brew install"
  packages="packages-brew"
else
  installer="sudo apt install"
  packages="packages-ubuntu"
fi

$installer $(<$dotdir/$packages)

# Build array of files to exclude from symlinking.
declare -A excludes
for file in $(<$dotdir/excludes)
do
  excludes[$file]="1"
done

# Symlink everything that's not excluded.
for file in $dotdir/*
do
  filename=${file#"${dotdir}/"}
  if [[ ${excludes[$filename]} ]]; then
    continue
  fi
  ln -s "$file" "$HOME/.$filename"
done

# Rewrite .bashrc with something that launches zsh
rm $HOME/.bashrc
cp $dotdir/bashrc $HOME/.bashrc

# Copy special files that shouldn't be linked.
cp_cmd='cp --no-clobber'

if [[ ! -a $HOME/.ssh ]]; then
  mkdir $HOME/.ssh
fi
$cp_cmd $dotdir/ssh/config $HOME/.ssh

$cp_cmd $dotdir/gitconfig $HOME/.gitconfig
sed -i "s|HOMEDIR|${HOME}|" $HOME/.gitconfig

$cp_cmd $dotdir/zlogin $HOME/.zlogin

# Grab all the submodules.
pushd $dotdir
git submodule init
git submodule update
popd

mkdir $HOME/.vim/cache
touch $HOME/.tmux.conf.local
touch $HOME/.zshenv-local
touch $HOME/.zshalias-local
