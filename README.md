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

## Plan

### Tech Stack

- Elixir
- Phoenix
- PostgreSQL
- OAuth

### Teams

The core game logic and game management team consists of 2 sub-teams:

**Team A:**
- Alison
- Owen
- Braeden

**Team B:**
- Luka
- Madison
- Nik

The stats and database team consists of 2 sub-teams:

**Team C:**
- James
- Felix
- Richie

**Team D:**
- Ethan
- Ryan
- Mitchell

These team setups aren't rigid. There will be overlap between the 2 general teams and overlap between sub teams this is just to give everyone a group of things to focus on but not necessarily be locked in to.

### Feature List

Checkboxes ending in a question mark are ideas that either require refinement or are possibly out of scope.

- [ ] Core game logic
    - [ ] Generating words?
    - [ ] Track where a user is on a given word.
    - [ ] Pressing space goes to next word.
        - [ ] Don't allow user to go to next word if they've made a mistake on the current word.
    - [ ] Get user WPM
    - [ ] Get user accuracy
    - [ ] Implement game UI. 
- [ ] Game manager
    - [ ] Let users create new rooms.
    - [ ] Generate a code and URL to allow their friends to join their room.
    - [ ] Allow host to begin the game when they are ready.
    - [ ] Rooms should persist and allow for players to do another round after completion.
    - [ ] Allow hosts to change game settings.
        - [ ] Number of words they have to type?
        - [ ] Anything else people can come up with.
    - [ ] Should update the database when a game is completed.
- [ ] Room workers/proxies?
    - [ ] Need a system for workers or proxies to handle individual user connections and individual user input validations?
    - [ ] Need a system to send users inputs and progress to the room to display their progress to other users?
    - [ ] When game ends send results to game manager.
- [ ] User sign-up and login
    - [ ] Let user enter username and password
    - [ ] Let user use OAuth (if they want).
        - [ ] Generate a username based on OAuth (they can change it later)
- [ ] User settings
    - [ ] Let user change username and password
    - [ ] Let user add OAuth
    - [ ] Let user change font (if time permits)
    - [ ] Other fun settings for users (if time permits)
- [ ] Leaderboards
    - [ ] Have a leaderboard for highest WPM
    - [ ] Have a leaderboard for highest **average** accuracy
    - [ ] Have a leaderboard for number of games won
    - [ ] Store leaderboards in postgres
- [ ] Stats
    - [ ] A stats UI page. 
        - Loosely based on stats page on [monkey type](https://monkeytype.com/).
    - [ ] Should track raw WPM, WPM, and Accuracy
        - Raw WPM = (total characters / 5) / minutes
        - WPM = Raw WPM - (Errors / minutes)
        - Accuracy = (Correct characters / total characters) * 100
    - [ ] Show all of the players games with timestamp and additional info (raw WPM, WPM, accuracy, etc.)
        - [ ] Allow users to apply filters on their games.
    - [ ] Time spent playing games (games they didn't finish don't count)
    - [ ] Number of words typed (games they didn't finish don't count)
    - [ ] Number of games completed
