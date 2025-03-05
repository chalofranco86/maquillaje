from django.urls import path
from . import views

urlpatterns = [
    path('crear/', views.crear_pedido, name='crear_pedido'),
    path('seleccionar-productos/<int:pedido_id>/', views.seleccionar_productos, name='seleccionar_productos'),
    path('pedido/<int:pedido_id>/', views.detalle_pedido, name='detalle_pedido'),
    path('exito/', views.exito, name='exito'),
]