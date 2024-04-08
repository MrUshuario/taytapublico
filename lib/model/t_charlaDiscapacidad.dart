import 'package:floor/floor.dart';
@entity
class CharlaDiscapacidad {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoCharlaDiscapacidad;
	String? charlaDiscapacidad;

	CharlaDiscapacidad({this.id, this.codigoCharlaDiscapacidad, this.charlaDiscapacidad});

	factory CharlaDiscapacidad.fromJson(dynamic json)  =>
			CharlaDiscapacidad(
				id: json['id'] as int?,
				codigoCharlaDiscapacidad: json['codigoCharlaDiscapacidad'] as String?,
				charlaDiscapacidad: json['charlaDiscapacidad'] as String?,
			);

	static List<CharlaDiscapacidad> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CharlaDiscapacidad> items =
		bienvenidaList.map((e) => CharlaDiscapacidad.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoCharlaDiscapacidad": codigoCharlaDiscapacidad,
			"charlaDiscapacidad": charlaDiscapacidad
		};
	}

}
