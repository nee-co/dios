REVISION=`git rev-parse HEAD`

.PHONY: image dev-image up_db up_app setup_db volumes networks

image:
	docker build --no-cache --tag dios-application --build-arg REVISION=$(REVISION) .

dev-image:
	docker build --tag dios-application --build-arg REVISION=$(REVISION) .

up_db:
	docker-compose up -d  dios-database

up_app:
	docker-compose up -d  dios-application

setup_db:
	docker-compose run --rm dios-application bundle exec rails db:setup

volumes:
	@docker volume create --name neeco_aldea || true
	@docker volume create --name neeco_cuenta || true
	@docker volume create --name neeco_dios || true
	@docker volume create --name neeco_kong || true

networks:
	@docker network create neeco_dios || true
	@docker network create neeco_dios-aldea || true
	@docker network create neeco_dios-cuenta || true
	@docker network create neeco_dios-kong || true
