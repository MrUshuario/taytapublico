import 'package:floor/floor.dart';
@entity
class CampaniaSalud {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoCampania;
	String? nombreCampania;
	String? ordenCampania;

	CampaniaSalud({this.id, this.codigoCampania, this.nombreCampania, this.ordenCampania});

	factory CampaniaSalud.fromJson(dynamic json)  =>
			CampaniaSalud(
				id: json['id'] as int?,
				codigoCampania: json['codigoCampania'] as String?,
				nombreCampania: json['nombreCampania'] as String?,
				ordenCampania: json['ordenCampania'] as String?,
			);

	static List<CampaniaSalud> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CampaniaSalud> items =
		bienvenidaList.map((e) => CampaniaSalud.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoCampania": codigoCampania,
			"nombreCampania": nombreCampania,
			"ordenCampania": ordenCampania
		};
	}

}
