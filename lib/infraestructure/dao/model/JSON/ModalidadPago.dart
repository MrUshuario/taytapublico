
class ModalidadPago {

	int? codigoModalidad;
	int? codigoTipoPago;
	String? descripcion;

	ModalidadPago({this.codigoModalidad, this.codigoTipoPago, this.descripcion});

	factory ModalidadPago.fromJson(dynamic json)  =>
			ModalidadPago(
				codigoModalidad: json['codigoModalidad'] as int?,
				codigoTipoPago: json['codigoTipoPago'] as int?,
				descripcion: json['descripcion'] as String?,
			);

	static List<ModalidadPago> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ModalidadPago> items =
		bienvenidaList.map((e) => ModalidadPago.fromJson(e)).toList();
		return items ?? [];
	}
}
