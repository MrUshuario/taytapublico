
class CharlaDiscapacidad {

	int? codigoCharlaDiscapacidad;
	String? charlaDiscapacidad;

	CharlaDiscapacidad({this.codigoCharlaDiscapacidad, this.charlaDiscapacidad});

	factory CharlaDiscapacidad.fromJson(dynamic json)  =>
			CharlaDiscapacidad(
				codigoCharlaDiscapacidad: json['codigoCharlaDiscapacidad'] as int?,
				charlaDiscapacidad: json['charlaDiscapacidad'] as String?,
			);

	static List<CharlaDiscapacidad> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CharlaDiscapacidad> items =
		bienvenidaList.map((e) => CharlaDiscapacidad.fromJson(e)).toList();
		return items ?? [];
	}

}
