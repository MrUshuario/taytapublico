
 class SaberesTema {
	
	int? codigoSaberesTema;
	String? descripcionTema;

	SaberesTema({this.codigoSaberesTema, this.descripcionTema});

	factory SaberesTema.fromJson(dynamic json)  => SaberesTema(
		codigoSaberesTema: json['codigoSaberesTema'] as int?,
		descripcionTema: json['descripcionTema'] as String?,
	);

	static List<SaberesTema> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesTema> items =
		bienvenidaList.map((e) => SaberesTema.fromJson(e)).toList();
		return items ?? [];
	}

}
