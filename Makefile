.PHONY: db app migrate seed network

db:
	docker-compose up -d dios-database

app:
	docker-compose run -p 3000:3000 dios-application ash

migrate:
	docker-compose run --rm dios-application bundle exec rails db:migrate

seed:
	docker-compose run --rm dios-application bundle exec rails db:seed

networks:
	@docker network create neeco_develop || true
