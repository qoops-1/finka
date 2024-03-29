run_dev:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
run_prod:
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
logs:
	docker-compose logs -f
down:
	docker-compose down
terminal:
	docker-compose run web bash
rc:
	docker-compose run web bin/rails c