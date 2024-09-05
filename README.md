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

### customize ###

* need to replace recursively `djboiler` with the project's name
todo


### Build the images ### 

Replace every occurence of `djboiler` with the project's name

At least the following need to be adjusted:

You can Use the sh scripts under /bin.

- `./bin/setup-dev.sh`
- `./bin/setup-prod.sh`

### Docker deployment ###

Currently there is no remote deploy script for production.
This should be implemented, since now both environments will
be deployed locally

Use the sh scripts under /bin.

- `./bin/deploy-dev.sh --build`
- `./bin/deploy-prod.sh --build`

__NOTE__: To deploy both dev,prod environments:
```bash
COMPOSE_PROFILES=dev,prod docker compose up
```

Default Location: [http://localhost/](http://localhost/).

### Non docker deployment ###

```bash
$ poetry lock --install
$ fill in an .env
$ ./bin/deploy-dev-native.sh
```

todo

__NOTE__: You can specify the settings module to be used, in runtime, for example:
```bash
$ ./manage.py runserver --settings djboiler.main.settings.local
```

Default location: [http://localhost:8000/](http://localhost:8000/)

## Credits

Bits and peaces "collected" by the following projects:
- https://github.com/skorokithakis/django-project-template