# n8n

[n8n](https://n8n.io) workflow automation running in Docker.

## Prerequisites

- Docker
- Docker Compose

## Quick start

```bash
docker compose up -d
```

Open http://localhost:5678

## Configuration

Set environment variables in a `.env` file:

| Variable              | Default       | Description                    |
|-----------------------|---------------|--------------------------------|
| `N8N_HOST`            | `localhost`   | n8n hostname                   |
| `N8N_PROTOCOL`        | `http`        | Protocol (http/https)          |
| `WEBHOOK_URL`         | `http://...`  | Public webhook URL             |
| `GENERIC_TIMEZONE`    | `UTC`         | Timezone (e.g. `Europe/Madrid`) |
| `MYSQL_DATABASE`      | `n8n`         | MySQL database name            |
| `MYSQL_USER`          | `n8n`         | MySQL user                     |
| `MYSQL_PASSWORD`      | `n8n`         | MySQL password                 |
| `MYSQL_ROOT_PASSWORD`  | `root`        | MySQL root password            |

Example `.env`:

```
N8N_HOST=n8n.example.com
N8N_PROTOCOL=https
WEBHOOK_URL=https://n8n.example.com
GENERIC_TIMEZONE=Europe/Madrid
```

## Database

A MySQL 8.0 container (`n8n_mysql`) is included on the same network. n8n connects automatically using the `DB_TYPE=mysql` configuration.

The database is mapped to the host on port `${MYSQL_HOST_PORT:-3307}`.

### phpMyAdmin

phpMyAdmin is available at http://localhost:${PHPMYADMIN_PORT:-8081} — no password needed (auto-login configured via `PMA_USER`/`PMA_PASSWORD`).

## Stop

```bash
docker compose down
```

To also remove the data volume:

```bash
docker compose down -v
```
