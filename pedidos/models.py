from django.db import models
from django.core.validators import MinValueValidator  # <- Añade esta línea
from django.utils import timezone  # Añade esta importación

class Categoria(models.Model):
    nombre = models.CharField(max_length=100)

    def __str__(self):
        return self.nombre
    
class Producto(models.Model):
    nombre = models.CharField(max_length=100)
    codigo = models.CharField(max_length=20, unique=True)
    precio = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.01)]
    )
    descripcion = models.TextField()
    imagen = models.ImageField(upload_to='productos/')
    categoria = models.ForeignKey(Categoria, on_delete=models.SET_NULL, null=True)
    
    def __str__(self):
        return self.nombre
    

class Pedido(models.Model):  # Cambiado a singular
    nombre = models.CharField(max_length=100, verbose_name="Nombre del solicitante")
    direccion = models.TextField(verbose_name="Dirección del contacto")
    celular = models.TextField(verbose_name="Telefono de contacto")
    fecha = models.DateTimeField(auto_now_add=True)
    productos = models.ManyToManyField(
        Producto,
        through='PedidoProducto',
        related_name='pedidos'
    )

    def __str__(self):
        return f"Pedido #{self.id} - {self.nombre}"
    
class PedidoProducto(models.Model):
    pedido = models.ForeignKey(Pedido, on_delete=models.CASCADE)
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE)
    cantidad = models.PositiveIntegerField(default=1)  # <- Nuevo campo
    fecha_creacion = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'pedidos_pedido_productos'

