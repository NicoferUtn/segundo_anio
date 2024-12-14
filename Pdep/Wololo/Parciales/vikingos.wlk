// Castas sociales jarl(Esclavos) || Karl (Casta Media) || Thrall (Nobles)
// los vikingos puede ser Soldados || Granejros 
//Ser PRODUCTIVO : matar 20 personas y tener armas -> Soldados
// Ser PRODUCTIVO: 2 hectarias x hijo -> Granjeros

// Expedicion :: Esclavos -> No puede ir con armas
// Las expedicioenes valen la pena cuando toda la aldea y captial(3 monesda de oro x vikingo) estan involucrados 
// Botin tantas monedas de oro como defesnores derrotados 
//Invadir aldeas >15 monedas de oro (Se calcula con la cantida de crucifijos)

//Asender en la clases sociales 
// Esclavo -> Casta Media -> Soldados :: 10 armas 
//                        -> Granjeros :: 2 hijos 2 hectarias 


class Vikingo {
    var property estatusSocial
    var oro

    method puedeSubirA(expedicion)  = self.esProductivo() and estatusSocial.puedeIr(self, expedicion)

    method aumentarOro(cantidad){
        oro += cantidad
    } 

    method esProductivo()

    method acenderSocialmente() {
        estatusSocial.acenderSocialmente(self)
    }
}

class Soldado inherits Vikingo {
    var armas 
    var asesinatos

    override method esProductivo() = asesinatos > 20 and self.tieneArmas()

    method tieneArmas() = armas > 0

        method acender() {
        armas += 10 
    }
}

class Granjeros inherits Vikingo {
    var hijos
    var hectarias

    override method esProductivo() = hectarias * 2 >= hijos 

    method tieneArmas() = false 

    method acender() {
        hijos += 2
        hectarias += 2
    }

}

class Clases {
    method puedeIr(vikingo, expedicion) = true
}

object jarl inherits Clases {
    override method puedeIr(vikingo, expedicion) = not vikingo.tieneArmas()

    method acenderSocialmente(vikingo) {
        vikingo.estusSocial(karl)
        vikingo.acender()
    }
}

object karl inherits Clases {
    method acenderSocialmente(vikingo) {
        throw new Exception(message = "Cuanto queres escalar PA") // Manjeo de errores
    }

}

object thrall inherits Clases {
        method acenderSocialmente(vikingo) {
        
    }
}

class Expediciones {
    var integrantes = #{}
    var objetivos = #{}
    
    method subir(vikingo) {
        if(vikingo.puedeSubirA(self)){
            integrantes.add(vikingo)
        }else {
            throw new Exception(message = "No pudo subir a la expedicion") // Manjeo de errores
        }
    }

    method valeLaPena()  = objetivos.all({objetivo => objetivo.valeLaPena(self.cantidadDeInvasores())})

    method cantidadDeInvasores() = integrantes.size()

    method invadir() {
        objetivos.forEach({objetivo => objetivo.serInvadidos(self)})
    }

    method repartirLoot(cantidad) {
        integrantes.forEach({integrante => integrante.aumentarOro(cantidad / self.cantidadDeInvasores())})
    }
}

class Lugar {
    method serInvadidos(expedicion){
        expedicion.repartirLoot(self.loot(expedicion.cantidadDeInvasores()))
        self.destruir(expedicion.cantidadDeInvasores())
    } 
    method loot(cantidadDeAtacantes)
    method destruir(cantidadDeAtacantes)   
}
class Aldeas inherits Lugar{
    var cantidadDeCruzifijos

    method valeLaPena(cantidadDeAtacantes) = self.loot(cantidadDeAtacantes) >= 15

    override method loot(cantidadDeAtacantes) = cantidadDeCruzifijos

    override method destruir(_) {
        cantidadDeCruzifijos = 0
    }
}

class Capitales inherits Lugar{
    var cantidadDeDefensores
    var riqueza

    method valeLaPena(cantidadDeAtacantes) = 3 * cantidadDeAtacantes <= self.loot(cantidadDeAtacantes)

    method defensoresDerrotados(cantidadDeAtacantes) =  cantidadDeAtacantes.min(cantidadDeDefensores)

    override method loot(cantidadDeAtacantes) = self.defensoresDerrotados(cantidadDeAtacantes) * riqueza

    override method destruir(cantidadDeAtacantes) {
        cantidadDeDefensores -= self.defensoresDerrotados(cantidadDeAtacantes)
    }
}




