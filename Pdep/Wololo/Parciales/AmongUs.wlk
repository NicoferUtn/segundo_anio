//Arranco a las 11:37
import objetosAmongUs.*

class Jugador {
    const colorMochila
    const mochila = [] // Al usar un item se remueve de la mochila
    var nivelDeSospecha = 40
    
    var votaEnBlanco 
    var estaEnLaNave
    const presonalidad

    method impugnarElVotoAlJugador() {
        votaEnBlanco = true
    }

    method mochiVacia()  = mochila.isEmpty()

    method nivelDeSospecha() = nivelDeSospecha
    method estajugando() = estaEnLaNave

    method esSosteposo()  = nivelDeSospecha >= 50

    method aumentarNivelDeSospecha(nivel) {
        nivelDeSospecha += nivel
    }

    method disminuirNivelDeSospecha(nivel) {
        nivelDeSospecha -= nivel
    }

    method buscarUnItem(item) {
        mochila.add(item)
    }

    method tieneUn(item) = mochila.contein(item)

    method removerItem(item) {
        mochila.remove(item)
    }

    method llamarAReunionDeEmergencia() {
        nave.reunionDeEmergencia()
    }

    method voto() {
    if(!votaEnBlanco){
        return presonalidad.votar()
    }else{
        return votoEnBlanco
    }
    }

    method expulsarDeLaNave(){
        estaEnLaNave = false
        self.notificarAlaNaveDelCaido()
    }

    method notificarAlaNaveDelCaido()
    method terminoSusTareas()
    method hacerTarea()
}



class Impostor inherits Jugador{


    override method hacerTarea(){}
    override method terminoSusTareas() = true

    method realizarSabotajes(unSabotaje) {
        self.aumentarNivelDeSospecha(5)
        unSabotaje.realizarMaldad()
    }

    override method notificarAlaNaveDelCaido(){
        nave.sacarUnImpostor()
    }

}

object reducirOxigeno {
  method realizarMaldad() {
    if(!nave.alguienTieneUn(tuboOxigeno))
        nave.reducirOxigeno(10)
  }
}

object impugnarAUnJugador {
    method realizarMaldad() {
      nave.impugnarAUnjugador()
    }
    
}

class Tripulante inherits Jugador{
    const tareas = []

    override method hacerTarea(){
        const tareaParaHacer = self.unaTareaHacibele()
        tareaParaHacer.realizarTarea(self)
        tareas.remove(tareaParaHacer)
        nave.ganaronLosTripulantes() 
    }

    method unaTareaHacibele() = tareas.find({tarea => tarea.puedeRealizarTarea(self)})

    override method terminoSusTareas() = tareas.isEmpty()

    override method notificarAlaNaveDelCaido(){
        nave.sacarUnTripulante()
    }

}

class Tarea{
    const itemsNecesarios

    method puedeRealizarTarea(jugador) = itemsNecesarios.all({item => jugador.tieneUn(item)})

    method realizarTarea(unJugador) {
      self.afectarA(unJugador)
      self.removerItem(unJugador)
    }
    method removerItem(unJugador) {
      itemsNecesarios.forEach({item => unJugador.removerItem(item)})
    }

    method afectarA(unJugador)
}

object arreglarTableroElectrico inherits Tarea(itemsNecesarios = [llaveInglesa]){
    override method afectarA(unJugador){
        unJugador.aumentarNivelDeSospecha(10)
    }
}

object sacarLaBasutra inherits Tarea(itemsNecesarios = [escoba, bolsaDeConsorcio]){
    override method afectarA(unJugador){
        unJugador.disminuirNivelDeSospecha(4)
    }
}

object ventilarLaNave inherits Tarea(itemsNecesarios = []){
    override method afectarA(unJugador){
        nave.aumentarOxigeno(5) 
    }
}


object nave {
    var cantidadDeTripulantes = 0
    var cantidadDeImpostores = 0
    var nivelOxigeno = 100 //Inicializo en algo 
    const jugadores = [] 

    method aumentarOxigeno(cantidad) {
        nivelOxigeno += cantidad
    }

    method reducirOxigeno(cantidad) {
        nivelOxigeno -= cantidad
        self.ganaronLosImpostores()
    }


    method ganaronLosImpostores(){
        if (nivelOxigeno <= 0 || cantidadDeImpostores == cantidadDeTripulantes){
            throw new Exception(message = "GANARON LOS IMPOSTORES")
        }
    }

    method ganaronLosTripulantes(){
        if (self.terminaronSusTareas() || cantidadDeImpostores == 0){
            throw new Exception(message = "GANARON LOS TRIPULANTES")
        }
    }

    method terminaronSusTareas() = jugadores.all({jugador => jugador.terminoSusTareas()})

    method alguienTieneUn(item) = jugadores.any({jugador => jugador.tieneUn(item)}) 

    method impugnarAUnjugador() {
        const unJugador = self.jugadoresEnLaNave().anyOne()
        unJugador.impugnarElVotoAlJugador()
    }

    method jugadoresEnLaNave() = jugadores.filter({jugador => jugador.estajugando()})
    
 
    method reunionDeEmergencia(){
        const votacionesTotales = self.jugadoresEnLaNave().map({jugador => jugador.voto()})
        const masVotado = votacionesTotales.max({jugador => votacionesTotales.occurrencesOf(jugador)})
        masVotado.expulsarDeLaNave()
    }

    method votarCualquieraQueNOsospechoso() = self.jugadoresEnLaNave().findOrDefault({ jugador => !jugador.esSospechoso() }, votoEnBlanco)

    method mayorNivelDeSospecha() = self.jugadoresEnLaNave().max({jugador => jugador.nivelDeSospecha()})               

    method cualquieraQueTengaLaMochiVacia() = self.jugadoresEnLaNave().findOrDefault({ jugador => jugador.mochiVacia()}, votoEnBlanco)
    
    method sacarUnTripulante(){
        cantidadDeTripulantes -= 1
        self.ganaronLosImpostores()
    }

    method sacarUnImpostor(){
        cantidadDeImpostores -= 1
        self.ganaronLosTripulantes()
    }

}


object troll {
    method votar() = nave.votarCualquieraQueNOsospechoso()
}

object detectives {
    method votar() = nave.mayorNivelDeSospecha()
}

object materialista {
    method votar() = nave.cualquieraQueTengaLaMochiVacia()
}

 
//Hora terminada 13:17