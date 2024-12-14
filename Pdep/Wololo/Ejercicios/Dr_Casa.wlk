object frank {
    const temperatura = 36
    const celulas = 3000000

    method estaEnComa() {
        Persona.estaEnComa(temperatura, celulas)
    }
  
}



class Persona {
    const enfermedades = []

    method contraerEnfermedad(enfermedad){
        enfermedades.add(enfermedad)
    }

    method estaEnComa(temperatura, celulas) {
        return temperatura >= 45 || celulas < 1000000
    }

    method vivirUnDia() {
        enfermedades.forEach {enfermedad => enfermedad.efecto(self)} //Un poquieto de chatGPT
    }

    method pasarDias(cantidadDeDias) {
        cantidadDeDias.times { self.vivirUnDia() }
    }

}



class Iinfecciosa {
    var celulasAmenazadas 

    method inicializarCelulasAmenazadas(cantidadDeCelulas) {
        celulasAmenazadas = cantidadDeCelulas
    }

    method efecto(persona) {
        persona.temperatura += celulasAmenazadas / 1000
        if (persona.temperatura > 45) {
            persona.temperatura = 45 
        }
    }

    method esAgresiva(persona) {
        return celulasAmenazadas > 0.10 * persona.celulas
    }
  
}

class Autoinmune {
    var diasAfectados = 0

    method efecto(persona) {
        diasAfectados += 1
        persona.celulas -= celulasAmenazadas
    }

    method esAgresiva() {
        return diasAfectados > 30
    }
}