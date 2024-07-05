.PHONY: run migrate test lint docker-build docker-run install-docker install-make db-start db-migrate api-build api-run api-start

# Docker-related variables
DOCKER_IMAGE_NAME := student-crud
DOCKER_IMAGE_VERSION := 1.0.0

# Original targets
run:
	python manage.py runserver

migrate:
	python manage.py makemigrations
	python manage.py migrate

test: lint
	python manage.py test

lint:
	flake8 .

# Docker commands
docker-build:
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) .

docker-run:
	docker run -p 8000:8000 --env-file .env $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

# Installation targets
install-docker:
	@echo "Installing Docker..."
	@if [ "$$(uname)" = "Darwin" ]; then \
		brew install --cask docker; \
	elif [ "$$(expr substr $$(uname -s) 1 5)" = "Linux" ]; then \
		sudo apt-get update && sudo apt-get install -y docker.io; \
	else \
		echo "Unsupported operating system. Please install Docker manually."; \
		exit 1; \
	fi

install-make:
	@echo "Installing Make..."
	@if [ "$$(uname)" = "Darwin" ]; then \
		brew install make; \
	elif [ "$$(expr substr $$(uname -s) 1 5)" = "Linux" ]; then \
		sudo apt-get update && sudo apt-get install -y make; \
	else \
		echo "Unsupported operating system. Please install Make manually."; \
		exit 1; \
	fi

# Docker Compose targets
db-start:
	docker-compose up -d db

db-migrate:
	docker-compose run --rm api python manage.py migrate

api-build:
	docker-compose build api

api-run:
	docker-compose up api

api-start:
	@echo "Starting API and dependencies..."
	@if ! docker-compose ps | grep -q "db"; then \
		echo "Starting database..."; \
		$(MAKE) db-start; \
		echo "Waiting for database to be ready..."; \
		sleep 10; \
	fi
	@echo "Running database migrations..."
	@$(MAKE) db-migrate
	@echo "Starting API..."
	@$(MAKE) api-run


deploy:
	docker-compose up -d --scale api=2