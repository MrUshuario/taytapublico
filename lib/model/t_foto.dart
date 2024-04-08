import 'package:floor/floor.dart';
@entity
class Foto {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? path;
	int? codigoVisita;

	Foto({this.id, this.path, this.codigoVisita});

	factory Foto.fromJson(dynamic json)  => Foto(
		id: json['id'] as int?,
		path: json['path'] as String?,
		codigoVisita: json['codigoVisita'] as int?,
	);

	static List<Foto> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Foto> items =
		bienvenidaList.map((e) => Foto.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"path": path,
			"codigoVisita": codigoVisita
		};
	}

}
