import 'package:floor/floor.dart';
@entity
class Agua {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoAgua;
	String? nombreAgua;

	Agua({this.id, this.codigoAgua, this.nombreAgua});

	factory Agua.fromJson(dynamic json)  => Agua(
		id: json['id'] as int?,
		codigoAgua: json['codigoAgua'] as String?,
		nombreAgua: json['nombreAgua'] as String?,
	);

	static List<Agua> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Agua> items =
		bienvenidaList.map((e) => Agua.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoAgua": codigoAgua,
			"nombreAgua": nombreAgua
		};
	}

}
