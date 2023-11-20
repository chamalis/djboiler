from pathlib import Path

from main.settings.dev import BASE_DIR


def path(*x):
    """Build internal paths"""
    return Path(BASE_DIR).joinpath(*x)
