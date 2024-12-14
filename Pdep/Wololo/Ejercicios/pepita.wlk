
object pepita {
    var energia = 100
    var lugar = caba

    method volar(kilometros) {
        energia -= kilometros + 10
    }

    method comer(gramos) {
        energia += 4 * gramos
    }

    method irA(unLugar) {
        lugar = unLugar
        self.volar(unLugar.kilometro())
    }

    method puedeIrA(unLugar) {
        const kilometrosAViajar = (lugar.kilometro() - unLugar.kilometro()).abs()
        return energia > kilometrosAViajar + 10
    }
}

object caba {
    const property kilometro = 50 //Property para ahorrame le method
}


