import 'package:floor/floor.dart';

@entity
class AsistenciaTecnica {

	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoAsistenciaTecnica;
	String? descripcionAsistenciaTecnica;

	AsistenciaTecnica({this.id, this.codigoAsistenciaTecnica, this.descripcionAsistenciaTecnica});

	factory AsistenciaTecnica.fromJson(dynamic json) =>
			AsistenciaTecnica(
				id: json['id'],
				codigoAsistenciaTecnica: json['codigoAsistenciaTecnica'],
				descripcionAsistenciaTecnica: json['descripcionAsistenciaTecnica'],
			);

	static List<AsistenciaTecnica> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<AsistenciaTecnica> items =
		bienvenidaList.map((e) => AsistenciaTecnica.fromJson(e)).toList();
		return items ?? [];
	}


	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoAsistenciaTecnica": codigoAsistenciaTecnica,
			"descripcionAsistenciaTecnica": descripcionAsistenciaTecnica,
		};
	}

}
