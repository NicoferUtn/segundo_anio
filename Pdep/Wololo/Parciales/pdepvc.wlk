
class Archivo {
    var nombre
    var contenido

    method nombre() = nombre

    method tieneMismoNombre(unNombre) = unNombre == self.nombre() 

    method agregarContenido(candenaTexto) {
        contenido.concat(candenaTexto)
    }
}

class Carpeta {
    var property nombreCarpeta
    const archivos = []

    method agregarArchivo(archivo){
        self.chequearQueEsteElArchivo(archivo)
        archivos.add(archivo)

    }

    method seRepiteEseNombre(nombre) = archivos.any({archivo => archivo.tieneMismoNombre(nombre)})

    method contieneA(archivo) = archivos.contains(archivo)

    method crear(unNombre){
        const nuevoArchivo = new Archivo(nombre = unNombre, contenido = "")
        self.agregarArchivo(nuevoArchivo)
    }

    method eliminar(unNombre){
        self.chequearQueEsteElArchivo(unNombre)
        archivos.remove(self.archivosLLmanados(unNombre))
    }

    method agregar(unNombre, cadenaTexto){
        self.chequearQueEsteElArchivo(unNombre)
        (self.archivosLLmanados(unNombre)).agregarContenido(cadenaTexto)
    }

    method chequearQueEsteElArchivo (unNombre){
        if(self.seRepiteEseNombre(unNombre)){
            throw new Exception(message = "Ya existe el nombre en esta carpteata")
        }
    }

    method archivosLLmanados(unNombre) = archivos.find { archivo => archivo.tieneMismoNombre(unNombre) }

}

class Commit{
    const cambios = []
    const carptea

    method agregarUnCambio(cambio){
        cambios.add(cambio)
    }
}