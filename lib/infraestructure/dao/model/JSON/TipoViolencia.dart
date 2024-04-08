
 class TipoViolencia {

	int? codigoTipoViolencia;
	String? tipoViolencia;

	TipoViolencia({this.codigoTipoViolencia, this.tipoViolencia});

	factory TipoViolencia.fromJson(dynamic json) {
		return TipoViolencia(
				codigoTipoViolencia: json['versionCondicion'],
				tipoViolencia: json['versionOperadores']);
	}


	static List<TipoViolencia> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<TipoViolencia> items =
		bienvenidaList.map((e) => TipoViolencia.fromJson(e)).toList();
		return items ?? [];
	}


}
