
class ProximaCitaSalud {

	int? codigoProximaCita;
	String? descripcion;

	ProximaCitaSalud({this.codigoProximaCita, this.descripcion});

	factory ProximaCitaSalud.fromJson(dynamic json)  =>
			ProximaCitaSalud(
				codigoProximaCita: json['codigoProximaCita'] as int?,
				descripcion: json['descripcion'] as String?,
			);

	static List<ProximaCitaSalud> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ProximaCitaSalud> items =
		bienvenidaList.map((e) => ProximaCitaSalud.fromJson(e)).toList();
		return items ?? [];
	}
}
