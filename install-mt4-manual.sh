#!/bin/bash

# Script pour installation manuelle si le script officiel ne fonctionne pas

echo "Installation manuelle de Wine et MetaTrader 4..."

# Mise à jour du système
sudo apt update

# Installation de Wine
sudo apt install -y software-properties-common
sudo dpkg --add-architecture i386
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt update
sudo apt install -y winehq-stable

# Configuration de Wine
export WINEARCH=win32
export WINEPREFIX=~/.wine
winecfg

# Télécharger et installer MT4
cd /tmp
wget -O mt4setup.exe "https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4setup.exe"
wine mt4setup.exe

echo "Installation terminée!"