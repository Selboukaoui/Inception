*This project has been created as part of the 42 curriculum by selbouka.*

# Inception

## Description

Inception is a system administration project that uses Docker to set up a small infrastructure of services. The goal is to run a WordPress website with its own database, reverse proxy, cache, and several bonus services all containerized with Docker Compose.

### Services Included

- **MariaDB**   --------------------  WordPress database
- **WordPress + PHP-FPM** ---- the CMS backend
- **Nginx** —--------------------- reverse proxy with TLS (HTTPS only, port 443)
- **Redis** —---------------------- object cache for WordPress
- **FTP** —------------------------ file access to the WordPress volume
- **Adminer** —------------------ web-based database management UI
- **Portainer** —----------------- Docker container monitoring dashboard
- **Static Website** —----------- a simple bonus HTML site
 
### Design Choices

**Virtual Machines vs Docker**
VMs virtualize an entire OS including the kernel, making them heavier and slower to start. Docker containers share the host kernel and are lightweight, faster, and more portable  ideal for this kind of multi-service setup.

**Secrets vs Environment Variables**
This project uses `.env` files for simplicity. In production, Docker Secrets are preferred as they store sensitive values in memory rather than environment variables, reducing exposure to tools like `docker inspect`.

**Docker Network vs Host Network**
All services use a custom bridge network (`inception`). This isolates containers from the host and from unrelated containers, while still allowing inter-service communication by name (e.g., `wordpress:9000`). Host networking removes that isolation.

**Docker Volumes vs Bind Mounts**
This project uses **bind mounts** (pointing to `/home/login/data/`), giving direct access to data from the host. Named volumes are more portable but less transparent. Bind mounts are a deliberate choice here for easy inspection and persistence across rebuilds.

### How AI Was Used


- AI (Claude) was used to understand certain concepts during development,
such as FTP connection modes (active vs passive).
- AI was used to enhance the styling of my documentation for preview.


---

## Instructions

### Prerequisites

- Docker and Docker Compose installed
- `make` available


### Build and Start

```bash
make
```

### Stop

```bash
make stop
```

### Access

| Service         | URL / Port                        |
|-----------------|-----------------------------------|
| WordPress       | https://login.42.fr            |
| Adminer         | http://localhost:8080/adminer.php             |
| Portainer       | http://localhost:9000             |
| Static Website  | http://localhost:1111             |
| FTP             | ftp localhost         |

---

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Deep Dive Book](https://github.com/rohitg00/DevOps_Books/blob/main/Docker%20Deep%20Dive%20Zero%20to%20Docker%20in%20a%20single%20book%20(Nigel%20Poulton)%20(z-lib.org).pdf)


- [Meduim](https://medium.com/@amehri_tarik/docker-the-theoretical-stuff-0846fa36d55f)


- [Youtube course](https://youtu.be/DFyPl2cZM2g?si=jJZBLnyYjZr7lMQM)
