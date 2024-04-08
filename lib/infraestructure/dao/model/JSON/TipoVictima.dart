
class TipoVictima {
	
	int? codigoTipoVictima;
	String? tipoVictima;

	TipoVictima({this.codigoTipoVictima, this.tipoVictima});

	factory TipoVictima.fromJson(dynamic json)  => TipoVictima(
		codigoTipoVictima: json['codigoTipoVictima'] as int?,
		tipoVictima: json['tipoVictima'] as String?,
	);

	static List<TipoVictima> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<TipoVictima> items =
		bienvenidaList.map((e) => TipoVictima.fromJson(e)).toList();
		return items ?? [];
	}


}
