from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from djangoql.admin import DjangoQLSearchMixin

from .models import User

admin.site.register(User, UserAdmin)


# @admin.register(User)
# class UserAdmin(DjangoQLSearchMixin, admin.ModelAdmin):
#     list_display = ["created_at", "updated_at"]
#     list_filter = ("created_at",)
