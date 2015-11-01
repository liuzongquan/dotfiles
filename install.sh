#!/bin/bash

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

source install/link.sh

if [ "$(uname)" == "Darwin" ]; then
    echo "Running on OSX"

    echo "Brewing all the things"
    source install/brew.sh

    echo "Updating OSX settings"
    source installosx.sh

    echo "Installing node (from nvm)"
    source install/nvm.sh

    echo "Configuring nginx"
    # create a backup of the original nginx.conf
    mv /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.original
    ln -s ~/.dotfiles/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf
    # symlink the code.dev from dotfiles
    ln -s ~/.dotfiles/nginx/sites-enabled/code.dev /usr/local/etc/nginx/sites-enabled/code.dev
fi

echo "creating vim directories"
mkdir -p ~/.vim-tmp


echo "Configuring zsh as default shell"
# if /usr/local/bin/zsh not in /etc/shells, then u will get 'non-standard shell' error.
# so uncomment follow line manually, and add it.
# which zsh | sudo tee -a /etc/shells
chsh -s $(which zsh)

echo "Done."
