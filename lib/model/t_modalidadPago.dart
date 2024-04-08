import 'package:floor/floor.dart';
@entity
class ModalidadPago {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoModalidadPago;
	String? nombreModalidadPago;
	String? tipoPagoModalidadPago;

	ModalidadPago({this.id, this.codigoModalidadPago, this.nombreModalidadPago, this.tipoPagoModalidadPago});

	factory ModalidadPago.fromJson(dynamic json)  =>
			ModalidadPago(
				id: json['id'] as int?,
				codigoModalidadPago: json['codigoModalidadPago'] as String?,
				nombreModalidadPago: json['nombreModalidadPago'] as String?,
				tipoPagoModalidadPago: json['tipoPagoModalidadPago'] as String?,
			);

	static List<ModalidadPago> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ModalidadPago> items =
		bienvenidaList.map((e) => ModalidadPago.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
				'codigoModalidadPago': codigoModalidadPago,
				'nombreModalidadPago': nombreModalidadPago,
				'tipoPagoModalidadPago': tipoPagoModalidadPago,
			};
	}
}
