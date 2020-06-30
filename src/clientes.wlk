import vendedores.*

class ClienteInseguro {
	method puedeSerAtendidoPor(unVendedor){
		return unVendedor.esVersatil() and unVendedor.esFirme()
	}
}

class ClienteDetallista inherits ClienteInseguro {
	override method puedeSerAtendidoPor(unVendedor){
		return unVendedor.cantidadDeCertificacionesDeProductos() >= 3
	}
}

class ClienteHumanista inherits ClienteInseguro {
	override method puedeSerAtendidoPor(unVendedor){
		return unVendedor.esPersonaFisica()
	}
}


