#!/usr/bin/env nu
sudo nixos-rebuild switch --flake ~/mySystem#default
print "\n\nRebuild finished"
