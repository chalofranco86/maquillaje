from django.contrib import admin

from .models import Categoria, Producto  # Importa tus modelos

# Registra los modelos para que aparezcan en el admin
admin.site.register(Categoria)
admin.site.register(Producto)
# Register your models here.
