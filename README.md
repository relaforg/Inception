*This project has been created as part of the 42 curriculum by relaforg*

# Inception

## Description

The **Inception** project introduce us to docker and contenairization building a little
app stack.


## Instructions

To run :

```bash
make up
```
 
To stop :

```bash
make down
```

## Project Description

This project uses **Docker** and **Docker Compose** to orchestrate a small infrastructure of services running in isolated containers, each built from a custom `Dockerfile` based on `debian:bookworm-slim`.

### Services included

| Service | Image | Role |
|---|---|---|
| **nginx** | custom debian | Reverse proxy HTTPS (TLS 1.2/1.3), seul point d'entrée sur le port 443 |
| **wordpress** | custom debian | Application PHP-FPM + WP-CLI pour l'installation automatique |
| **mariadb** | custom debian | Base de données relationnelle persistante |

### Main design choices

- **No pre-built images** : chaque service est construit depuis `debian:bookworm-slim` via un `Dockerfile` dédié.
- **Isolation réseau** : tous les conteneurs communiquent via un réseau Docker bridge nommé `inception`. Aucun conteneur n'utilise `network_mode: host`.
- **Persistance des données** : les données MariaDB et WordPress sont stockées dans des volumes Docker nommés (`mariadb_data`, `wordpress_data`), montés respectivement dans `~/data/mariadb` et `~/data/wordpress` sur l'hôte.
- **Secrets** : les credentials sont externalisés dans un fichier `srcs/.env` non versionné, injecté via `env_file` dans les conteneurs concernés.
- **Démarrage ordonné** : des `healthcheck` garantissent que MariaDB est prêt avant WordPress, et WordPress avant nginx.
- **Installation automatique** : WordPress est configuré et installé automatiquement au premier démarrage via WP-CLI, sans intervention manuelle.

## Key Concepts

### Virtual Machines vs Docker

**VM** : émule un ordinateur complet avec son propre OS, kernel, drivers. Lent à démarrer, lourd en ressources, isolation totale.

**Docker** : partage le kernel de l'hôte, isole uniquement les processus. Démarre en millisecondes, léger. Moins isolé qu'une VM mais largement suffisant pour la plupart des cas.

### Secrets vs Variables d'environnement

**Variables d'environnement** (`.env`, `env_file`) : les valeurs sont visibles en clair dans `docker inspect`, les logs, ou `ps aux`. Simple mais pas sécurisé pour la production.

**Docker Secrets** : les valeurs sont montées comme fichiers dans `/run/secrets/` à l'intérieur du conteneur, chiffrées en transit (Docker Swarm). Jamais exposées dans les métadonnées du conteneur.

### Docker Network vs Host Network

**Docker Network** (`driver: bridge`) : chaque conteneur a sa propre interface réseau virtuelle et une IP privée. Les conteneurs communiquent entre eux par nom de service. L'hôte est isolé.

**Host Network** (`network_mode: host`) : le conteneur partage directement la stack réseau de l'hôte. Pas d'isolation, le conteneur voit et utilise les ports de la machine directement.

### Docker Volumes vs Bind Mounts

**Bind Mount** : monte un dossier de l'hôte directement dans le conteneur (`/home/user/data:/var/lib/mysql`). Simple, mais dépend de la structure de l'hôte, et moins portable.

**Docker Volume** : Docker gère lui-même le stockage dans `/var/lib/docker/volumes/`. Portable, gérable via `docker volume` CLI, et recommandé pour les données persistantes.

```yaml
# Bind mount (déconseillé par le sujet)
volumes:
  - /home/relaforg/data/mariadb:/var/lib/mysql

# Named volume (recommandé)
volumes:
  - mariadb_data:/var/lib/mysql
```

## Resources

- [Dockerfiles](https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/)
- Various service docs (nginx, mariadb, ...)
- [Claude](https://claude.ia)
