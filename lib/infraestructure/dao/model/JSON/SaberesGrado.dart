
class SaberesGrado {

	int? codigoSaberesGrado;
	String? descripcionGrado;
	int? orden;

	SaberesGrado({this.codigoSaberesGrado, this.descripcionGrado, this.orden});

	factory SaberesGrado.fromJson(dynamic json) => SaberesGrado(
		codigoSaberesGrado: json['codigoSaberesGrado'] as int?,
		descripcionGrado: json['descripcionGrado'] as String?,
		orden: json['orden'] as int?,
	);

	static List<SaberesGrado> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesGrado> items =
		bienvenidaList.map((e) => SaberesGrado.fromJson(e)).toList();
		return items ?? [];
	}

}
