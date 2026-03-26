#! /bin/sh

sudo launchctl unload /Library/LaunchDaemons/com.textd.Stats.SMC.Helper.plist
sudo rm /Library/LaunchDaemons/com.textd.Stats.SMC.Helper.plist
sudo rm /Library/PrivilegedHelperTools/com.textd.Stats.SMC.Helper
sudo rm $HOME/Library/Application Support/Stats
