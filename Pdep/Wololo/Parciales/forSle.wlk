//Comision = Meses * Valor de inmueble / 50000 -> Alquileres
//Comision = 0.015 * valor de inmueble -> Venta 

class Inmueble {
    var metrosCuadrados 
    var cantidadDeAmbientes
    var tipoDeImueble
    var operacion //Venta o alquiler
    const zona //Valor de la zona


    method valor() = self.valorDeInmueble() + zona.valor()
    method valorDeInmueble()
}

class Zona {
    var property valor 
}


class Casa inherits Inmueble{
    const precio

    override method valorDeInmueble() = precio
}

class PH inherits Inmueble {
    const precioMinimo = 500000

    override method valorDeInmueble() =  precioMinimo.max(metrosCuadrados * 14000)
}

class Departamente inherits Inmueble {
    override method valorDeInmueble() = cantidadDeAmbientes * 350000 
}

class Inmobiliaria {
    var property  pocentajeDeVenta // debe ser 1.5% pero cambia todos los años

    
}