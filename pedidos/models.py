from django.db import models
from django.core.validators import MinValueValidator  # <- Añade esta línea

class pedidos(models.Model):
    nombre = models.CharField(max_length=100, verbose_name="Nombre del solicitante")
    direccion = models.TextField(verbose_name="Dirección del contacto")
    celular = models.TextField(verbose_name="Telefono de contacto")

    def __str__(self):
        return f"Solicitud de {self.nombre}"

class Categoria(models.Model):
    nombre = models.CharField(max_length=100)

    def __str__(self):
        return self.nombre

class Producto(models.Model):
    pedido = models.ForeignKey(pedidos, on_delete=models.CASCADE, related_name='productos')  # Relación con pedido
    nombre = models.CharField(max_length=100)
    codigo = models.CharField(max_length=20, unique=True)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    descripcion = models.TextField()
    imagen = models.ImageField(
        upload_to='productos/',  # Carpeta donde se guardarán las imágenes
        verbose_name="Imagen del producto"
    )
    categoria = models.ForeignKey(Categoria, on_delete=models.SET_NULL, null=True)
    precio = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.01)]  # Asegura precios positivos
    )

    def __str__(self):
        return self.nombre