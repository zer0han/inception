# User Documentation

## Services Overview
The stack provides:
*   **NGINX**: Secure web server (entry point).
*   **WordPress**: Content Management System.
*   **MariaDB**: Database backend.

## How to Manage
*   **Start**: Run `make` in the root directory.
*   **Stop**: Run `make down`.
*   **Access**: Open `https://login.42.fr` in your browser. (Accept the self-signed certificate warning).
*   **Clean**: Run `make fclean` to delete all data and containers.

## Credentials
Credentials are stored in `srcs/.env`. Do not share this file.
Default Admin User: See `WP_ADMIN_USER` in `.env`.
Default Normal User: See `WP_USER` in `.env`.
