
class SaberesNivel {

	int? codigoSaberesNivel;
	String? descripcionNivel;

	SaberesNivel({this.codigoSaberesNivel, this.descripcionNivel});

	factory SaberesNivel.fromJson(dynamic json)  => SaberesNivel(
		codigoSaberesNivel: json['codigoSaberesNivel'] as int?,
		descripcionNivel: json['descripcionNivel'] as String?,
	);

	static List<SaberesNivel> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesNivel> items =
		bienvenidaList.map((e) => SaberesNivel.fromJson(e)).toList();
		return items ?? [];
	}
}
