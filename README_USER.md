# User Documentation — Inception

This document explains how to use and manage the Inception stack as an end user or administrator.

---

## What Services Are Provided?

The Inception stack runs three services, each in its own Docker container:

**NGINX** is the web server and the only entry point to the application. It listens on port 443 (HTTPS) and handles all incoming requests from your browser. It serves static files directly and forwards PHP requests to WordPress.

**WordPress** is the website and content management system (CMS). It allows you to create, edit, and manage content through a visual admin panel. It runs behind NGINX and communicates with MariaDB to read and store data.

**MariaDB** is the database. It stores all application data including users, posts, pages, settings, and more. It is not directly accessible from the browser — only WordPress talks to it internally.

---

## Starting and Stopping the Project

Open a terminal at the root of the repository.

**To start the project:**
```bash
make
```
This builds the images (if not already built) and starts all three containers in the background.

**To stop the project (without losing data):**
```bash
make down
```
This stops and removes the containers. Your data (database, WordPress files) is preserved in Docker volumes and will be available next time you start.

**To do a full clean (removes everything including data):**
```bash
make fclean
```
> ⚠️ This deletes all volumes and data. Only use this if you want a completely fresh start.

---

## Accessing the Website

Once the project is running, open your browser and go to:

```
https://localhost
```

> Your browser will show a security warning because the TLS certificate is self-signed. This is expected for a local setup. Click **"Advanced"** and then **"Proceed to localhost"** (or equivalent in your browser) to continue.

You will land on the WordPress website homepage.

---

## Accessing the Administration Panel

The WordPress admin panel is available at:

```
https://localhost/wp-admin
```

Log in with the admin credentials defined during setup (see the Credentials section below). From here you can manage pages, posts, users, themes, and plugins.

---

## Locating and Managing Credentials

All sensitive credentials (passwords) are stored as **Docker Secrets**, not in plain text environment files. They are located in the `secrets/` directory at the root of the repository:

| File | Contents |
|---|---|
| `secrets/db_password.txt` | MariaDB user password |
| `secrets/db_root_password.txt` | MariaDB root password |
| `secrets/wp_admin_password.txt` | WordPress admin password |
| `secrets/wp_user_password.txt` | WordPress regular user password |

Non-sensitive configuration (usernames, database name, site URL) is stored in the `.env` file at the root of the repository.

> ⚠️ Never share or commit the `secrets/` directory or the `.env` file to a public repository.

To change a password, update the relevant file in `secrets/`, then restart the stack with `make down && make`.

---

## Checking That Services Are Running

**List all running containers:**
```bash
docker compose ps
```
You should see three containers with status `Up`: `nginx`, `wordpress`, and `mariadb`.

**Check the logs of a specific service:**
```bash
docker compose logs nginx
docker compose logs wordpress
docker compose logs mariadb
```

**Follow logs in real time:**
```bash
docker compose logs -f
```

**Check NGINX is reachable:**

Open `https://localhost` in your browser. A response (even a WordPress error page) confirms NGINX is up.

**Check WordPress is processing PHP:**

The homepage loading correctly confirms WordPress and PHP-FPM are working.

**Check MariaDB is running:**
```bash
docker compose exec mariadb mariadb -u root -p
```
Enter the root password from `secrets/db_root_password.txt`. If you get a MariaDB prompt, the database is healthy.