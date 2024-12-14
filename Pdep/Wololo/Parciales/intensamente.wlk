
object riley {
    var felicidad = 1000
    var emocionDominante = alegria
    const recuerdos = []
    const pensamientoCentral = #{}
    const property procesoMentales = [] 
    const memoriaLargoPlazo = []

    method felicidad() = felicidad

    method cambiarEmocionDominante(emocion) {
        emocionDominante = emocion
    }

    method emocionDominante() = emocionDominante

    method vivirUnEvento(descripcionDelRecuerdo) {
        const recuerdo = new Recuerdo(emocionDominanteRecuerdo = emocionDominante, fecha = "09/11/2024", descripcion = descripcionDelRecuerdo, persona = self)
        self.asentarEvento(recuerdo)
    }

    method asentarEvento(recuerdo){
        recuerdos.add(recuerdo)
    }

    method agregarPensamientoCentral(pensamiento){
        pensamientoCentral.add(pensamiento)
    }

    method cambiarFelicidadPorcentualmente(porcentaje){
        felicidad *= porcentaje
        if(felicidad < 1)
            throw new Exception(message = "Riley su felicida bajo a menos de 1") 
    }

    method ultimosRecuerdosCincoRecuerdos() {
        const ultimosReceurdos = recuerdos.reverse().take(5) //Agarro los ultimos 5 recuerdos
        return ultimosReceurdos.forEach({recuerdo => recuerdo.emocionDominante()}) //A chequear si esta bien
    }

    method pensamientosParticulares() = pensamientoCentral

    method pensamientoCentralesDificiles(){
        return pensamientoCentral.filter({pensamiento => pensamiento.tieneMasDe(10)})
    }

    method negarPensamientos(recuerdo) = emocionDominante.esNegable(recuerdo)

    method dormir(){
        procesoMentales.forEach({proceso => proceso.aplicarProceso(self)})
    }

    method asentarTodoRecuerdoDelDia(recuerdosFiltrados) {
        recuerdosFiltrados.forEach({recuerdo => recuerdo.asentar()})
    } 
    method asentarRecuerdoDelDia() {
        self.asentarTodoRecuerdoDelDia(recuerdos)
    }

    method asentarPorPalabraClave(palabraClave) {
const recuerdoQueSePuedeAsentar = recuerdos.filter({recuerdo => recuerdo.tienepalabra(palabraClave)})
      self.asentarTodoRecuerdoDelDia(recuerdoQueSePuedeAsentar)
    }

}

object asentamiento {
  method aplicarProceso(persona) {
    persona.asentarRecuerdoDelDia()
  }
}

class AsentamientoSelectivo {
const palabra
    method aplicarProceso(persona) {
    persona.asentarPorPalabraClave(palabra)
    }
}




class Recuerdo {
    const emocionDominanteRecuerdo
    const descripcion
    const fecha //Noc par aque sirvce jejej
    const persona

    method asentar(){
        emocionDominanteRecuerdo.asentarRecuerdo(self, persona)
    }

    method emocionDominanteRecuerdo() = emocionDominanteRecuerdo

    method tieneMasDe(cantidaDeLetras) = descripcion.words().size() >= cantidaDeLetras

    method recuerdo(palabraClave) = descripcion.concat(palabraClave)


}

object alegria {
    method asentarRecuerdo(recuerdo,persona) {
      if(persona.felicidad() >= 500)
        persona.cambiarEmocionDominante(recuerdo)
    }

    method esNegable(recuerdo) = recuerdo.emocionDominanteRecuerdo() != self


}

object trieste {
  method asentarRecuerdo(recuerdo, persona){
    persona.cambiarEmocionDominante(recuerdo)
    persona.cambiarFelicidadPorcentualmente(0.9)
  }

      method esNegable(recuerdo) = recuerdo.emocionDominanteRecuerdo() == alegria
}

object disgusto{
    method asentarRecuerdo(){}
    method esNegable(_) = false
}
object furioso{
    method asentarRecuerdo(){}
    method esNegable(_) = false
}
object temeroso{
    method asentarRecuerdo(){}
    method esNegable(_) = false
}