
class Diagnostico {

	int? codigoDiagnostico;
	String? diagnostico;

	Diagnostico({this.codigoDiagnostico, this.diagnostico});

	factory Diagnostico.fromJson(dynamic json)  => Diagnostico(
		codigoDiagnostico: json['codigoDiagnostico'] as int?,
		diagnostico: json['diagnostico'] as String?,
	);

	static List<Diagnostico> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Diagnostico> items =
		bienvenidaList.map((e) => Diagnostico.fromJson(e)).toList();
		return items ?? [];
	}

}
