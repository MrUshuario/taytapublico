
class Instancia {
	
	int? codigoInstancia;
	String? instancia;

	Instancia({this.codigoInstancia, this.instancia});

	factory Instancia.fromJson(dynamic json)  => Instancia(
		codigoInstancia: json['codigoInstancia'] as int?,
		instancia: json['instancia'] as String?,
	);

	static List<Instancia> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Instancia> items =
		bienvenidaList.map((e) => Instancia.fromJson(e)).toList();
		return items ?? [];
	}
}
