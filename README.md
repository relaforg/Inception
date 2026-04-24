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
