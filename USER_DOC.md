# USER_DOC — User Documentation

## What Services Are Provided?

| Service        | Description                                         |
|----------------|-----------------------------------------------------|
| WordPress      | The main website, served over HTTPS                 |
| MariaDB        | Database storing all WordPress content              |
| Nginx          | Reverse proxy, handles HTTPS traffic on port 443    |
| Redis          | Speeds up WordPress with object caching             |
| Adminer        | Browser-based interface to view/manage the database |
| Portainer      | Dashboard to monitor all running containers         |
| FTP Server     | File access to WordPress files via FTP              |
| Static Website | Simple bonus HTML page                              |

---

### Clone the Repository

```bash
git clone git@github.com:Selboukaoui/Inception.git
cd inception
```
 

## Start and Stop the Project

**Start:**
```bash
make
```

**Stop:**
```bash
make stop
```

**Rebuild everything from scratch:**
```bash
make clean && make
```

---

## Accessing Services


| Service         | URL / Port                        |
|-----------------|-----------------------------------|
| WordPress       | https://selbouka.42.fr            |
| Adminer         | http://localhost:8080/adminer.php             |
| Portainer       | http://localhost:9000             |
| Static Website  | http://localhost:1111             |
| FTP             | ftp localhost         |

---

> **Note:** Your browser may warn about the SSL certificate — this is expected since it is self-signed. Proceed past the warning.

---

## Credentials

All credentials are defined in `srcs/.env`. Key values:

| What              | Credential                    |
|-------------------|-------------------------------|
| WordPress Admin   | `selbouka_wp` / `samir`       |
| WordPress User    | `user` / `user`               |
| DB Name           | `wordpress`                   |
| DB User           | `selbouka` / `samir`          |
| FTP User          | `samir` / `ftp`               |

To log into **Adminer**, use:
- Server: `mariadb`
- Username: `selbouka`
- Password: `samir`
- Database: `wordpress`

---

## Checking That Services Are Running

```bash
docker compose ps
```

All containers should show status `Up`. You can also open Portainer at `http://localhost:9000` for a visual overview.

To view logs for a specific service:
```bash
docker compose logs wordpress
docker compose logs nginx
```
