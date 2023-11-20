# Django project template

This is a simple Django 4.0+ project template with my preferred setup. The idea
is to have several branches per feature that may be needed for some projects but
not for others.

## Tech stack

Runs under docker-compose by default, with PostgreSQL 
and Redis used as cache and session backend, and nginx
as webserver.

todo 

## Setup

Replace every occurence of `djboiler` with the project's name

The following need to be adjusted:

* Run `poetry lock` to pin the packages to the latest versions.
* Change this README.
* Add the domain in `settings.py`'s `ALLOWED_HOSTS`.
* Create and customize an `.env` file, with django secret etc

### Docker deployment ###

```bash
$ docker-compose up --build
```

Default Location: [http://localhost/](http://localhost/).

### Non docker deployment ###

```bash
$ poetry install
$ ./manage.py makemigrations && ./manage.py migrate
$ ./manage.py runserver
```

Default location: [http://localhost:8000/](http://localhost:8000/)

## Credits

Bits and peaces "collected" by the following projects:
- https://github.com/skorokithakis/django-project-template