# Developer Documentation — Inception

## Set up the environment from scratch

### Prerequisites

- Docker & Docker Compose installés
- `make` disponible

### Configuration files

| Fichier | Rôle |
|---|---|
| `srcs/.env` | Variables d'environnement et secrets |
| `srcs/docker-compose.yml` | Définition des services, réseaux et volumes |
| `srcs/requirements/nginx/default.conf` | Configuration nginx (virtual hosts) |
| `srcs/requirements/wordpress/wp-config.php` | Configuration WordPress |
| `srcs/requirements/wordpress/www.conf` | Configuration php-fpm |
| `srcs/requirements/gitea/app.ini` | Configuration Gitea |
| `srcs/requirements/ftp/proftpd.conf` | Configuration ProFTPD |

### Secrets (srcs/.env)

Créer le fichier `srcs/.env` à partir de ce modèle :
```env
# MariaDB
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=changeme

# WordPress admin
WP_URL=https://relaforg.42.fr
WP_TITLE=Inception
WP_ADMIN_USER=relaforg
WP_ADMIN_PASSWORD=changeme
WP_ADMIN_EMAIL=relaforg@42.fr
JOHN_PASS=changeme

# FTP server
FTP_USER=ftpuser
FTP_PASS=changeme

# Gitea
GITEA_WORK_DIR=/home/git/gitea
GITEA_SECRET_KEY=changeme
```

> Ne jamais commiter `.env` — il est dans le `.gitignore`.

---

## Build and launch the project

```bash
make        # build les images et démarre les conteneurs
make down   # arrête et supprime les conteneurs
make clean  # supprime les volumes Docker orphelins
make fclean # supprime tous les volumes et images Docker (reset complet)
```

---

## Useful commands

```bash
# Voir l'état des conteneurs
docker compose -f srcs/docker-compose.yml ps

# Rebuild un seul service
docker compose -f srcs/docker-compose.yml up --build <service>

# Accéder à un conteneur
docker exec -it <nginx|wordpress|mariadb|redis|ftp|adminer|gitea|static_site> sh

# Accéder à la base de données
docker exec -it mariadb mariadb -u root

# Voir les logs
docker logs <service>

# Supprimer les volumes (reset complet)
docker compose -f srcs/docker-compose.yml down -v
```

---

## Data persistence

Les données sont stockées dans des volumes Docker nommés :

| Volume | Données | Chemin hôte |
|---|---|---|
| `srcs_mariadb_data` | Base de données MariaDB | `~/data/mariadb` |
| `srcs_wordpress_data` | Fichiers WordPress | `~/data/wordpress` |
| `srcs_gitea_data` | Dépôts et données Gitea | géré par Docker |

Les volumes survivent à un `make down`. Pour tout réinitialiser :
```bash
make fclean
sudo rm -rf ~/data/mariadb/* ~/data/wordpress/*
```

---

## Service overview

| Service | Port interne | Port exposé | Dépendances |
|---|---|---|---|
| **nginx** | 443 | 443 | wordpress |
| **wordpress** | 9000 (php-fpm) | — | mariadb, redis |
| **mariadb** | 3306 | — | — |
| **redis** | 6379 | — | — |
| **ftp** | 21, 21100-21110 | 21, 21100-21110 | — |
| **static_site** | 80 | — | — |
| **adminer** | 8081 | — | mariadb |
| **gitea** | 3000 | — | — |

## Nginx routing

nginx agit comme reverse proxy unique sur le port 443. Les virtual hosts sont définis dans `requirements/nginx/default.conf` :

| Host | Backend |
|---|---|
| `relaforg.42.fr` | wordpress:9000 (php-fpm) |
| `static.relaforg.42.fr` | static_site:80 |
| `adminer.relaforg.42.fr` | adminer:8081 |
| `gitea.relaforg.42.fr` | gitea:3000 |
