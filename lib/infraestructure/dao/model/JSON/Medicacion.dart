
class Medicacion {

	int? codigoMedicacion;
	String? medicacion;

	Medicacion({this.codigoMedicacion, this.medicacion});

	factory Medicacion.fromJson(dynamic json)  => Medicacion(
		codigoMedicacion: json['codigoMedicacion'] as int?,
		medicacion: json['medicacion'] as String?,
	);

	static List<Medicacion> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Medicacion> items =
		bienvenidaList.map((e) => Medicacion.fromJson(e)).toList();
		return items ?? [];
	}

}
