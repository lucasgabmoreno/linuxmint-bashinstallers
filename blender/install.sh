#!/bin/bash

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
BLENDER="blender-3.0.0-linux-x64.tar.xz"
BLENDER_PATH=~/blender
sudo wget -t inf "https://download.blender.org/release/Blender3.0/$BLENDER"
sudo mkdir "$BLENDER_PATH"
sudo tar -Jxf "$BLENDER" --strip-components=1 -C "$BLENDER_PATH"
sudo rm -rf "$BLENDER"

# Create desktop launcher
DESK_PATH=$(xdg-user-dir DESKTOP)
USER_PATH=$(xdg-user-dir)
APP_PATH=~/.local/share/applications/blender.desktop
sudo sed -i "s|Exec=blender|Exec=$USER_PATH/blender/blender|g" "$BLENDER_PATH/blender.desktop"
sudo cp "$BLENDER_PATH/blender.desktop" ~/.local/share/applications/
sudo cp "$BLENDER_PATH/blender.svg" ~/.local/share/icons/
sudo chown $USER:$USER $APP_PATH
sudo chmod +x $APP_PATH
cp $APP_PATH "$DESK_PATH/"
sudo chmod +x "$DESK_PATH/"blender.desktop

# Remove this insaller
if [ ! -f .noremove ]; then rm -rf install.sh uninstall.sh; fi

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'Blender installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi
