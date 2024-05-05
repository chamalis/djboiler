#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import site
import sys
import pathlib


def main():
    # add source root of django apps into sys.path if not already
    src_root = str(pathlib.Path(__file__).parent.joinpath("djboiler"))
    site.addsitedir(src_root)

    # default settings file. This is overriden by bin/run-prod.sh for production
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djboiler.main.settings.dev")

    # start the django app
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == "__main__":
    main()
