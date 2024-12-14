class Silla {
    var estaReservada = false
    var estaVendida = false

    // Método para reservar una silla
    method reservar() {
        estaReservada = true
    }

    // Método para vender una silla
    method vender() {
        if (!estaReservada) {
            estaVendida = true
        }
    }
}

class Mesa {
    var estaReservada = false
    var estaVendida = false

    // Método para reservar una mesa
    method reservar() {
        estaReservada = true
    }

    // Método para vender una mesa
    method vender() {
        if (!estaReservada) {
            estaVendida = true
        }
    }
}

class Venta {
    var articulo
    var cuotas = 1
    var descuento = 0

    // Método para asignar el artículo que se venderá
    method asignarArticulo(articuloAAsignar) {
        articulo = articuloAAsignar
    }

    // Método para establecer las condiciones de la venta
    method establecerCondiciones(nroCuotas, porcentajeDescuento) {
        cuotas = nroCuotas
        descuento = porcentajeDescuento
    }

    // Método para realizar la venta del artículo
    method realizarVenta() {
        if (articulo != null) {
            articulo.vender()
        }
    }
}
