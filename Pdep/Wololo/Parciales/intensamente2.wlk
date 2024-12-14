object riley {
    var felicidad = 1000
    var emocionDominante = alegria
    var recuerdoDelDia = []
    const pensamientoCentral = #{}
    const procesosMentales = [] //Se van a usar todos mietntras duemen creo
    const memoriaLargoPlazo = []
    const edad = 11

    method felicidad() = felicidad

    method cambiarEmocionDominante(emocion) {
        emocionDominante = emocion
    }

    method vivirUnEvento(descripcionDeEvento) {
        const recuerdo = new Recuerdo(descpicion = descripcionDeEvento, fecha = "10/11/2024", emocionDominanteDeRiley = emocionDominante, persona = self)
        recuerdoDelDia.add(recuerdo) //Agregamos el Recuerdo a los del dia
    }

    method agregarPensamientoCentral(recuerdo){
        pensamientoCentral.add(recuerdo)
    }

    method disminuirFelicidadUn (porcentaje){
        felicidad = 1.max(felicidad * porcentaje)
    }

    method ultimosRecuedo(cantidadDeRecuedos){
        recuerdoDelDia.reverse().take(cantidadDeRecuedos)
    }

    method conocerPensamientoCentrales(){
        return pensamientoCentral.forEach({recuerdo => recuerdo.emocionDominanteDeRiley()})
    }

    method recuedoDificiles() {
      return pensamientoCentral.filter({recuedo => recuedo.esDificil()})
    }

    method negarRecuedor(recuedo) = pensamientoCentral.negarUNRecuedo(recuedo)

    method dormir(){
        procesosMentales.forEach({proceso => proceso.aplciarEfecto(self)})
    }
    method asentarRecuerdos(recuerdoAAsentar){
        recuerdoAAsentar.forEach({recuedo => recuedo.asentarRecuerdo()})
    }

    method asentarTodosLosReceurdos(){
        self.asentarRecuerdos(recuerdoDelDia)
    }


    method asentarSelectivamenteLosReceurdos(parlabraClave) {
      const recuerdoAAsentar = recuerdoDelDia.filter({recuerdo => recuerdo.contieneLa(parlabraClave)})
      self.asentarRecuerdos(recuerdoAAsentar)
    }

    method asentarALargoPlazo() {
      const recuerdoLargoPlazo = recuerdoDelDia.filter({recuedo => (!self.negarRecuedor(recuedo) and !pensamientoCentral.contains(recuedo))})
      self.agregarAMemoriaLargoPlazo(recuerdoLargoPlazo)
    }

    method agregarAMemoriaLargoPlazo(recuedoLargoPlazo){
        memoriaLargoPlazo.union(recuedoLargoPlazo)
    }

    method deiquilibrioHormonal() {
        if(self.largoPlazoEnPensamientoCentral() || self.recuerdoDiaMismaEmocion())
            self.disminuirFelicidadUn(0.85)
            self.perderPensamientosAntiguis(3)
    } 

    method perderPensamientosAntiguis(cantidad){
        pensamientoCentral.drop(cantidad) // Ta de mas viejo a mas nuevo 
    }

    method largoPlazoEnPensamientoCentral() {
        const interseccionPensamientos = pensamientoCentral.interction(memoriaLargoPlazo)
        return pensamientoCentral == interseccionPensamientos
    }

    method recuerdoDiaMismaEmocion(){
        const priemerRecuedo = recuerdoDelDia.take(1)
        return recuerdoDelDia.all({recuerdo => recuerdo.concidePensamiento(priemerRecuedo)})
    }

    method restaurarFelicidad(cantidad){
        felicidad = 1000.min(cantidad + felicidad)
    }

    method liberarRecuerdo(){
        recuerdoDelDia = [] //Se vacia la lista
    }

    method recordadRecurdo(){
        const recuerdoQueCumplanCondicon = memoriaLargoPlazo.filter({recuerdo => recuerdo.cumpleRequisitoEdad(edad/2)})
    }

}

object asentamiento {
  method aplciarEfecto(persona){
    persona.asentarTodosLosReceurdos()
  }
}

class AsentamientoSelectivo {
const parlabraClave
 
  method aplciarEfecto(persona){
    persona.asentarSelectivamenteLosReceurdos(parlabraClave)
  }
}

object profundizacion {
    method aplciarEfecto(persona){
        persona.asentarALargoPlazo()
    }
}

object controlhormonal{
    method aplciarEfecto(persona){
        persona.deiquilibrioHormonal()
    }    
}

object restrauracionCognitiva{
    method aplciarEfecto(persona){
        persona.restaurarFelicidad(100)
    }
}

object liberacionDeRecursosDelDia{
    method aplciarEfecto(persona){
        persona.liberarRecuerdo()
    }
}


class Recuerdo{
    const descpicion
    const fecha
    const emocionDominanteDeRiley = #{}
    const persona

    method emocionDominanteDeRiley() = emocionDominanteDeRiley

    method asentarRecuerdo(){
        emocionDominanteDeRiley.forEach({emocion => emocion.asentar(self, persona)})
    }

    method esDificil() = descpicion.words().size() > 10 

    method contieneLa(palabra) = descpicion.contains(palabra)

    method concidePensamiento(recuedo) = recuedo.emocionDominanteDeRiley() == emocionDominanteDeRiley

    method cumpleRequisitoEdad(edad) = fecha.year() > edad //Noc si esta bien pero yo confio 

    method negarUNRecuedo(recuedo) = emocionDominanteDeRiley.all({emocion => emocion.negar(recuedo)})

    method esAlegre() {
      emocionDominanteDeRiley.contains(alegria)
    }

}


object alegria {
    method asentar(recuerdo, persona) {
        if(persona.felicidad() >= 500)
            persona.agregarPensamientoCentral(recuerdo)
    }

    method negar(recuedo) = self == recuedo.emocionDominanteDeRiley()
}

object triste {
    method asentar(recuerdo, persona) {
        persona.agregarPensamientoCentral(recuerdo)
        persona.disminuirFelicidadUn(0,9)
    }

    method negar(recuedo) = alegria != recuedo.emocionDominanteDeRiley()
}
object disgusto {
     method asentar(recuerdo, persona) {}
     method negar(recuedo) = false
}
object furioso {
     method asentar(recuerdo, persona) {}
     method negar(recuedo) = false
}

object termeroso {
     method asentar(recuerdo, persona) {}
     method negar(recuedo) = false
}