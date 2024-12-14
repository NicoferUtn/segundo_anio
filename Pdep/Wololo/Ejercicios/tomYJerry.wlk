object tom {
  var energia = 100
  var velocidad = 5  //Metros x segundo

  method comer(unRaton) {
    energia += 12 + unRaton.pesoEnGramos()
    self.actualizarVelocidad()
  }

  method actualizarVelocidad() {
    velocidad = 5 + energia / 10
  }

  method correr(segundo) {
    const metros = velocidad * segundo
    energia -= 0.5 * metros
    self.actualizarVelocidad()
  }

  method meConvieneComerRatonA(unRaton, unaDistancia) {
    const energiaGastada = 12 + unRaton.pesoEnGramos()
    const energiaGastadaCorriendo = 0.5 * unaDistancia
    return energiaGastada > energiaGastadaCorriendo

  }
}

object jerry {
    const property pesoEnGramos = 100 
}