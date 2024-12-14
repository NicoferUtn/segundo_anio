//Suelo de pepe ==> sueldo = neto + bono * presentismo + bono * resultados
object pepe {
    var bono = 0
    var presentismo = 0
    var categoria = gerente 
    var neto = categoria.ganancia()

    method CuantoTengoDePresentimso(diaFaltandos) {
        if (diaFaltandos == 0) {
            presentismo = 100
        } else if (diaFaltandos == 1){
            presentismo = 50
        } else {
            presentismo = 0
        }
    }

    method categoriaDeTrabajo(unaCategoria) {
        categoria = unaCategoria
        neto = unaCategoria.ganancia()
    }

    method establecerBonoResultado(tipoBono){
        bono = tipoBono.calcularBonoResultados(neto)
    }

    method calcularSueldo() { 
      return neto + bono + presentismo 
    }
    
}

object gerente {
    const property ganancia = 1000 
}

object cadetes {
    const property ganancia = 1500 
}

object bonoPorcentaje{
    method calcularBonoResultados(neto){
        return neto * 0.10
    }
}

object bonoMontoFijo{
    method calcularBonoResultados(neto){
        return 80
    }
}

object bonoNulo{
    method calcularBonoResultados(neto){
        return 0
    }
}