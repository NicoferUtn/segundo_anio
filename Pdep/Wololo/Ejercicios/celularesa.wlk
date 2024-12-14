// Celulares
object samsungS21 {
    var property bateria = 5
    const propietario = juliana

    method llamar(duracion) {
        bateria -= 0.25
        propietario.registrarGasto(duracion)
    }

    method estaApagado() {
        return Celular.estaApagado()
    }

    method recargarBateria() {
        Celular.recargarBateria()
    }
}

object iPhone {
    var property bateria = 5
    const propietario = catalina

    method llamar(duracion) {
        bateria -= 0.001 * duracion
        propietario.registrarGasto(duracion)
    }

    method estaApagado() {
        return Celular.estaApagado()
    }

    method recargarBateria() {
        Celular.recargarBateria()
    }

}


class Celular {
    var bateria

    method estaApagado() {
        return bateria <= 0
    }

    method recargarBateria() {
        bateria = 5
    }
}

// Propietarias
object catalina {
    const celular = iPhone
    const compania = movistar
    var property gastoTotal = 0

    method tieneCelularApagado() {
        return celular.estaApagado()
    }

    method registrarGasto(duracion) {
        gastoTotal += compania.costoFijo(duracion)
    }
}

object juliana {
    const celular = samsungS21
    const compania = personal
    var property gastoTotal = 0

    method tieneCelularApagado() {
        return celular.estaApagado()
    }

    method registrarGasto(duracion) {
        gastoTotal += compania.costoFijo(duracion)
    }
}

// Companias
object movistar {
    method costoFijo(duracion) {
        return 60 * duracion
    }
}

object claro {
    const costo = 50

    method costoFijo(duracion) {
        return costo * duracion + costo * 0.21 * duracion
    }
}

object personal {
    method costoFijo(duracion) {
        if (duracion <= 10) {
            return 70 * duracion
        } else {
            return 70 * 10 + 40 * (duracion - 10)
        }
    }
}