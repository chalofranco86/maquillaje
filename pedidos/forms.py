from django import forms
from .models import Pedido, Producto, Categoria

class PedidoForm(forms.ModelForm):
    class Meta:
        model = Pedido
        fields = ['nombre', 'celular', 'direccion']  # Campos que se mostrarán en el formulario

class ProductoForm(forms.ModelForm):
    categorias = forms.ModelChoiceField(queryset=Categoria.objects.all())

    class Meta:
        model = Producto
        fields = ['nombre', 'codigo', 'precio', 'descripcion', 'imagen', 'categoria']
