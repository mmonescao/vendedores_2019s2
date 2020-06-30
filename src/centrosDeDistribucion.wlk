import vendedores.*
import provinciasYCiudades.*
import clientes.*


class CentroDeDistribucion {
	
	var property ciudad = null
	const vendedores = []
	
	method agregarVendedor(vendedor){
		if(vendedores.contains(vendedor)){
			self.error("El vendedor ya se encuentra registrado")
		} else {
			vendedores.add(vendedor)
		}
	}
	
	method vendedorEstrella(){
		return if(not vendedores.isEmpty()){
	   		vendedores.max({vendedor => vendedor.puntajeTotal()})
		} else {
			self.error("El centro no registra vendedores")
		}
	}
	
	method puedeCubrir(unaCiudad){
		return vendedores.any({vendedor => vendedor.puedeTrabajarEn(unaCiudad)})
	}
	
	method vendedoresGenericos(){
		return vendedores.filter({vendedor => vendedor.esGenerico()})
	}
	
	method esRobusto(){
		return vendedores.filter({vendedor => vendedor.esFirme()}).size() >= 3
	}
	
	method repartirCertificado(unCertificado){
		vendedores.forEach({vendedor => vendedor.agregarCertificado(unCertificado)})
	}
	
	method esCandidato(unVendedor){
		return unVendedor.esVersatil() and unVendedor.tieneAfinidadCon(self)
	}
	
}
