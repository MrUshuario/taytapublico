
class PuntoPago {
	
	int? codigoCronograma;
	int? tipoPuntoPago;
	String? codigoPuntoPago;
	String? codigoUbigeo;
	String? lugarAgencia;
	
	String? fechaPago;
	String? horaPago;
	int? totalUsuarios;

	PuntoPago({
      this.codigoCronograma,
      this.tipoPuntoPago,
      this.codigoPuntoPago,
      this.codigoUbigeo,
      this.lugarAgencia,
      this.fechaPago,
			this.horaPago,
      this.totalUsuarios});

	factory PuntoPago.fromJson(dynamic json)  => PuntoPago(
		codigoCronograma: json['codigoCronograma'] as int?,
		tipoPuntoPago: json['tipoPuntoPago'] as int?,
		codigoPuntoPago: json['codigoPuntoPago'] as String?,
		codigoUbigeo: json['codigoUbigeo'] as String?,
		lugarAgencia: json['lugarAgencia'] as String?,
		fechaPago: json['fechaPago'] as String?,
		horaPago: json['horaPago'] as String?,
		totalUsuarios: json['totalUsuarios'] as int?,
	);

	static List<PuntoPago> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<PuntoPago> items =
		bienvenidaList.map((e) => PuntoPago.fromJson(e)).toList();
		return items ?? [];
	}

}
