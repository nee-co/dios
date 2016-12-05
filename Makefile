REVISION=`git rev-parse HEAD`

.PHONY: image db app seed migrate volumes networks

image:
	docker build --tag dios-application --build-arg REVISION=$(REVISION) .

db:
	docker-compose up -d  dios-database

app:
	docker-compose run -p 3000:3000 dios-application ash

seed:
	docker-compose run --rm dios-application bundle exec rails db:seed

migrate:
	docker-compose run --rm dios-application bundle exec rails db:migrate

volumes:
	@docker volume create --name neeco_dios || true

networks:
	@docker network create neeco_dios || true
	@docker network create neeco_dios-aldea || true
	@docker network create neeco_dios-caja || true
	@docker network create neeco_dios-cuenta || true
	@docker network create neeco_dios-kong || true
