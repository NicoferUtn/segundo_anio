import Enfermedades.* 

class EnfermedadAutoinmune inherits Enfermedad {
  var cantidadDeVecesQueAfecto = 0

  override method afectar(unaPersona) {
    unaPersona.disminuirCelulas(celulasAmenazadas)
    self.aumentarVecesQueAfecto()
  }

  override method esAgresiva(_unaPersona) = cantidadDeVecesQueAfecto > 30

  method aumentarVecesQueAfecto() {
    cantidadDeVecesQueAfecto += 1
  }
}
