## Setting Up From Scratch

### Prerequisites

- Docker Engine (20.10+) and Docker Compose (v2+)
- `make` (optional, if a Makefile is used)
- A host machine running Linux

### 1. Clone the Repository

```bash
git clone git@github.com:Selboukaoui/Inception.git
cd inception
```

### 2. Configure Environment Variables

The configuration file is at `srcs/.env`. It is **not committed to git** (see `.gitignore`). Create or verify it contains:

```env
MYSQL_ROOT_PASSWORD=samir
MYSQL_DATABASE=wordpress
MYSQL_USER=selbouka
MYSQL_PASSWORD=samir

WP_DB_HOST=mariadb
WP_ADMIN=selbouka_wp
WP_ADMIN_PASSWORD=samir
WP_ADMIN_EMAIL=example@gmail.com
URL=https://selbouka.42.fr

WP_USER=user
WP_USER_EMAIL=user@gmail.com
WP_USER_PASSWORD=user

WP_REDIS_HOST=redis
WP_REDIS_PORT=6379

FTP_USER=samir
FTP_PASS=ftp
```

---

## Build and Launch

```bash
make
(it will create needed files and start docker compose)
```

To down and clean just do:

```bash
make clean
```

---

## Useful Container Management Commands

```bash
# View running containers
docker compose ps

# View logs
docker compose logs -f <service>

# Enter a container shell
docker exec -it <container_name> bash

# Stop all containers
docker compose down

# Stop and remove volumes (full reset)
docker compose down -v
```

---

## Project Data and Persistence

Data is stored on the host using **bind mounts**:

| Volume         | Host Path                          | Container Path        |
|----------------|------------------------------------|-----------------------|
| WordPress files| `/home/selbouka/data/wordpress`    | `/var/www/html`       |
| MariaDB data   | `/home/selbouka/data/mariadb`      | `/var/lib/mysql`      |
| Portainer data | `/home/selbouka/data/portainer`    | `/data`               |

Data in these directories **persists across container restarts and rebuilds**. To fully reset, stop containers and delete the contents of these directories manually.



---

## Notes

- All services communicate over the `inception` Docker bridge network. Use service names (e.g., `mariadb`, `wordpress`) as hostnames inside containers.
- Nginx handles TLS termination using a self-signed certificate generated at build time (`openssl`).
- WordPress is configured and installed at runtime via WP-CLI inside the container's entrypoint script.
- Redis cache is enabled automatically via the `redis-cache` plugin and WP-CLI during WordPress setup.
