
class CharlaSalud {
	
	int? codigoCharlaSalud;
	String? charlaSalud;

	CharlaSalud({this.codigoCharlaSalud, this.charlaSalud});

	factory CharlaSalud.fromJson(dynamic json)  => CharlaSalud(
		codigoCharlaSalud: json['codigoCharlaSalud'] as int?,
		charlaSalud: json['charlaSalud'] as String?,
	);

	static List<CharlaSalud> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CharlaSalud> items =
		bienvenidaList.map((e) => CharlaSalud.fromJson(e)).toList();
		return items ?? [];
	}
}
