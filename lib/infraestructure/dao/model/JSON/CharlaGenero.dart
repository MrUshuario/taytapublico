
class CharlaGenero {
	
	int? codigoCharlaGenero;
	String? descripcionCharlaGenero;

	CharlaGenero({this.codigoCharlaGenero, this.descripcionCharlaGenero});

	factory CharlaGenero.fromJson(dynamic json)  => CharlaGenero(
		codigoCharlaGenero: json['codigoCharlaGenero'] as int?,
		descripcionCharlaGenero: json['descripcionCharlaGenero'] as String?,
	);

	static List<CharlaGenero> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CharlaGenero> items =
		bienvenidaList.map((e) => CharlaGenero.fromJson(e)).toList();
		return items ?? [];
	}

}
