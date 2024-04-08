import 'package:floor/floor.dart';
@entity
class CharlaGenero {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoCharlaGenero;
	String? descripcionCharlaGenero;

	CharlaGenero({this.id, this.codigoCharlaGenero, this.descripcionCharlaGenero});

	factory CharlaGenero.fromJson(dynamic json)  => CharlaGenero(
		id: json['id'] as int?,
		codigoCharlaGenero: json['codigoCharlaGenero'] as String?,
		descripcionCharlaGenero: json['descripcionCharlaGenero'] as String?,
	);

	static List<CharlaGenero> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CharlaGenero> items =
		bienvenidaList.map((e) => CharlaGenero.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoCharlaGenero": codigoCharlaGenero,
			"descripcionCharlaGenero": descripcionCharlaGenero
		};
	}
}
