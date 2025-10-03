#!/bin/bash

# Nom du conteneur
CONTAINER_NAME="mt4-official"

# Vérifier si le conteneur existe déjà
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Le conteneur $CONTAINER_NAME existe déjà."
    
    # Vérifier s'il est en cours d'exécution
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Le conteneur est en cours d'exécution."
        docker exec -it $CONTAINER_NAME bash
    else
        echo "Redémarrage du conteneur..."
        docker start $CONTAINER_NAME
        docker exec -it $CONTAINER_NAME bash
    fi
else
    echo "Création et lancement du nouveau conteneur..."
    
    # Configurer X11
    xhost +local:docker
    
    # Lancer le conteneur
    docker run -it \\
        --name $CONTAINER_NAME \\
        --net host \\
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \\
        -v mt4-data:/home/trader/.mt4:rw \\
        -e DISPLAY=$DISPLAY \\
        -e QT_X11_NO_MITSHM=1 \\
        --ipc=host \\
        mt4-official
fi