from django.shortcuts import render, redirect, get_object_or_404
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Image, Spacer
from reportlab.lib.units import cm
from .models import Pedido, Producto, Categoria, PedidoProducto
from .forms import PedidoForm, ProductoForm
from django.db.models import Sum
from django.http import HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from io import BytesIO
from django.contrib.admin.views.decorators import staff_member_required
from django.db.models import F, Sum
from django.contrib import messages
from django.http import HttpResponse

def crear_pedido(request):
    if request.method == 'POST':
        # Obtener datos del formulario
        productos_seleccionados = request.POST.getlist('productos')

        # Crear el pedido
        nuevo_pedido = Pedido.objects.create(
            nombre=request.POST.get('nombre'),
            direccion=request.POST.get('direccion'),
            celular=request.POST.get('celular')
        )

        # Procesar productos y cantidades
        for producto_id in productos_seleccionados:
            cantidad = request.POST.get(f'cantidad_{producto_id}', 1)

            # Crear relación en PedidoProducto
            PedidoProducto.objects.create(
                pedido=nuevo_pedido,
                producto_id=producto_id,
                cantidad=cantidad
            )

        return redirect('seleccionar_productos', pedido_id=nuevo_pedido.id)

    # Código para GET: Mostrar formulario inicial de datos del cliente
    form = PedidoForm()
    return render(request, 'pedidos/crear_pedido.html', {'form': form})

def exito(request):
    return render(request, 'pedidos/exito.html')  # Página simple de éxito

def seleccionar_productos(request, pedido_id):
    pedido = get_object_or_404(Pedido, pk=pedido_id)

    if request.method == 'POST':
        # Eliminar relaciones anteriores para evitar duplicados
        PedidoProducto.objects.filter(pedido=pedido).delete()
        
        productos_seleccionados = request.POST.getlist('productos')
        for producto_id in productos_seleccionados:
            cantidad = int(request.POST.get(f'cantidad_{producto_id}', 1))
            PedidoProducto.objects.create(
                pedido=pedido,
                producto_id=producto_id,
                cantidad=cantidad
            )
        return redirect('detalle_pedido', pedido_id=pedido.id)  # Redirigir al detalle

    # Código para GET
    productos = Producto.objects.all()
    categorias = Categoria.objects.all()

    # Aplicar filtros
    nombre = request.GET.get('nombre')
    categoria_id = request.GET.get('categoria')
    precio_min = request.GET.get('precio_min')
    precio_max = request.GET.get('precio_max')

    if nombre:
        productos = productos.filter(nombre__icontains=nombre)
    if categoria_id:
        productos = productos.filter(categoria_id=categoria_id)
    if precio_min:
        productos = productos.filter(precio__gte=precio_min)
    if precio_max:
        productos = productos.filter(precio__lte=precio_max)

    return render(request, 'pedidos/seleccionar_productos.html', {
        'pedido': pedido,
        'productos': productos,
        'categorias': categorias
    })

def detalle_pedido(request, pedido_id):
    pedido = get_object_or_404(Pedido, pk=pedido_id)
    # Obtener las relaciones intermedias con las cantidades
    relaciones = PedidoProducto.objects.filter(pedido=pedido).select_related('producto')
    total = sum(relacion.producto.precio * relacion.cantidad for relacion in relaciones)
    
    if request.GET.get('descargar'):
        return generar_pdf(pedido, [rel.producto for rel in relaciones], total)
    
    return render(request, 'pedidos/detalle_pedido.html', {
        'pedido': pedido,
        'relaciones': relaciones,  # <- Cambiar a relaciones
        'total': total
    })

def generar_pdf(pedido, productos, total):
    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=letter, rightMargin=72, leftMargin=72,
                            topMargin=72, bottomMargin=72)

    # Estilos actualizados
    styles = getSampleStyleSheet()
    styleB = ParagraphStyle('Bold', parent=styles["BodyText"], fontName='Helvetica-Bold')
    styleH = ParagraphStyle('Heading1', parent=styles["Heading1"],
                          fontName='Helvetica-Bold',
                          fontSize=14,
                          alignment=1,
                          spaceAfter=14)

    elements = []

    # Encabezado estructurado
    header_data = [
        ["MayMakeup GT", "Pedido #{}".format(pedido.id)],
        ["Tel: (502) 1234-5678", "Fecha: {}".format(pedido.fecha.strftime("%d/%m/%Y %H:%M"))],
        ["Instagram: MayMakeup GT", "Cliente: {}".format(pedido.nombre)]
    ]

    header_table = Table(header_data, colWidths=[10*cm, 6*cm])
    header_table.setStyle(TableStyle([
        ('ALIGN', (0,0), (-1,-1), 'LEFT'),
        ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,-1), 10),
        ('BOTTOMPADDING', (0,0), (-1,-1), 6),
        ('BACKGROUND', (1,0), (1,0), colors.HexColor("#FF7EB3")),
        ('TEXTCOLOR', (1,0), (1,0), colors.white),
    ]))
    elements.append(header_table)
    elements.append(Spacer(1, 24))

    # Detalle de productos con numeración
    elementos_tabla = [
        [
            Paragraph("<b>#</b>", styleB),
            Paragraph("<b>Producto</b>", styleB),
            Paragraph("<b>Código</b>", styleB),
            Paragraph("<b>Cantidad</b>", styleB),
            Paragraph("<b>P. Unitario</b>", styleB),
            Paragraph("<b>Subtotal</b>", styleB)
        ]
    ]

    relaciones = pedido.productos.through.objects.filter(pedido=pedido).select_related('producto')

    for index, relacion in enumerate(relaciones, start=1):
        producto = relacion.producto
        subtotal = producto.precio * relacion.cantidad
        elementos_tabla.append([
            str(index),
            producto.nombre,
            producto.codigo,
            str(relacion.cantidad),
            f"Q{producto.precio:.2f}",
            f"Q{subtotal:.2f}"
        ])

    tabla = Table(elementos_tabla,
                colWidths=[1*cm, 2*cm, 8*cm, 3*cm, 3*cm],
                repeatRows=1)

    tabla.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.HexColor("#D96C8F")),
        ('TEXTCOLOR', (0,0), (-1,0), colors.white),
        ('ALIGN', (0,0), (-1,-1), 'CENTER'),
        ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,-1), 9),
        ('BOTTOMPADDING', (0,0), (-1,0), 12),
        ('BACKGROUND', (0,1), (-1,-1), colors.white),
        ('GRID', (0,0), (-1,-1), 0.5, colors.lightgrey),
        ('VALIGN', (0,0), (-1,-1), 'MIDDLE'),
    ]))

    elements.append(tabla)

    # Total con formato mejorado
    total_data = [
        [Paragraph("<b>TOTAL:</b>", styleB), "", "", f"Q{total:.2f}"]
    ]
    total_table = Table(total_data, colWidths=[1*cm, 2*cm, 8*cm, 3*cm])
    total_table.setStyle(TableStyle([
        ('ALIGN', (-1,-1), (-1,-1), 'RIGHT'),
        ('FONTSIZE', (0,0), (-1,-1), 12),
        ('TEXTCOLOR', (0,0), (-1,-1), colors.HexColor("#D96C8F")),
        ('LINEABOVE', (0,0), (-1,0), 1, colors.HexColor("#FF7EB3")),
    ]))
    elements.append(total_table)

    # Generar PDF
    doc.build(elements)

    buffer.seek(0)
    response = HttpResponse(buffer, content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="pedido_{pedido.id}.pdf"'
    return response

@staff_member_required
def lista_pedidos_admin(request):
    pedidos = Pedido.objects.annotate(
        total=Sum(F('pedidoproducto__cantidad') * F('pedidoproducto__producto__precio'))
    ).order_by('-fecha')
    
    return render(request, 'pedidos/admin/lista_pedidos.html', {
        'pedidos': pedidos
    })

@staff_member_required
def gestionar_productos(request):
    productos = Producto.objects.all().order_by('-id')
    
    if request.method == 'POST':
        form = ProductoForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, '✅ Producto creado exitosamente')
            return redirect('gestion_productos')
        else:
            messages.error(request, '❌ Error en el formulario. Revise los datos.')
    else:
        form = ProductoForm()

    return render(request, 'pedidos/admin/gestion_productos.html', {
        'productos': productos,
        'form': form
    })

def home(request):
    return HttpResponse("¡Hola, mundo!")
