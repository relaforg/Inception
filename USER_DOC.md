# User Documentation — Inception

## Services provided

| Service | Role |
|---|---|
| **nginx** | Reverse proxy HTTPS (port 443), point d'entrée unique |
| **wordpress** | Site web et interface d'administration |
| **mariadb** | Base de données du site WordPress |
| **redis** | Cache en mémoire pour WordPress |
| **ftp** | Accès FTP aux fichiers WordPress (port 21) |
| **static_site** | Site statique de présentation |
| **adminer** | Interface web de gestion de base de données |
| **gitea** | Forge Git auto-hébergée |

---

## Start and stop the project

**Start:**
```bash
make
```

**Stop:**
```bash
make down
```

---

## Access the services

| Service | URL |
|---|---|
| **Site WordPress** | [https://relaforg.42.fr](https://relaforg.42.fr) |
| **Administration WordPress** | [https://relaforg.42.fr/wp-admin](https://relaforg.42.fr/wp-admin) |
| **Site statique** | [https://static.relaforg.42.fr](https://static.relaforg.42.fr) |
| **Adminer** | [https://adminer.relaforg.42.fr](https://adminer.relaforg.42.fr) |
| **Gitea** | [https://gitea.relaforg.42.fr](https://gitea.relaforg.42.fr) |
| **FTP** | `ftp relaforg.42.fr` (port 21) |

> Le certificat SSL est auto-signé, le navigateur affichera un avertissement — acceptez-le pour continuer.

---

## Credentials

| Service | Utilisateur | Mot de passe |
|---|---|---|
| WordPress admin | `relaforg` | voir `.env` → `WP_ADMIN_PASSWORD` |
| MariaDB | `wpuser` | voir `.env` → `MYSQL_PASSWORD` |
| FTP | voir `.env` → `FTP_USER` | voir `.env` → `FTP_PASS` |
| Gitea | configurable à la première connexion | — |
