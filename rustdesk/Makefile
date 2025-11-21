# RustDesk Server Management Makefile

.PHONY: help up down restart logs status backup restore clean update dev

# Default target
help:
	@echo "RustDesk Server Management Commands:"
	@echo "  make up        - Start the RustDesk server"
	@echo "  make down      - Stop the RustDesk server"
	@echo "  make restart   - Restart the RustDesk server"
	@echo "  make logs      - Show logs"
	@echo "  make status    - Show container status"
	@echo "  make backup    - Create backup"
	@echo "  make restore   - Restore from backup (specify BACKUP_FILE)"
	@echo "  make clean     - Clean unused Docker resources"
	@echo "  make update    - Update and restart services"
	@echo "  make dev       - Start in development mode"
	@echo "  make health    - Check service health"

# Service management
up:
	docker-compose up -d
	@echo "RustDesk server started successfully"
	@echo "Access API at: http://localhost:21114"

down:
	docker-compose down
	@echo "RustDesk server stopped"

restart:
	docker-compose restart
	@echo "RustDesk server restarted"

logs:
	docker-compose logs -f

status:
	docker-compose ps

# Development
dev:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
	@echo "RustDesk server started in development mode"

# Backup and restore
backup:
ifeq ($(OS),Windows_NT)
	@.\backup.bat
else
	@./backup.sh
endif

restore:
ifdef BACKUP_FILE
ifeq ($(OS),Windows_NT)
	@.\restore.bat $(BACKUP_FILE)
else
	@./restore.sh $(BACKUP_FILE)
endif
else
	@echo "Please specify BACKUP_FILE: make restore BACKUP_FILE=backups/filename.tar.gz"
endif

# Maintenance
clean:
	docker system prune -f
	docker volume prune -f
	@echo "Cleaned unused Docker resources"

update:
	docker-compose pull
	docker-compose up -d
	@echo "Services updated and restarted"

# Health check
health:
	@echo "Checking RustDesk server health..."
	@curl -f http://localhost:21114/api/health || echo "Health check failed"
	@docker inspect rustdesk-all-in-one --format='Container Status: {{.State.Status}}' || echo "Container not running"

# Environment setup
setup:
	@if [ ! -f .env ]; then \
		echo "Creating .env file from template..."; \
		cp .env.example .env; \
		echo "Please edit .env file with your configuration"; \
	else \
		echo ".env file already exists"; \
	fi

# Show configuration
config:
	@echo "Current configuration:"
	@docker-compose config