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
| `srcs/requirements/nginx/default.conf` | Configuration nginx |
| `srcs/requirements/wordpress/wp-config.php` | Configuration WordPress |
| `srcs/requirements/wordpress/www.conf` | Configuration php-fpm |

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
```

> Ne jamais commiter `.env` — il est dans le `.gitignore`.

---

## Build and launch the project

```bash
make        # build les images et démarre les conteneurs
make down   # arrête et supprime les conteneurs
```

Le `make up` crée automatiquement les répertoires de données avant de lancer Docker Compose.

---

## Useful commands

```bash
# Voir l'état des conteneurs
docker compose -f srcs/docker-compose.yml ps

# Rebuild un seul service
docker compose -f srcs/docker-compose.yml up --build <service>

# Accéder à un conteneur
docker exec -it <nginx|wordpress|mariadb> sh

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

Les volumes survivent à un `make down`. Pour tout réinitialiser :
```bash
docker compose -f srcs/docker-compose.yml down -v
sudo rm -rf ~/data/mariadb/* ~/data/wordpress/*
```
