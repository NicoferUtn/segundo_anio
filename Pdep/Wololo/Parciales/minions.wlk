class Minios{
    var estamina
    var rol
    
    method estamina() = estamina

    method cambiarRol(rolNuevo) {
        rol = rolNuevo //TODO
    }

    method aumentarEtamina(estaminaAAgregar) 

    method hacerTarea(tarea) {
      if (tarea.puedeHacerLaTarea(self)) //TODO
        tarea.hacerTarea(self) //Todo
    }

    method restaEstamina(estmainaARestar) {
      estamina -= estmainaARestar
    }

    method esMucama() = rol == Mucamas


    method fuerza() = estamina / 2 + 2 + rol.variacionfuerza()
}

class Biciclopes inherits Minios{
    override method aumentarEtamina(estaminaAAgregar){
        estamina = 10.min(estamina + estaminaAAgregar)
    }
}

class Cicliples inherits Minios{
    override method aumentarEtamina(estaminaAAgregar){
        estamina = estamina + estaminaAAgregar
    }

    override method fuerza() = super() / 2
}


// Roles
class Solados{
    var arma
    var practica

    method variacionfuerza() = practica
}

class Obreros{
    const property herraminetas = [] 

    method variacionfuerza() = 0
}

class Mucamas {
    method variacionfuerza() = 0
}


//Tareas
class ArreglarMaquina{
    const complejidad

    method puedeHacerLaTarea(minion) = minion.estamina() >= complejidad


    method hacerTarea(minion) {
        minion.restaEstamina(complejidad)
    }

    method dificultad() = 2 * complejidad
}

class DefenderSector{
    const gradoDeAmenaza
    
    method puedeHacerLaTarea(minion) = !minion.esMucama() and minion.fuerza() >= gradoDeAmenaza

    method hacerTarea(minon) {
      
    }
}