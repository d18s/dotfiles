# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
# ~/.bash_logout: executed by bash(1) when login shell exits.

# save current package list if needed
# cd ~/ && savepackages && git add .packages && git commit -m "saving package list" .packages
# push home repo
cd ~/ && git push
