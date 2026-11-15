# TpRacer

## Running the app

The app and PostgreSQL server run in Docker.

### Prerequisites

- [Docker](https://docs.docker.com/get-started/get-docker/) + compose plugin

On Linux add your user to `docker` group so you don't need `sudo`:
```bash
sudo usermod -aG docker $USER
```
then logout and log back in.

### Setup

Ensure the docker daemon or docker desktop app before continuing.

1. Start Everything:

```bash
docker compose up --build
```

The first run takes a few minutes. It builds the image, starts Postgres, installs dependencies, creates and migrates the database, and starts the server.

Docker is also setup to automatically run the app in live-reload mode so you can instantly see your changes as you make them.

2. Open <http://localhost:4000>.

### Everyday use

```bash
docker compose up                  # start (add -d to run in the background)
docker compose logs -f web         # follow the app logs
docker compose exec web mix test   # run the tests
docker compose stop                # stop, but keep data 
docker compose down                # remove the containers, keeping the database
docker compose down -v             # remove everything, including the database
```

After pulling changes with new migrations, restart the app:
```bash
docker compose restart web
```

### Troubleshooting

- **Port 5432 already in use:** another Postgres is running on your machine.

Stop local Postgres service with one of these:
```bash
sudo systemctl stop postgresql           # stop it now
sudo systemctl disable postgresql        # stop it from running on boot
sudo systemctl disable --now postgresql  # both
```

**then**

Reset and rebuild:
```bash
docker compose down -v
docker compose up --build
```

**OR**

Run it on a different port:
```bash
DB_PORT=5433 docker compose up
```

- **Cannot connect to the Docker daemon:** start Docker (open Docker Desktop, or `sudo systemctl start docker` on Linux).
- **`permission denied` on Linux:** see the `prerequisites` section above to disable the need for `sudo`.
- **Something is stuck after changing the Dockerfile or dependencies:** reset and rebuild:

```bash
docker compose down -v
docker compose up --build
```
