from django.contrib import admin
from .models import CustomUser


class CustomUserAdmin(admin.ModelAdmin):
    model = CustomUser
    list_display = ['id','username', 'email', 'avatar', 'is_staff', 'is_active', 'date_joined']
    search_fields = ['id','username', 'email']
admin.site.register(CustomUser, CustomUserAdmin)