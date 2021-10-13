
echo "Overwriting dotfiles..."
for x in bashrc screenrc vimrc zshrc; do
  f=$x
  if [[ "$OSTYPE" == "darwin"* ]]; then
    f=$PWD/$f
  else
    f=$(readlink -f $f)
  fi
  echo ln -sf $f $HOME/.$x
  ln -sf $f $HOME/.$x
done
