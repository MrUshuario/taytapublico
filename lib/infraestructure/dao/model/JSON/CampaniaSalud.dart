
class CampaniaSalud {

	int? codigoCampania;
	String? descripcion;
	int? orden;

	CampaniaSalud({this.codigoCampania, this.descripcion, this.orden});

	factory CampaniaSalud.fromJson(dynamic json)  =>
			CampaniaSalud(
				codigoCampania: json['codigoCampania'] as int?,
				descripcion: json['descripcion'] as String?,
				orden: json['orden'] as int?,
			);

	static List<CampaniaSalud> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CampaniaSalud> items =
		bienvenidaList.map((e) => CampaniaSalud.fromJson(e)).toList();
		return items ?? [];
	}

}
