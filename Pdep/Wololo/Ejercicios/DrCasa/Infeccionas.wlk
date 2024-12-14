import Enfermedades.*

class Infecciosas inherits Enfermedad {

    override method afectar(persona) {
        persona.aumentarTemperatura(celulasAmenazadas/1000)
    }

    method reproducirse() {
        celulasAmenazadas *= 2
    }

      override method esAgresiva(persona) = celulasAmenazadas > persona.cantidadCelulas() * 0.10

}