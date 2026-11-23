#!/bin/sh
set -e

mix deps.get
mix ecto.create
mix ecto.migrate
mix assets.setup

exec "$@"
