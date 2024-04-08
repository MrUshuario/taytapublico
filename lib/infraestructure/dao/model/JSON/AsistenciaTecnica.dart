
class AsistenciaTecnica {

	int? codigoAsistencia;
	String? descripcion;

	AsistenciaTecnica({this.codigoAsistencia, this.descripcion});

	factory AsistenciaTecnica.fromJson(dynamic json) =>
			AsistenciaTecnica(
				codigoAsistencia: json['codigoAsistencia'] as int?,
				descripcion: json['descripcion'] as String?,
			);

	static List<AsistenciaTecnica> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<AsistenciaTecnica> items =
		bienvenidaList.map((e) => AsistenciaTecnica.fromJson(e)).toList();
		return items ?? [];
	}

}
