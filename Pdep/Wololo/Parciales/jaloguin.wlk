
//Sustos
class Ninio {
    const elementos = #{}
    var bolsaDeCaramelos
    var property actitudaDeNinio

    method capacidadDeAustar() =  self.cantidadDeObjetos() * actitudaDeNinio
    method cantidadDeObjetos() = elementos.sum({elemento => elemento.asustacion()})

    method recibirCaramelos(cantidadDeCaramelos) {
        bolsaDeCaramelos += cantidadDeCaramelos
    }
    method caramelos() =  bolsaDeCaramelos
}

class Elemento {
    const property asustacion 
}

object maqullaje inherits Elemento(asustacion = 3) {}
object tiernos inherits Elemento(asustacion = 2) {}
object terrorificos inherits Elemento(asustacion = 5) {}


class Adulto {
    var cantidadDeSustos = 0 //Deduszo que arranca en 0 la tolerancia
    var property esNecio

    method tolerancia() = 10 * cantidadDeSustos  

    method asustar(ninio) {
        if (self.tolerancia() < ninio.capacidadDeAustar() and !esNecio){
            ninio.recibirCaramelos(self.cantidadDeCaramelos())
            cantidadDeSustos += 1
        }
    }

    method asustarLegion(grupo) {
        if(self.tolerancia() < grupo.capacidadDeAsustacionDeLegion() and !esNecio){
            grupo.repartirCaramelos(self.cantidadDeCaramelos())
            cantidadDeSustos += 1
        }
    }

    method cantidadDeCaramelos() = self.tolerancia() / 2 + 15
}

class Abuelo inherits Adulto{
    override method asustar(ninio){
        ninio.recibirCaramelos(self.cantidadDeCaramelos() / 2)
    }

    override method asustarLegion(grupo){
        grupo.repartirCaramelos(self.cantidadDeCaramelos() / 2)
    }
}


//Legiones
class LegionesDeTerror {
    const ninios  = #{}

    method initialize(){
    if (ninios.size() < 2)
      throw new DomainException(message = "Al menos debe tener 2 miembros la legion de terror")
    }

    method capacidadDeAsustacionDeLegion() = ninios.sum({ninio => ninio.capacidadDeAustar()})
    method cantidadDeCaramelosTotales() = ninios.sum({ninio => ninio.caramelos()})

    method repartirCaramelos(cantidadDeCaramelos) { 
        self.lider().recibirCaramelos(cantidadDeCaramelos)
    }

    method lider() = ninios.flaten().max({ninio => ninio.capacidadDeAustar()})    
}