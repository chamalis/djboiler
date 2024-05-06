COMMON_SRC_PATHS = djboiler/ manage.py
ALL_SRC_PATHS = $(COMMON_SRC_PATHS)
ISORT_CHECK_PARAMS = --diff --check-only
ISORT_PARAMS = --ignore-whitespace $(ALL_SRC_PATHS)

lint:
	isort $(ISORT_PARAMS) $(ISORT_CHECK_PARAMS)
	ruff check $(ALL_SRC_PATHS)
	flake8 $(ALL_SRC_PATHS)
	mypy $(COMMON_SRC_PATHS) --install-types --non-interactive


format:
	ruff check $(ALL_SRC_PATHS) --fix
	isort $(ISORT_PARAMS)
