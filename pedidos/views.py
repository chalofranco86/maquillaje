from django.shortcuts import render, redirect, get_object_or_404
from reportlab.pdfgen import canvas
from .models import pedidos, Producto, Categoria
from .forms import PedidoForm, ProductoForm
from django.db.models import Sum
from django.http import HttpResponse
from io import BytesIO

def crear_pedido(request):
    if request.method == 'POST':
        form = PedidoForm(request.POST)
        if form.is_valid():
            pedido = form.save()  # Guarda el pedido
            request.session['last_pedido_id'] = pedido.id  # Guarda el ID en la sesión
            return redirect('seleccionar_productos', pedido_id=pedido.id)  # Redirige a selección de productos
    else:
        form = PedidoForm()
    return render(request, 'pedidos/crear_pedido.html', {'form': form})

def exito(request):
    return render(request, 'pedidos/exito.html')  # Página simple de éxito

def seleccionar_productos(request, pedido_id):
    pedido = get_object_or_404(pedidos, pk=pedido_id)
    productos = Producto.objects.all()
    categorias = Categoria.objects.all()

    # Filtros
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
    pedido = get_object_or_404(pedidos, pk=pedido_id)
    productos = pedido.productos.all()
    total = productos.aggregate(total=Sum('precio'))['total'] or 0

    # Verificar si se solicita descarga
    if request.GET.get('descargar'):
        return generar_pdf(pedido, productos, total)

    return render(request, 'pedidos/detalle_pedido.html', {
        'pedido': pedido,
        'productos': productos,
        'total': total
    })

def generar_pdf(pedido, productos, total):
    buffer = BytesIO()
    pdf = canvas.Canvas(buffer)

    # Configuración del PDF
    pdf.setTitle(f"Pedido #{pedido.id}")
    pdf.setFont("Helvetica-Bold", 16)
    
    # Encabezado
    pdf.drawString(100, 800, f"Detalle del Pedido #{pedido.id}")
    pdf.setFont("Helvetica", 12)
    
    # Datos del cliente
    y = 750
    pdf.drawString(100, y, f"Cliente: {pedido.nombre}")
    y -= 30
    pdf.drawString(100, y, f"Dirección: {pedido.direccion}")
    y -= 30
    pdf.drawString(100, y, f"Teléfono: {pedido.celular}")
    y -= 50

    # Productos
    pdf.setFont("Helvetica-Bold", 14)
    pdf.drawString(100, y, "Productos solicitados:")
    y -= 30
    pdf.setFont("Helvetica", 12)
    
    for producto in productos:
        pdf.drawString(120, y, f"- {producto.nombre} ({producto.codigo})")
        pdf.drawString(400, y, f"${producto.precio}")
        y -= 20

    # Total
    pdf.setFont("Helvetica-Bold", 14)
    pdf.drawString(100, y-30, f"Total: ${total}")

    pdf.showPage()
    pdf.save()
    
    buffer.seek(0)
    response = HttpResponse(buffer, content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="pedido_{pedido.id}.pdf"'
    return response