*This project has been created as part of the 42 curriculum by login.*

# Inception

## Description
This project aims to broaden the knowledge of system administration by using Docker. It virtualizes several Docker images, creating them in a personal virtual machine. The goal is to set up a small infrastructure composed of different services under specific rules (NGINX, MariaDB, WordPress) using Docker Compose.

## Instructions
1.  **Prerequisites**: Docker, Docker Compose, Make.
2.  **Configuration**: 
    - Ensure `.env` exists in `srcs/` (see `srcs/.env.sample` if available, or ask developer).
    - Add `127.0.0.1 login.42.fr` to your `/etc/hosts`.
3.  **Run**:
    - `make` or `make build` to setting up.
    - `make down` to stop.
    - `make fclean` to clean everything including data.

## Resources
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress Docker Image](https://hub.docker.com/_/wordpress)

**AI Usage**: AI was used to assist in debugging configuration files (nginx.conf), generating boilerplate Dockerfiles, and clarifying the subject requirements regarding volume persistence and network isolation.

## Project Description & Design Choices
### Virtual Machines vs Docker
A Virtual Machine (VM) emulates an entire computer system, including the OS kernel, which makes it heavy. Docker containers share the host's kernel and are lightweight/faster. For this project, containers are chosen for efficiency and isolation of services.

### Secrets vs Environment Variables
We use Environment Variables via `.env` file as mandated by the subject. However, for sensitive production data, Docker Secrets are generally safer as they are not exposed in the process environment. We kept `.env` for compliance and simplicity in this scope.

### Docker Network vs Host Network
We use a custom bridge network (`inception`). `network: host` is forbidden. Isolation ensures only NGINX is exposed to the host (port 443), while DB and WordPress talk privately.

### Docker Volumes vs Bind Mounts
We use Bind Mounts (`driver_opts: type=none, o=bind`) to map data to the specific host path `/home/login/data`. This meets the requirement of having data accessible and persistent on the host machine at a specific location, unlike standard named volumes which are hidden in `/var/lib/docker/volumes`.
