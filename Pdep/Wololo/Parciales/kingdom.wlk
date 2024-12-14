
class AtaqueFisico{
    const potencia

    method potencia() = potencia
}

class AtaqueMagico{
    const potenciaMagica
    const elemento

    method elemento() = elemento
    method potenciaMagica() = potenciaMagica

}

class Hechizo{
    const potenciaBase
    const elemento

    method elemento() = elemento
    method potenciaBase() = potenciaBase
}

class Enemigo {
    var puntoVida
    const elemento

    method puntoVida() = puntoVida

    method reducirPV(cantidad) {
      puntoVida = 0.max(puntoVida - cantidad)
    }

    method recibirAtaqueFisico(ataqueFisico){
        const cantidadDanio = 1.max(self.cantidadDeDanio(ataqueFisico.potencia()))
        self.reducirPV(cantidadDanio)
    }

    method recibirAtaqueMagico(ataqueMagico){
        const cantidadDanio = elemento.cantidadDeDanioMagico(ataqueMagico)
        self.reducirPV(cantidadDanio)
    }

    method cantidadDeDanio(ataqueFisico)
}

class Elemento{
    const elementoContrario

   method cantidadDeDanioMagico(ataqueMagico) {
      if (self == ataqueMagico.elemento()){
        return 0
      }else if(elementoContrario == ataqueMagico.elemento()){
        return 2 * ataqueMagico.potenciaMagica()
      }else{
        return ataqueMagico.potenciaMagica()
      }
    }
}

object fuego inherits Elemento(elementoContrario = hielo) {}
object hielo inherits Elemento(elementoContrario = fuego) {}
object oscuridad inherits Elemento(elementoContrario = luz) {}
object luz inherits Elemento(elementoContrario = oscuridad) {}



class Incorporeos inherits Enemigo {
    const defenza 
    override method cantidadDeDanio(potencia) = (potencia - defenza).abs()
}

class SinCorazon inherits Enemigo {
    override method cantidadDeDanio(potencia) = potencia * 0.9
}

class Heroe{
    var puntosMana
    const fuerza
    var llaveEspada

    method atacarDanioFisico(enemigo){
        const danio = new AtaqueFisico(potencia = self.potenciaFisica() + fuerza)
        enemigo.recibirAtaqueFisico(danio)
    }

    method atacarDanioMagicamente(enemigo, hechizo){
        self.puedeAtacar(hechizo.potenciaBase())
        const unAtaqueMagico = new AtaqueMagico(potenciaMagica = self.potenciaMagica(hechizo) ,elemento = hechizo.elemento())
        enemigo.recibirAtaqueMagico(unAtaqueMagico)
        self.restarPutosMana(hechizo.potenciaBase())
    }

    method potenciaMagica(hechizo) = hechizo.potenciaBase() *  llaveEspada.poderMagico()
    method potenciaFisica() = llaveEspada.poderFisico()

    method restarPutosMana(cantidad){
        puntosMana -= cantidad
    }
    method cambiarLlaveEspaada(unaLlaveEspada){
        llaveEspada = unaLlaveEspada
    }

    method puntosMana() = puntosMana

    method puedeAtacar(potenciaBase){
        if ( potenciaBase > puntosMana)
        throw new Exception(message = "No se puyede atacar asi che")
    }

    method esMejorQueMiLlaveEspada(unaLlaveEspada) = unaLlaveEspada.poderFisico() > llaveEspada.poderFisico()

    method estaAgotado() = puntosMana <= 0
}  

class Ventus inherits Heroe{
    override method atacarDanioFisico(enemigo){
        const danio = new AtaqueFisico(potencia = llaveEspada.poderMagico() + fuerza)
        enemigo.recibirAtaqueFisico(danio)
    }

    override method atacarDanioMagicamente(enemigo, hechizo){
        self.puedeAtacar(hechizo.potenciaBase())
        const unAtaqueMagico = new AtaqueMagico(potenciaMagica = hechizo.potenciaBase() *  llaveEspada.poderFisico() ,elemento = hechizo.elemento())
        enemigo.recibirAtaqueMagico(unAtaqueMagico)
        self.restarPutosMana(hechizo.potenciaBase())
    }

}

class Roxas inherits Heroe {
    var modo = tranquilo
    var contadorAtaquesFisico = 0
    var contadorAtaquesmagico = 0

    override method atacarDanioFisico(enemigo){
        super(enemigo)
        self.aumentarModoFisico()
        self.verificarModoDeAtaque()
    }

    override method atacarDanioMagicamente(enemigo, hechizo) {
        super(enemigo, hechizo)
        self.aumentarModoMagico()
        self.verificarModoDeAtaque()
    }

    override method potenciaMagica(hechizo) = super(hechizo) * modo.multiplicadorMagico()
    override method potenciaFisica() = super() * modo.multiplicadorFisico()

    method verificarModoDeAtaque(){
        if (contadorAtaquesFisico >= 5){
            modo = valiente
            contadorAtaquesFisico = 0
        }else if (contadorAtaquesmagico >= 5){
            modo = sabio
            contadorAtaquesmagico = 0
        }
    }

    method aumentarModoFisico(){
        contadorAtaquesFisico += 1
        contadorAtaquesmagico = 0
    }

    method aumentarModoMagico(){
        contadorAtaquesFisico = 0
        contadorAtaquesmagico += 1
    }
}

object tranquilo{
    method multiplicadorFisico() = 1
    method multiplicadorMagico() = 1
}

object valiente {
    method multiplicadorFisico() = 1.50
    method multiplicadorMagico() = 0.80
}

object sabio {
    method multiplicadorFisico() = 0.3
    method multiplicadorMagico() = 2
}


class LlaveEspada{
    const poderFisico
    const poderMagico

    method poderFisico() = poderFisico
    method poderMagico() = poderMagico
}


class Equipos {
    const heroes = []

    method hayAlguienAgotado(){
        heroes.any({heroe => heroe.estaAgotado()})
    }

    method emboscarAunMoustro(enemigo){
        heroes.forEach({heore => heore.atacarDanioFisico()})
    }

    method esUtilCambiarSuLlaveEspada(unaLlaveEspada) = heroes.any({heroe => heroe.esMejorQueMiLlaveEspada(unaLlaveEspada)})

    method legarLlaveEspadaAEquipo(unaLlaveEspada){
        if(self.esUtilCambiarSuLlaveEspada(unaLlaveEspada)){
            const heroeElegido = heroes.filter({heroe => heroe.esMejorQueMiLlaveEspada(unaLlaveEspada)}).anyOne()
            heroeElegido.cambiarLlaveEspaada(unaLlaveEspada)
        }
    }
}

