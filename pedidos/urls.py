from django.contrib import admin
from django.urls import path, include
from django.views.generic import RedirectView
from django.contrib.auth import views as auth_views
from .views import lista_pedidos_admin, gestionar_productos
from . import views

urlpatterns = [
    path('', RedirectView.as_view(url='crear/', permanent=False), name='home'),
    path('crear/', views.crear_pedido, name='crear_pedido'),
    path('seleccionar-productos/<int:pedido_id>/', views.seleccionar_productos, name='seleccionar_productos'),
    path('pedido/<int:pedido_id>/', views.detalle_pedido, name='detalle_pedido'),
    path('exito/', views.exito, name='exito'),
    path('admin/pedidos/', views.lista_pedidos_admin, name='lista_pedidos_admin'),
    path('admin/productos/', gestionar_productos, name='gestion_productos'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('accounts/', include('django.contrib.auth.urls')),  # Añade esta línea
]