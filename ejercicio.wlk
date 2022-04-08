object registro {
	var ventas = new List()

	method ventas() = ventas
	method agregarVenta(venta) { 
		ventas.add(venta)
	}

	method filtrar(fechaBuscada) = ventas.filter { venta => venta.fecha()==(fechaBuscada) }

	method gananciaTotal(fechaBuscada) = self.filtrar(fechaBuscada).sum { venta => venta.ganancia() }
}

class Prenda {
	var precioBase
	var tipo = new Pantalon()
	var estado = new Promocion (valorFijo = 100)

	method precio() = estado.precio(precioBase)
}

class Saco {}
class Pantalon {}
class Camisa {}

object nueva {
	method precio(precioBase) = precioBase
}

class Promocion {
	var valorFijo
	
	method precio(precioBase) = precioBase - valorFijo
}

object liquidacion {
	method precio(precioBase) = precioBase/2
}

class Venta {
	var pago = efectivo
	var fecha = new Date()
	var prendas = new List()

	method fecha() = fecha
	method cantidadPrendas() = prendas.size()

	method registrar() {
		if( !registro.ventas().contains(self) )
			registro.agregarVenta(self)
	}

	method precioBase() = prendas.sum { prenda => prenda.precio() }

	method ganancia() {
		self.registrar()
		return self.precioBase() + pago.recargo(prendas)
	}
}

object efectivo {
	method recargo(_) = 0
}

class Tarjeta {
	var cuotas
	var coeficienteFijo

	method recargo(prendas) = cuotas * coeficienteFijo + prendas.sum { prenda => (0.01 / 100) * prenda.precio() }
}
