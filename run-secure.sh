#!/bin/bash

# Créer le fichier xauth
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# Lancer avec xauth
docker run -it \\
    --name mt4-official-secure \\
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \\
    -v $XAUTH:$XAUTH:rw \\
    -v mt4-data:/home/trader/.mt4:rw \\
    -e DISPLAY=$DISPLAY \\
    -e XAUTHORITY=$XAUTH \\
    -e QT_X11_NO_MITSHM=1 \\
    --user 1000 \\
    mt4-official