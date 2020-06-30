import provinciasYCiudades.*

class Vendedor {
	const property certificaciones = []
	
	method agregarCertificado(unCertificado){ certificaciones.add(unCertificado)}
	
	method puedeTrabajarEn(unaCiudad)
	
	method tieneCertificacionDeProducto() = certificaciones.any({cert => cert.esDeProducto()})
	
	method tieneCertificacionQueNoSeaDeProducto() = certificaciones.any({cert =>not cert.esDeProducto()})
	
	method esVersatil() = self.tieneCertificacionDeProducto() and self.tieneCertificacionQueNoSeaDeProducto() and certificaciones.size() >= 3
	
	method puntajeTotal() = certificaciones.sum({cert => cert.puntos()})
	
	method esFirme() = self.puntajeTotal() >= 30
	
	method esVendedorInfluyente() = false
	
	method esGenerico() = self.tieneCertificacionQueNoSeaDeProducto()
	
	method tieneAfinidadCon(unCentro){
		return self.puedeTrabajarEn(unCentro.ciudad())
	}
	
	method cantidadDeCertificacionesDeProductos(){
		return certificaciones.count({certificacion => certificacion.esDeProducto()})
	}
	
	method esPersonaFisica() = true
	
}

class VendedorFijo inherits Vendedor {
	var property ciudadDondeVive = null
	
	override method puedeTrabajarEn(unaCiudad) = unaCiudad == ciudadDondeVive
}

class VendedorViajante inherits Vendedor {
	const property provinciasHabilitadas = #{}
	
	method agregarProvincia(unaProvincia) = provinciasHabilitadas.add(unaProvincia)
	
	override method puedeTrabajarEn(unaCiudad) = provinciasHabilitadas.contains(unaCiudad.provincia()) 
	
	method sumaDePoblacionEnProvinciasHabilitadas() = provinciasHabilitadas.sum({prov => prov.poblacion()})
	
	override method esVendedorInfluyente() = self.sumaDePoblacionEnProvinciasHabilitadas() >= 10
}

class ComercioCorresponsal inherits Vendedor {
	const property ciudadesDondeHaySucursales = []
	
	method agregarSucursalEnCiudad(unaCiudad) = ciudadesDondeHaySucursales.add(unaCiudad)
	
	override method puedeTrabajarEn(unaCiudad) = ciudadesDondeHaySucursales.contains(unaCiudad) 
	
	method tieneSucursalesEn5Ciudades() = ciudadesDondeHaySucursales.size() >= 5
	
	method tieneSucursalesEn3Provincias() = ciudadesDondeHaySucursales.map({ciudad => ciudad.provincia()}).asSet().size() >= 3
	
	override method esVendedorInfluyente() = self.tieneSucursalesEn5Ciudades() or self.tieneSucursalesEn3Provincias()
	
	override method tieneAfinidadCon(unCentro){
		return super(unCentro) and ciudadesDondeHaySucursales.any({unaCiudad => not unCentro.puedeCubrir(unaCiudad)})
	}
	
	override method esPersonaFisica() = false
}

class Certificado {
	var property puntos = 0
	var property esDeProducto = true
}
