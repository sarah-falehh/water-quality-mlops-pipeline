PYTHON ?= python

.PHONY: install format lint security test train api docker-up docker-down

install:
	$(PYTHON) -m pip install -r requirements.txt

format:
	$(PYTHON) -m black src tests

lint:
	$(PYTHON) -m flake8 src tests --max-line-length=100

security:
	$(PYTHON) -m bandit -r src

test:
	PYTHONPATH=src $(PYTHON) -m pytest -q

train:
	PYTHONPATH=src $(PYTHON) -m water_quality.cli

api:
	PYTHONPATH=src $(PYTHON) -m uvicorn water_quality.api:app --reload --port 8000

docker-up:
	docker compose up --build

docker-down:
	docker compose down
