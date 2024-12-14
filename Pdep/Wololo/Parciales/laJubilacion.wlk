

class Fiesta {
    const personal = []
    const costoFijo = 200000
    const registroDeLlegados = []
    var cantidadRegalada

    method llegaUnaPersona(persona){
        if(self.estaEnLaLista(persona)){
            self.dejarPasar(persona)
        }else{
            throw new Exception(message = "No esta invitado a la fiesta alto pete")
        }
    }

    method registroDeLlegados() = registroDeLlegados

    method balanceDeFiesta() = cantidadRegalada - costoFijo //Noc si van las 5 lucas por personas pero si es asi registroDeLlegados.size() * 5000

    method fueUnExito() = self.balanceDeFiesta() > 0 and self.asistieronTodos()

    method asistieronTodos() = registroDeLlegados == self.invitados()

    method mesaConMasPersonas() { // Como sacar el mas repetido
        const mesasAsignadas = registroDeLlegados.map({persona => persona.numeroDeMesaAsignado()})
        return mesasAsignadas.max { mesa => mesasAsignadas.occurrencesOf(mesa) }
    }

    method dejarPasar(persona){
        registroDeLlegados.add(persona)
        persona.asignarNumeroDeMesa()
    }

    method regalarEfectivo(cantida){
        cantidadRegalada += cantida
    }

    method estaEnLaLista(persona) = self.invitados().contains(persona)

    method invitados() = personal.filter({persona => persona.estaInvitado()})
}

class Persona {
    const lenguajesDeProgramacion = #{}

    method estaWollok() = lenguajesDeProgramacion.contains(wololo)

    method tieneAlgunLenguajeViejo() = lenguajesDeProgramacion.any({lenguaje => lenguaje.esViejo()})

    method tieneAlgunLenguajeModerno() = lenguajesDeProgramacion.any({lenguaje => lenguaje.esModerno()})

    method tieneAlMenoslenguajes(cantidaDeLenguajes) = lenguajesDeProgramacion.size() >= cantidaDeLenguajes

    method aprenderUnLenguaje(lenguaje){
        lenguajesDeProgramacion.add(lenguaje)
    }

    method irAUnEvento(fiesta){
        fiesta.llegaUnaPersona(self)
        fiesta.regalarEfectivo(1000 + self.dineroAdicional())
    }

    method numeroDeMesaAsignado() = lenguajesDeProgramacion.size()

    method estaInvitado()
    method esCopada()
    method dineroAdicional()
} 

class Desarrolladores inherits Persona{
    override method estaInvitado() = self.estaWollok() or self.tieneAlgunLenguajeViejo()

    override method esCopada() = self.tieneAlgunLenguajeViejo() and self.tieneAlgunLenguajeModerno()

    override method dineroAdicional() = 0
}

class Infrastructura inherits Persona{
    const aniosExperiencia
    override method estaInvitado() = self.tieneAlMenoslenguajes(5)

    override method esCopada() = aniosExperiencia > 10
    
    override method dineroAdicional() = 0
}

class Jefes inherits Persona {
    const personasACargo = #{}

    override method estaInvitado() = self.tieneAlgunLenguajeViejo() and self.soloGenteCopada()

    method soloGenteCopada() = personasACargo.all({persona => persona.esCopada()})

    override method esCopada() = false

    method ponerPersonaACargo(persona){
        personasACargo.add(persona)
    }

    override method numeroDeMesaAsignado() = 99

    override method dineroAdicional() = 1000 * personasACargo.size()
}

// Lenguajes
class Lenguajes {
    const esViejo 

    method esViejo() = esViejo
    method esModerno() = !esViejo
}

const wololo = new Lenguajes(esViejo = false) 