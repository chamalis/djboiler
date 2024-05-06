COMMON_LINT_PATHS = djboiler/ manage.py
ALL_LINT_PATHS = $(COMMON_LINT_PATHS)
ISORT_PARAMS = --ignore-whitespace $(ALL_LINT_PATHS)
ISORT_CHECK_PARAMS = --diff --check-only

lint:
	isort $(ISORT_PARAMS) $(ISORT_CHECK_PARAMS)
	ruff check $(ALL_LINT_PATHS)
	flake8 $(ALL_LINT_PATHS)
	mypy $(COMMON_LINT_PATHS) --install-types --non-interactive


format:
	ruff check $(ALL_LINT_PATHS) --fix
	isort $(ISORT_PARAMS)
