# Developer Documentation — Inception

This document explains how to set up, build, run, and manage the Inception project from a developer perspective.

---

## Prerequisites

Before setting up the project, make sure the following are installed on your machine:

| Tool | Purpose | Check |
|---|---|---|
| Docker Engine | Running containers | `docker --version` |
| Docker Compose (v2) | Orchestrating multi-container setup | `docker compose version` |
| Make | Running project commands via Makefile | `make --version` |
| OpenSSL | Generating the TLS certificate (used in NGINX build) | `openssl version` |

> On **macOS**, Docker Desktop includes both Docker Engine and Docker Compose.
> On **Linux**, install them separately via your package manager. Ensure your user is in the `docker` group: `sudo usermod -aG docker $USER`.

---

## Repository Structure

```
inception/
├── Makefile
├── .env                        # Non-sensitive environment variables
├── secrets/                    # Docker Secrets (sensitive credentials)
│   ├── db_password.txt
│   ├── db_root_password.txt
│   ├── wp_admin_password.txt
│   └── wp_user_password.txt
├── srcs/
│   ├── docker-compose.yml      # Service definitions
│   └── requirements/
│       ├── nginx/
│       │   ├── Dockerfile
│       │   └── conf/           # NGINX config files
│       ├── wordpress/
│       │   ├── Dockerfile
│       │   └── conf/           # PHP-FPM config, wp-config setup
│       └── mariadb/
│           ├── Dockerfile
│           └── conf/           # MariaDB init scripts
└── README.md
```

---

## Environment Configuration

### 1. Create the `.env` file

Copy the example file (if provided) or create `.env` at the root of the repository:

```bash
cp .env.example .env
```

Edit it to match your setup:

```env
# Domain
DOMAIN_NAME=login.42.fr        # Replace with your 42 login

# MariaDB
DB_NAME=wordpress
DB_USER=wp_user
DB_HOST=mariadb

# WordPress
WP_TITLE=My Inception Site
WP_ADMIN_USER=admin
WP_ADMIN_EMAIL=admin@example.com
WP_USER=editor
WP_USER_EMAIL=editor@example.com
```

> Passwords are **not** stored here — they go in `secrets/`.

### 2. Create the secrets files

Create the `secrets/` directory and populate each file with a single password (no trailing newline):

```bash
mkdir -p secrets
printf 'your_db_password'       > secrets/db_password.txt
printf 'your_db_root_password'  > secrets/db_root_password.txt
printf 'your_wp_admin_password' > secrets/wp_admin_password.txt
printf 'your_wp_user_password'  > secrets/wp_user_password.txt
```

> Use `printf` (not `echo`) to avoid adding a newline character, which could cause authentication failures.

### 3. Hosts file (if using a custom domain)

If `DOMAIN_NAME` is set to something other than `localhost` (e.g., `login.42.fr`), add it to your hosts file:

```bash
# Linux / macOS
echo "127.0.0.1  login.42.fr" | sudo tee -a /etc/hosts
```

---

## Building and Launching the Project

All common tasks are handled through the `Makefile`.

### Build and start (detached)
```bash
make
```
Equivalent to: `docker compose -f srcs/docker-compose.yml up --build -d`

### Stop containers (preserve volumes)
```bash
make down
```
Equivalent to: `docker compose -f srcs/docker-compose.yml down`

### Stop and remove everything including volumes and images
```bash
make fclean
```

### Rebuild from scratch
```bash
make re
```
Equivalent to `make fclean && make`.

---

## Managing Containers

### View running containers
```bash
docker compose -f srcs/docker-compose.yml ps
```

### View logs
```bash
# All services
docker compose -f srcs/docker-compose.yml logs

# Single service, follow mode
docker compose -f srcs/docker-compose.yml logs -f wordpress
```

### Execute a command inside a container
```bash
# Open a shell in the WordPress container
docker compose -f srcs/docker-compose.yml exec wordpress sh

# Open a MariaDB prompt
docker compose -f srcs/docker-compose.yml exec mariadb mariadb -u root -p

# Test NGINX config
docker compose -f srcs/docker-compose.yml exec nginx nginx -t
```

### Restart a single service
```bash
docker compose -f srcs/docker-compose.yml restart nginx
```

### Rebuild and restart a single service
```bash
docker compose -f srcs/docker-compose.yml up --build -d wordpress
```

---

## Managing Volumes

Docker volumes are used to persist data between container restarts.

### List volumes
```bash
docker volume ls
```

You should see two volumes created by this project:
- `inception_db_data` — MariaDB database files
- `inception_wp_data` — WordPress core files

### Inspect a volume (see where it lives on disk)
```bash
docker volume inspect inception_db_data
```
The `Mountpoint` field shows the actual path on the host machine (typically under `/var/lib/docker/volumes/`).

### Remove a specific volume
```bash
docker volume rm inception_db_data
```
> ⚠️ This permanently deletes all data stored in that volume.

### Remove all unused volumes
```bash
docker volume prune
```

---

## Where Data Is Stored and How It Persists

### MariaDB data

- **Inside the container:** `/var/lib/mysql/`
- **Persisted via:** Docker volume `inception_db_data`
- **On the host:** `/home/<your_login>/data/db/` (or as configured in `docker-compose.yml`)

The database files survive container stops, restarts, and rebuilds as long as the volume is not explicitly deleted.

### WordPress files

- **Inside the container (and NGINX):** `/var/www/html/`
- **Persisted via:** Docker volume `inception_wp_data`
- **On the host:** `/home/<your_login>/data/wordpress/` (or as configured in `docker-compose.yml`)

This volume is shared between the `wordpress` and `nginx` containers. WordPress uses it to execute PHP, and NGINX uses it to serve static assets directly.

### TLS Certificate

- **Inside the NGINX container:** `/etc/nginx/ssl/`
- Generated at **image build time** using OpenSSL.
- Not persisted via a volume — it is regenerated on each `docker build`.

---

## Useful Debugging Commands

```bash
# Check which ports are exposed on the host
docker compose -f srcs/docker-compose.yml ps

# Verify NGINX can reach WordPress on port 9000
docker compose -f srcs/docker-compose.yml exec nginx wget -qO- http://wordpress:9000

# Verify WordPress can reach MariaDB on port 3306
docker compose -f srcs/docker-compose.yml exec wordpress nc -zv mariadb 3306

# Check MariaDB has the WordPress database
docker compose -f srcs/docker-compose.yml exec mariadb \
  mariadb -u root -p -e "SHOW DATABASES;"

# Check PHP-FPM is running inside the WordPress container
docker compose -f srcs/docker-compose.yml exec wordpress ps aux | grep php
```