echo "alias spr='cd ~/Work/shippr'
alias cap='cd ~/Work/shippr/projects/carrier-app'" >> ~/.bash_aliases

if [ -f ~/.zshrc ]; then
echo "if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi" >> ~/.zshrc
fi
