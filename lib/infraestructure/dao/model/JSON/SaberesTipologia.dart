
class SaberesTipologia {

	int? codigoSaberesTipologia;
	String? descripcionTipologia;

	SaberesTipologia({this.codigoSaberesTipologia, this.descripcionTipologia});

	factory SaberesTipologia.fromJson(dynamic json)  =>
			SaberesTipologia(
				codigoSaberesTipologia: json['codigoSaberesTipologia'] as int?,
				descripcionTipologia: json['descripcionTipologia'] as String?,
			);

	static List<SaberesTipologia> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesTipologia> items =
		bienvenidaList.map((e) => SaberesTipologia.fromJson(e)).toList();
		return items ?? [];
	}
}
