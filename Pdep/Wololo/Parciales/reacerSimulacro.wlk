class Contemporaneo inherits Filosofo{
    override method presentate() = "hola"

    override method nivelDeIlumicacion() =  super() * self.coeficioenteDeIluminacion()

    method coeficioenteDeIluminacion() = if(self.amaElPaisaje()) 4 else 1

    method amaElPaisaje() = actividades.contains(admirarElPaisaje)

}

class Filosofo {
    const nombre
    var edad 
    const actividades = []
    const honorificos = #{}
    var nivelDeIlumicacion
    var diasVividos 

    method nivelDeIlumicacion() = nivelDeIlumicacion

    method presentate() = "Nombre: "+nombre + "Honorificos: "+honorificos.join(", ")

    method estaEnLoCorrecto() = nivelDeIlumicacion > 1000

    method hacerActividades() {
      actividades.forEach({actividad => actividad.tarea(self)})
      self.pasarUnDia()
    }

    method bajarIlimincacion(cantidadDeIluminacion){
        nivelDeIlumicacion -= cantidadDeIluminacion
    }

    method aumentarIlimincacion(cantidadDeIluminacion){
        nivelDeIlumicacion -= cantidadDeIluminacion
    }


    method agregarHonorifico(honorifico){
        honorificos.add(honorifico)
    }

    method rejuvenecer(diasRejuvenecidos){
        diasVividos -= diasRejuvenecidos
    }

    method pasarUnDia(){
        diasVividos += 1
        if (diasVividos % 365 == 0){
            edad += 1
            diasVividos = 0
            self.aumentarIlimincacion(10)
        }

        self.esSabio()
    }

    method esSabio(){
        if (edad == 60){
            self.agregarHonorifico("El Sabio")
        }
    }
}

object tomarVino {
    method tarea(filosofo) {
      filosofo.bajarIlimincacion(10)
      filosofo.agregarHonorifico("El Borracho")
    }
}

class JuntarseEnElAgora {
    const otroFilosofo
    method tarea(filosofo){
        filosofo.aumentarIlimincacion(otroFilosofo.nivelDeIlumicacion() * 0.1)
    }
}

object admirarElPaisaje {
    method tarea(_){
        //No hace nada
    }
}

class MeditarBajoUnaCascada {
    const metros
    method tarea(filosofo){
        filosofo.aumentarIlimincacion(metros * 10)
    }
}

class PracticarDeporte {
    method tarea (filosofo){
        filosofo.rejuvenecer(self.cantidadDeDias())
    }

    method cantidadDeDias()
}

object futbol inherits PracticarDeporte{
    override method cantidadDeDias() = 1
}

object polo inherits PracticarDeporte{
    override method cantidadDeDias() = 2
}
object waterPolo inherits PracticarDeporte{
    override method cantidadDeDias() = 2 * polo.cantidadDeDias()
}

class Partido {
    const filosofo
    const argumentos = []

    method estaEnLoCorrecto(){
        const cantidaDeArgumentosCorrectos = argumentos.count({argumento => argumento.esEnriquesedor()})
        return cantidaDeArgumentosCorrectos >= argumentos.size() / 2 and filosofo.estaEnLoCorrecto() 
    }

}

class Discusion {
    const unPartido
    const otroPartido

    method esBuenaDiscusion() = unPartido.estaEnLoCorrecto() and otroPartido.estaEnLoCorrecto()
}


class Argumento {
    const descripcion
    const natruraleza
    const multiplesNaturaleza = #{} // Se tiene que hacer a parte ya que es un tipo de naturaleza especifica osea Naturaleza -> multiplesNaturalezas

    method esEnriquesedor() = natruraleza.cumpleCondicionesDeEnriquesimiento(self)

    method tieneMasDe(cantidaDePlabra) = descripcion.split(" ").size() // ["HOLA", "CHAU", "DESCRIPCION"]

    method terminaEn(letra) = descripcion.split("").last() == letra

    method multiplesNaturalezas() = multiplesNaturaleza.all({naturaleza => natruraleza.cumpleCondicionesDeEnriquesimiento(self)})
}

object estoica {
    method cumpleCondicionesDeEnriquesimiento(_) = true
}

object moralista {
    method cumpleCondicionesDeEnriquesimiento(argumento) = argumento.tieneMasDe(10)
}

object esceptica {
    method cumpleCondicionesDeEnriquesimiento(argumento) = argumento.terminaEn("?")
}

object cinica {
    method cumpleCondicionesDeEnriquesimiento(argumento) {
        const numero = 1.randomUpTo(10)
        return numero <= 3 // 3 de 10 30%
    }  
}

object combinada {
  method cumpleCondicionesDeEnriquesimiento(argumento) = argumento.multiplesNaturalezas()
}