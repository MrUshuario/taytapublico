
class Enfermedad {
	
	int? codigoEnfermedad;
	String? enfermedad;

	Enfermedad({this.codigoEnfermedad, this.enfermedad});

	factory Enfermedad.fromJson(dynamic json)  => Enfermedad(
		codigoEnfermedad: json['codigoEnfermedad'] as int?,
		enfermedad: json['enfermedad'] as String?,
	);

	static List<Enfermedad> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Enfermedad> items =
		bienvenidaList.map((e) => Enfermedad.fromJson(e)).toList();
		return items ?? [];
	}

}
