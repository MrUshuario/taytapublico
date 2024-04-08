import 'package:floor/floor.dart';
@entity
class LocalPago {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoLocalPago;
	String? descripcion;
	String? ordenLocalPago;

	LocalPago({this.id, this.codigoLocalPago, this.descripcion, this.ordenLocalPago});

	factory LocalPago.fromJson(dynamic json)  => LocalPago(
		id: json['id'] as int?,
		codigoLocalPago: json['codigoLocalPago'] as String?,
		descripcion: json['descripcion'] as String?,
		ordenLocalPago: json['ordenLocalPago'] as String?,
	);

	static List<LocalPago> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<LocalPago> items =
		bienvenidaList.map((e) => LocalPago.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoLocalPago": codigoLocalPago,
			"descripcion": descripcion,
			"ordenLocalPago": ordenLocalPago
		};
	}

}
