
class LocalPago {

	int? codigoLocalPago;
	String? descripcion;
	int? orden;

	LocalPago({this.codigoLocalPago, this.descripcion, this.orden});

	factory LocalPago.fromJson(dynamic json)  => LocalPago(
		codigoLocalPago: json['codigoLocalPago'] as int?,
		descripcion: json['descripcion'] as String?,
		orden: json['orden'] as int?,
	);

	static List<LocalPago> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<LocalPago> items =
		bienvenidaList.map((e) => LocalPago.fromJson(e)).toList();
		return items ?? [];
	}

}
