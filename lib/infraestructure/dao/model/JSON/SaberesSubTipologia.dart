
class SaberesSubTipologia {
	
	int? codigoSaberesSubTipologia;
	String? descripcionSubTipologia;
	int? codigoSaberesTipologia;

	SaberesSubTipologia({this.codigoSaberesSubTipologia,
      this.descripcionSubTipologia, this.codigoSaberesTipologia});

	factory SaberesSubTipologia.fromJson(dynamic json) =>
			SaberesSubTipologia(
				codigoSaberesSubTipologia: json['codigoSaberesSubTipologia'] as int?,
				descripcionSubTipologia: json['descripcionSubTipologia'] as String?,
				codigoSaberesTipologia: json['codigoSaberesTipologia'] as int?,
			);

	static List<SaberesSubTipologia> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesSubTipologia> items =
		bienvenidaList.map((e) => SaberesSubTipologia.fromJson(e)).toList();
		return items ?? [];
	}

}
