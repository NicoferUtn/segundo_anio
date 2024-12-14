class Persona {
    var enfermedades = #{}
    var temperatura
    var cantidadDeCelulas

    method contraerEnfermedad(unaEnfermedad) {
        enfermedades.add(unaEnfermedad)
    }
  
  method tiene(unaEnfermedad) = enfermedades.contains(unaEnfermedad)
  
  method vivirUnDia() {
    enfermedades.forEach({ enfermedad => enfermedad.afectar(self) })
  }
  
  method aumentarTemperatura(unosGrados) {
        temperatura = 45.min(temperatura + unosGrados)
  }
  
  method destruirCelulas(unaCantidad) {
    cantidadDeCelulas -= unaCantidad
  }
  
  method cantidadCelulasAfectadasPorEnfermedadesAgresivas() = self.enfermedadesAgresivas().sum(
    { enfermedad => enfermedad.cantidadCelulasAmenazadas() }
  )
  
  method enfermedadesAgresivas() = enfermedades.filter({ enfermedad => enfermedad.esAgresivaPara(self) })
  
  method cantidadCelulas() = cantidadDeCelulas
  
  method enfermedadQueMasCelulasAfecta() = enfermedades.max({ enfermedad => enfermedad.cantidadCelulasAmenazadas() })
  
  method estaEnComa() = self.estaDelirando() || self.tienePocasCelulas()
  
  method estaDelirando() = temperatura == 45
  
  method tienePocasCelulas() = cantidadDeCelulas < 1000000
  
  method vivir(unosDias) {
    unosDias.times({ _ => self.vivirUnDia() })
  }
  


}

