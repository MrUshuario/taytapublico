import 'package:floor/floor.dart';
@entity
class Pared {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoPared;
	String? nombrePared;

	Pared({this.id, this.codigoPared, this.nombrePared});

	factory Pared.fromJson(dynamic json)  => Pared(
		id: json['id'] as int?,
		codigoPared: json['codigoPared'] as String?,
		nombrePared: json['nombrePared'] as String?,
	);

	static List<Pared> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Pared> items =
		bienvenidaList.map((e) => Pared.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoPared": codigoPared,
			"nombrePared": nombrePared
		};
	}

}
