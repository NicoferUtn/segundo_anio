class Individuo{
    var rango
    const armas = []
    var estaMuerto = false
    var estaHerida = false
    var lealtad

    method duminiednoCOnLosPeces() = estaMuerto

    method estaVivo() = !estaMuerto

    method matar() {
        estaMuerto = true
    }

    method herida(){
        estaHerida = true
    }

    method cantidadDeArmas() = armas.size()

    method aniadirArma(arma){
        armas.add(arma)
    } 

    method tieneUnArmautil() = armas.any({arma => armas.esSutil()})

    method armaCualquiera() = armas.anyOne()
    
    method armasMasALaMano() = armas.take(1)


    method elegancia() = rango.eleganciaPorRango(self)

    method atacar(unAgresor){
        rango.atacarPorRango(self, unAgresor)
    }

    method esSoldado() = rango.esSoldado()

    method tieneMasDecincoArmas() = armas.size() > 5

    method asender(){
        rango = new Subjefe()
    }

    method aumentarLealtaed(porcentaje){
        lealtad *= porcentaje 
    }

    method lealta() = lealtad

    method acenderADon(){
        rango = new Don()
    }
}

class Don {
    const subordinados = [] 

    method eleganciaPorRango(_) = true

    method atacarPorRango(atacante,agresor) {
        subordinados.anyOne().atacarPorRango(agresor)
    }

    method esSoldado() = false

}

class Subjefe {
    const subordunados = []
    method eleganciaPorRango(_) = subordunados.any({subordinado => subordinado.tieneUnArmautil()})

    method atacarPorRango(atacante,agresor) {
        atacante.armaCualquiera().disparar(agresor)
    }
    
    method esSoldado() = false
}
class Sodlado {
    method eleganciaPorRango(persona) = persona.tieneUnArmautil()

    method atacarPorRango(atacante,agresor) {
      atacante.armasMasALaMano().disparar(agresor)
    }

    method esSoldado() = true
}

class Familia{
    const integrantes = []

    method peligros() = self.integrantesVivos().max({integrante => integrante.cantidadDeArmas()})

    method integrantesVivos()  = integrantes.filter({integrante => integrante.estaVivo()})

    method elQueQuieraEstarArmadoQueAndeArmado() {
         self.integrantesVivos().forEach({integrante => integrante.aniadirArma(revolver)})
    }

    method ataqueSorpresa(unaFamilia){
        const atacante =  self.integrantesVivos().anyOne()
        const agresor = unaFamilia.peligroso()
        atacante.atacar(agresor)
    }

    method luto() {
        self.asenderAIntegrantes()
        self.masLeal()
        self.AumentoDeLealtad(0.1)
    } 

    method asenderAIntegrantes() {
        const soldadosAsendidos = self.integrantesVivos().filter({integrante => (integrante.esSoldado() and integrante.tieneMasDecincoArmas())})
        soldadosAsendidos.forEach({soldado => soldado.asender()})
    }

    method AumentoDeLealtad(porcentaje){
        self.integrantesVivos().AumentoDeLealtad(porcentaje)
    }

    method masLeal() {
      const nuevoDon = self.integrantesVivos().max({integrante => integrante.lealtad()})
      nuevoDon.acenderADon()
    }
}


const revolver = new Revolever(balas = 6)


class Revolever {
    var balas

    method disparar(persona){
        if(balas >= 1){
            persona.matar()
            balas -= 1 
        }
    }

    method esSutil() = balas == 1

}

object escopeta {
    method disparar(persona){
        if(persona.estaHerida()){
            persona.matar()
        }else{
            persona.estaHerida()
        }
    }

    method esSutil() = false
}

class CuerdaDePiano {
    const buenaCalidad // Noc si hace falta despues ver

    method disparar(persona){
        if(buenaCalidad)
            persona.matar()
    }

    method esSutil() = true
}



