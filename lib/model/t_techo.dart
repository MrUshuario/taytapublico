import 'package:floor/floor.dart';
@entity
class Techo {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoTecho;
	String? nombreTecho;

	Techo({this.id, this.codigoTecho, this.nombreTecho});

	factory Techo.fromJson(dynamic json)  => Techo(
		id: json['id'] as int?,
		codigoTecho: json['codigoTecho'] as String?,
		nombreTecho: json['nombreTecho'] as String?,
	);

	static List<Techo> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Techo> items =
		bienvenidaList.map((e) => Techo.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoTecho": codigoTecho,
			"nombreTecho": nombreTecho
		};
	}

}
