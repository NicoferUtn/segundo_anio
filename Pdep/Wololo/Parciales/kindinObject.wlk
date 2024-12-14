//Ataques Fisicos (Con sierta potencia) 
//Hechizos (Potencia y un elemento)

class Enemigos{
    var vida
    const elemento

    method vida() = vida 


    method restarVida(vidaQuitada) {
        vida = 0.max(vida - vidaQuitada)
    }

    method vidaPorRazaAtaqueFisco(potencia) {
      self.restarVida( 1.max(potencia) )
    }

    method recibirAtaqueMagico(hechizo) {
      const danio = self.calularDanioHechizo(hechizo)
      self.restarVida(danio)
    }

    method calularDanioHechizo(hechizo)  = elemento.recibirHechizo(hechizo)

    method recibirAtaqueFisico(potencia) 
}

class Elemento {
    const elementoContrario

    method recibirHechizo(hechizo) {
      if (self == hechizo.elemento()){
        return 0
      }else if(elementoContrario == hechizo.elemento()){
        return 2 * hechizo.potencia()
      }else{
        return hechizo.potencia()
      }
    }
}

object fuego inherits Elemento(elementoContrario = hielo) {}
object hielo inherits Elemento(elementoContrario = fuego) {}
object oscuridad inherits Elemento(elementoContrario = luz) {}
object luz inherits Elemento(elementoContrario = oscuridad) {}


class Incoporeos inherits Enemigos{
  const defenza

    override method recibirAtaqueFisico (potencia) {
      self.vidaPorRazaAtaqueFisco((defenza - potencia).abs())
  }
}

class Sincorazon inherits Enemigos{

    override method recibirAtaqueFisico (potencia) {
      self.vidaPorRazaAtaqueFisco(potencia * 0.9)
    }
}

class Hechizos {
    const elemento
    const poderBase = 0

    method poderBase() = poderBase 
    method elemento() = elemento 
}

class AtaqueMagico {
   const elemento
    const property potencia 
    method elemento() = elemento 
}


class Heroe {
  const fuerza
  var mana
  var equipamiento

  method mana() = mana 

  method atacarFisicamente(enemigo) {
    enemigo.recibirAtaqueFisico(self.danioTotalfisico())
  }

  method danioTotalfisico() = fuerza + equipamiento.poderFisico()

  method atacarMagicamente(enemigo, hechizo) {
    enemigo.restarVida(self.danioTotalMagico(hechizo, enemigo))
  }

  method danioTotalMagico(hechizo, enemigo) {
    if (mana > hechizo.poderBase()){
      self.disminuirMana(hechizo.poderBase())
      const potencia = equipamiento.poderMagico() * hechizo.poderBase() 
      const nuevoAtaqueMagico = new AtaqueMagico(elemento = hechizo.elemento() , potencia = potencia)
      return enemigo.calularDanioHechizo(nuevoAtaqueMagico)

    }else{
       throw new Exception(message = "No tenes el mana suficiente para atacar PETON")
    }
  }

  method disminuirMana(manaADisminuir) {
    mana -= manaADisminuir
  }

  method descans() {
    if (mana < 30){
        mana = 30
    }
  }

  method cambiarLlave(nuevaLlave) {
    equipamiento = nuevaLlave
  }
}

class LlaveEspada {
  const poderFisico
  method poderFisico() = poderFisico 

  const poderMagico
  method poderMagico() = poderMagico 

}