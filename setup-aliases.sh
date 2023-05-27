echo "alias spr='cd ~/Developer/shippr'
alias cap='cd ~/Developer/shippr/projects/carrier-app'" >> ~/.bash_aliases

if [ -f ~/.zshrc ]; then
echo "if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi" >> ~/.zshrc
fi
