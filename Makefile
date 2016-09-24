REVISION=`git rev-parse HEAD`

up_db:
	docker-compose up -d kong-database cuenta-database aldea-database database

setup_db: setup_cuenta_db setup_aldea_db setup_dios_db

setup_cuenta_db:
	docker-compose run --rm cuenta-application mix ecto.setup

setup_aldea_db:
	docker-compose run --rm aldea-application bundle exec rails db:setup

setup_dios_db:
	docker-compose run --rm application bundle exec rails db:setup

build:
	docker build --no-cache --tag dios-application --build-arg REVISION=$(REVISION) .

dev-build:
	docker build --tag dios-application --build-arg REVISION=$(REVISION) .
