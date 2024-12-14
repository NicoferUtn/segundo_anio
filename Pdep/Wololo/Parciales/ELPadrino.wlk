class Integrante {
    const armas = [new Escopeta()]
    var rango = new Soldado()
    var estaMuerto = false
    var estaHerido = false
    var lealtad
    
    method durmiendoConLosPeses() = estaMuerto
    method estaVivo() = !estaMuerto 
    method estaHerida() = estaHerido
    method cantidadDeArmas() = armas.size()
    method agregarArma(arma) { armas.add(arma) }
    method matar(){ estaMuerto = true }
    method herir() { estaHerido = true }
    method rango() = rango
    method armaCualquiera() = armas.anyOne() 
    method armasMasALaMano() = armas.first()
    method armaSutil() = armas.any({arma => arma.esSutil()})
    method elegancia() = rango.despecharEleganteme(self)
    method atacarPorRangos(atacante) {
        rango.atacar(self, atacante)
    }
    method atacarFamilia(unaFamilia) {
      const atacante = unaFamilia.peligroso()
      if(atacante.estaVivo()){
        self.atacarPorRangos(atacante)
      }
    }

method ascenderASubjefe() {
		rango = new Subjefe()
	}
	
	method esSoldado() = rango.esSoldado()
	
	method ascenderADonDe(unaFamilia) {
		rango = new Don(subordinados = self.subordinados())
		unaFamilia.ascenderADon(self)
	}
	
	method subordinados() = rango.subordinados()
	
	method aumentarLealtadPorLuto() {
		lealtad *= 1.1
	}
	
	method lealtad() = lealtad
}

class Familia {
    const integrantes = #{}
    var don 

    method initialize() {
      if(!self.hayUnSoloDon()){
        throw new DomainException(message = "Hay mas de un Don en esta familia")}
    }
    method peligroso() = self.ingegrantesVivos().max({integrante => integrante.cantidadDeArmas()}) 
    method ingegrantesVivos() = integrantes.filter({integrante => integrante.estaVivo()}) 
    method elQueQuieraEstarArmadoQueAndaArmado() {
        integrantes.forEach({integrante => integrante.agregarArma(revolver6balas)})
    }

    method hayUnSoloDon() = integrantes.filter({integrante => (integrante.rango() == Don)}).size() == 1 //Noc si es lo que pide en la consigna no lo vi en la resu de fede

    method ataqueSorpresa(unaFamilia) {
        self.ingegrantesVivos().forEach({integrante => integrante.atacarFamilia(unaFamilia)})
    }

    	method reorganizarse() {
		self.elegirNuevoDon()
		self.aumentarLealtad()
	}
	
	method soldadosVivos() {
		return self.ingegrantesVivos().filter { integrante => integrante.esSoldado() }
	}
	
	method elegirNuevoDon() {
		don.subordinadoMasLeal().ascenderADonDe(self)
	}
	
	method ascenderADon(unIntegrante) {
		don = unIntegrante
	}
	
	method aumentarLealtad() {
		integrantes.forEach { integrante => integrante.aumentarLealtadPorLuto() }
	}
}




//Armas
const revolver6balas = new Revolver(cantidadDeBalas = 6)
class Revolver {
  var cantidadDeBalas

  method esSutil() = cantidadDeBalas == 1    

  method disparar(persona) {
      if(self.tengoBalas()){
        persona.matar()
        self.reducirCantidadDeBlas(1)
      }
  }
  method recargar(balas) {
    cantidadDeBalas = 8.min(cantidadDeBalas + balas) //puede tener 8 como maximo
  }

  method tengoBalas() = cantidadDeBalas > 0

  method reducirCantidadDeBlas(bala) {
    cantidadDeBalas -= bala
  }
}

class Escopeta{
    method disparar(persona) {
        if(persona.estaHerida()){
            persona.matar()
        } else{
            persona.herir()
        }
    }
}

class CuerdaDePiano {
    const esBuenaCalidad 

    method esSutil() = true

    method disparar(persona) {
      if (esBuenaCalidad)
          persona.matar()
    }
}


//Rangos 
class Don {
    const subordinados = #{}

    method despecharEleganteme(_) = true

    method atacar(_, persona) {
        subordinados.anyOne().atacarPesona(persona)
    }
}

class Subjefe {
const subordinados = #{}

    method despecharEleganteme(_) = subordinados.any({subordinado => subordinado.armaSutil()})

    method atacar(mafioso, persona) {
        mafioso.armaCualquiera().disparar(persona)
    }
}

class Soldado {

    method despecharEleganteme(unaPersona) = unaPersona.armaSutil()

    method atacar(mafioso, persona) {
        mafioso.armasMasALaMano().disparar(persona)
    }
}

class Tradicion {
    const tradicion
    const victimos = #{}

    var fechaTentativa

    method matar() {
      //Alta paja
    }
}
