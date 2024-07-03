.PHONY: install-docker install-make db-start db-migrate api-build api-run api-start

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