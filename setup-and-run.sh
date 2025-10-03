#!/bin/bash

# Configuration de l'affichage
export DISPLAY=${DISPLAY:-:0.0}

# Fonction pour vérifier si MT4 est installé
check_mt4_installed() {
    if [ -d "$HOME/.mt4/drive_c/Program Files/MetaTrader 4" ]; then
        return 0
    else
        return 1
    fi
}

# Installer MT4 si ce n'est pas déjà fait
if ! check_mt4_installed; then
    echo "Installation de MetaTrader 4 avec le script officiel..."
    
    # Exécuter le script d'installation officiel
    # Le script gère automatiquement l'installation de Wine et MT4
    export DEBIAN_FRONTEND=noninteractive
    ./mt4ubuntu.sh
    
    echo "Installation terminée!"
else
    echo "MetaTrader 4 déjà installé."
fi

# Attendre que l'installation soit complète
sleep 5

# Lancer MetaTrader 4
if check_mt4_installed; then
    echo "Démarrage de MetaTrader 4..."
    cd "$HOME/.mt4/drive_c/Program Files/MetaTrader 4"
    wine terminal.exe
else
    echo "Erreur: MetaTrader 4 n'a pas pu être installé correctement."
    echo "Tentative de démarrage manuel..."
    
    # Essayer d'exécuter le script d'installation en mode interactif
    bash -c "cd /home/trader && ./mt4ubuntu.sh"
    
    # Garder le conteneur en vie pour debugging
    sleep infinity
fi