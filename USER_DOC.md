# User Documentation — Inception

## Services provided

| Service | Role |
|---|---|
| **nginx** | Reverse proxy HTTPS (port 443), point d'entrée unique |
| **wordpress** | Site web et interface d'administration |
| **mariadb** | Base de données du site WordPress |

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

## Access the website and the administration panel

- **Site web** : [https://relaforg.42.fr](https://relaforg.42.fr)
- **Administration WordPress** : [https://relaforg.42.fr/wp-admin](https://relaforg.42.fr/wp-admin)

> Le certificat SSL est auto-signé, le navigateur affichera un avertissement — acceptez-le pour continuer.

---

## Credentials

| Service | Utilisateur | Mot de passe |
|---|---|---|
| WordPress admin | `relaforg` | voir `.env` → `WP_ADMIN_PASSWORD` |
| MariaDB | `wpuser` | voir `.env` → `MYSQL_PASSWORD` |
