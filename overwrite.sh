echo "Overwriting dotfiles..."
for x in bashrc screenrc vimrc zshrc; do
  f=$(readlink -f $x)
  ln -sf $f $HOME/.$x
done
