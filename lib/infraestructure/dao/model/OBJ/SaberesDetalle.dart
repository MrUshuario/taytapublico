 class SaberesDetalle {
	
	int? idVisita;
	int? codigoSaberesTipologia;
	String? dato;

	SaberesDetalle({this.idVisita, this.codigoSaberesTipologia, this.dato});

	factory SaberesDetalle.fromJson(dynamic json)  => SaberesDetalle(
		idVisita: json['idVisita'],
		codigoSaberesTipologia: json['codigoSaberesTipologia'],
		dato: json['dato'],
	);

	static List<SaberesDetalle> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesDetalle> items =
		bienvenidaList.map((e) => SaberesDetalle.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"idVisita": idVisita,
			"codigoSaberesTipologia": codigoSaberesTipologia,
			"dato": dato
		};
	}
	
}
