from django.apps import AppConfig


class MainConfig(AppConfig):
    name = "app_x"

    def ready(self):
        pass
