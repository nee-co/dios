.PHONY: db app migrate seed networks

db:
	docker-compose up -d dios-database

app:
	docker-compose run -p 3000:3000 dios-application ash

migrate:
	docker-compose run --rm dios-application bundle exec rails db:migrate

seed:
	docker-compose run --rm dios-application bundle exec rails db:seed

networks:
	@docker network create neeco_dios || true
	@docker network create neeco_dios-aldea || true
	@docker network create neeco_dios-caja || true
	@docker network create neeco_dios-cuenta || true
	@docker network create neeco_dios-imagen || true
	@docker network create neeco_dios-kong || true
