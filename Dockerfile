FROM ubuntu:20.04

# Éviter les invites interactives
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0.0

# Mise à jour et installation des dépendances
RUN apt-get update && apt-get install -y \\
    wget \\
    curl \\
    xvfb \\
    x11-apps \\
    xauth \\
    ca-certificates \\
    sudo \\
    && rm -rf /var/lib/apt/lists/*

# Créer un utilisateur non-root
RUN useradd -m -u 1000 -s /bin/bash trader && \\
    echo "trader ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER trader
WORKDIR /home/trader

# Installation de MetaTrader 4 avec le script officiel
RUN wget https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4ubuntu.sh && \\
    chmod +x mt4ubuntu.sh

# Script de configuration et démarrage
COPY --chown=trader:trader setup-and-run.sh /home/trader/
RUN chmod +x /home/trader/setup-and-run.sh

CMD ["/home/trader/setup-and-run.sh"]