# Docker MetaTrader 4 avec Installation Officielle

Ce projet permet de faire fonctionner MetaTrader 4 dans un conteneur Docker avec l'installation officielle de MetaQuotes et le forwarding X11.

## Fichiers inclus

- `Dockerfile` : Image Docker avec Ubuntu 20.04 et dépendances
- `setup-and-run.sh` : Script de configuration et démarrage automatique
- `install-mt4-manual.sh` : Script d'installation manuelle en cas de problème
- `docker-compose.yml` : Configuration Docker Compose
- `run.sh` : Script de lancement simplifié
- `run-secure.sh` : Script de lancement sécurisé avec xauth

## Utilisation rapide

### 1. Construction de l'image

```bash
docker build -t mt4-official .
```

### 2. Configuration X11

```bash
xhost +local:docker
```

### 3. Lancement

**Option A - Script simplifié :**
```bash
chmod +x run.sh
./run.sh
```

**Option B - Docker Compose :**
```bash
docker-compose up -d
docker-compose exec mt4 bash
```

**Option C - Commande manuelle :**
```bash
docker run -it \\
    --name mt4-official \\
    --net host \\
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \\
    -v mt4-data:/home/trader/.mt4:rw \\
    -e DISPLAY=$DISPLAY \\
    -e QT_X11_NO_MITSHM=1 \\
    --ipc=host \\
    mt4-official
```

## Caractéristiques

- **Installation officielle** : Utilise le script officiel MetaQuotes
- **Données persistantes** : Volume Docker pour sauvegarder les données MT4
- **Interface graphique** : Forwarding X11 pour affichage GUI
- **Sécurisé** : Utilisateur non-root dans le conteneur
- **Flexible** : Plusieurs méthodes de lancement disponibles

## Dépannage

### Problèmes d'affichage X11
```bash
# Réinitialiser les permissions X11
xhost -
xhost +local:docker

# Tester la connexion
docker exec -it mt4-official x11-apps
```

### Problèmes d'installation MT4
```bash
# Accéder au conteneur pour debugging
docker exec -it mt4-official bash

# Utiliser l'installation manuelle
./install-mt4-manual.sh
```

## Volumes Docker

Les données MT4 sont sauvegardées dans le volume Docker `mt4-data`. Pour sauvegarder/restaurer :

```bash
# Créer une sauvegarde
docker run --rm -v mt4-data:/data -v $(pwd):/backup alpine tar czf /backup/mt4-backup.tar.gz -C /data .

# Restaurer une sauvegarde
docker run --rm -v mt4-data:/data -v $(pwd):/backup alpine tar xzf /backup/mt4-backup.tar.gz -C /data
```

## Prérequis

- Docker installé
- Serveur X11 (sur Linux)
- Connexion Internet pour l'installation initiale

## Support

Ce projet utilise l'installation officielle MetaQuotes pour garantir la meilleure compatibilité possible avec MetaTrader 4.
