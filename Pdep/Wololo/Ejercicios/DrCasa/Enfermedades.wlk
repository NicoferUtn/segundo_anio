
class Enfermedad {
    var celulasAmenazadas

    method atenuarse(cantidadCelulas) {
        celulasAmenazadas -= cantidadCelulas
    }

    method estaCurada() = celulasAmenazadas <= 0

    method afectar(persona)
    method esAgresiva(persona)
}