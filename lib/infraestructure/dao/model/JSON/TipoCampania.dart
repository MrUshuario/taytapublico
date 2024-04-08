
class TipoCampania {
	
	int? codigoTipoCampania;
	String? descripcionCampania;

	TipoCampania({this.codigoTipoCampania, this.descripcionCampania});

	factory TipoCampania.fromJson(dynamic json)  => TipoCampania(
		codigoTipoCampania: json['codigoTipoCampania'] as int?,
		descripcionCampania: json['descripcionCampania'] as String?,
	);

	static List<TipoCampania> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<TipoCampania> items =
		bienvenidaList.map((e) => TipoCampania.fromJson(e)).toList();
		return items ?? [];
	}

}
