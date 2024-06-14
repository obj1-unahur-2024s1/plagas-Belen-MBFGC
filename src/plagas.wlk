class Elementos {
	method esBueno()	
	method serAtacadoPor(plaga)
}

class Hogar inherits Elementos{
	var property nivelDeMugre 
	var property confort 
	
	override method esBueno(){
		//nivel de mugre es la mitad del confort o menos
		return nivelDeMugre <= (confort/2)
	}
	
	override method serAtacadoPor(plaga){
		nivelDeMugre += plaga.danioQueProvoca()
	}
}

class Huerta inherits Elementos{
	var nivelDeProduccion
	override method esBueno(){
		return nivelDeProduccion > valorReferencia.valor()

	}
	override method serAtacadoPor(plaga){
		nivelDeProduccion -= (plaga.danioQueProvoca()* 0.1 + if(plaga.transmiteEnfermedades())10 else 0)
	}
	
}

object valorReferencia{
	var property valor = 1
}


class Mascota inherits Elementos{
	var nivelDeSalud
	
	method nivelDeSalud()=nivelDeSalud 
	
	override method esBueno(){
		return  nivelDeSalud > 250
	}
	override method serAtacadoPor(plaga){
		nivelDeSalud -= if(plaga.transmiteEnfermedades()) plaga.danioQueProvoca() else 0
	}
}

class Barrio {
	const elementos=[]
	
	method esCopado(){
		return self.cantidadDeElementosBuenos() > (elementos.size()/2)
	}
	
	method cantidadDeElementosBuenos(){
		return elementos.count({e=>e.esBueno()})
	}
	
}

class Plagas {
	var  poblacion 
	
	method poblacion()=poblacion
	method transmiteEnfermedades(){
		return poblacion > 10 and self.condicionAdicional()
	}
	method danioQueProvoca()
	
	method condicionAdicional()
	method atacar(lugar){
		lugar.serAtacadoPor(self)
		self.crecer()
	}
	method crecer(){
		poblacion = poblacion * 1.1
	}
}

class Cucaracha inherits Plagas {
	var property pesoPromedio
	
	override method danioQueProvoca() = poblacion/2
	override method condicionAdicional() = pesoPromedio >= 10
	 
}

class Pulgas inherits Plagas {
	
	override method danioQueProvoca() = 2* poblacion
	override method condicionAdicional() = true
	
} 

class Garrapatas inherits Pulgas {
	
	override method crecer(){
		poblacion = poblacion * 1.2
	}
} 


class Mosquito inherits Plagas {
	
	override method danioQueProvoca() = poblacion
	override method condicionAdicional() = poblacion % 3 == 0
} 



