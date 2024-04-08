
class SaberesSubTema {
	
	int? codigoSaberesSubTema;
	String? descripcionSubTema;
	int? codigoSaberesTema;

	SaberesSubTema({this.codigoSaberesSubTema, this.descripcionSubTema,
      this.codigoSaberesTema});

	factory SaberesSubTema.fromJson(dynamic json)  =>
			SaberesSubTema(
				codigoSaberesSubTema: json['codigoSaberesSubTema'] as int?,
				descripcionSubTema: json['descripcionSubTema'] as String?,
				codigoSaberesTema: json['codigoSaberesTema'] as int?,
			);

	static List<SaberesSubTema> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesSubTema> items =
		bienvenidaList.map((e) => SaberesSubTema.fromJson(e)).toList();
		return items ?? [];
	}
}
