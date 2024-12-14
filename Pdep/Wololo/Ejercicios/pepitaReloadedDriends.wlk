
object pepita { //Calulo que es ave
    var joules = 100
    var lugar = caba
    var entrenador = roque

    method volar(kilometros) {
        Ave.volar(kilometros, 10)
    }


    method comer(gramos) {
        Ave.comer(gramos, 0, 4)
    }

    method irA(unLugar) {
        if (self.puedeIrA(unLugar)) {
            lugar = unLugar
            self.volar(unLugar.kilometro())
        }
    }

    method puedeIrA(unLugar) {
        const kilometrosAViajar = (lugar.kilometro() - unLugar.kilometro()).abs()
        return joules > kilometrosAViajar + 10
    }

    method esParLaEnegia() {
        return joules.even()
    }

    method estaDebil() {
        return joules < 50
    }

    method estaEuforica() {
        return joules > 500 && self.esParLaEnegia()
    }


    method hacerDeseo() {
        if (self.estaEuforica()) {
            self.volar(5) 
        } else if (self.estaDebil()) {
            self.comer(500) 
        }
    }

    method entreanar() {
        entrenador.entreanar(self)
    }

    method cambiarEntrenador(nuevoEntrenador) {
        entrenador = nuevoEntrenador
    }
    
}

object pepon { //Calulo que es ave
    var joules = 100
    var entrenador = roque

    method volar(kilometros) {
        joules -= Ave.volar(2 * kilometros, 0)
    }

    method comer(gramos) {
        joules += Ave.comer(gramos, 20, 3)
    }


    method esParLaEnegia() {
        return joules.even()
    }

    method estaDebil() {
        return joules < 50
    }

    method estaEuforica() {
        return joules > 500 && self.esParLaEnegia()
    }


    method hacerDeseo() {
        if (self.estaEuforica()) {
            self.volar(5) 
        } else if (self.estaDebil()) {
            self.comer(500) 
        }
    }

    method entreanar() {
        entrenador.entreanar(self)
    }

    method cambiarEntrenador(nuevoEntrenador) {
        Ave.cambiarEntrenador(nuevoEntrenador)
    }
    
}


class Ave {
    var entrenador

    method volar(kilometros, costoFijo) {
        return kilometros + costoFijo
    }

    method comer(gramos, costoFijo, multiplicadorDeJulios) {
        return  multiplicadorDeJulios * gramos + costoFijo
    }

    method cambiarEntrenador(nuevoEntrenador) {
        entrenador = nuevoEntrenador
    }

}


object roque {
    method rutina(ave) {
        ave.volar(5)
        ave.comer(300)
        ave.volar(3)
    }
}

object susana {
    method rutina(ave) {
      ave.volar(3)
      ave.hacerDeseo()
    }
}

object caba {
    const property kilometro = 50 //Property para ahorrame le method
}


