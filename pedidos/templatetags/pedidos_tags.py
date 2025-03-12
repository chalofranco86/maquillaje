from django import template

register = template.Library()

@register.filter
def sum_total(relaciones):
    return sum(rel.producto.precio * rel.cantidad for rel in relaciones)