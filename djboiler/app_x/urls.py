"""The app_x application's URLs."""
from django.urls import path

from . import views

app_name = "app_x"
urlpatterns = [
    path("", views.index, name="index")
]
