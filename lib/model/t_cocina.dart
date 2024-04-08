import 'package:floor/floor.dart';
@entity
class Cocina {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoCocina;
	String? nombreCocina;

	Cocina({this.id, this.codigoCocina, this.nombreCocina});

	factory Cocina.fromJson(dynamic json)  => Cocina(
		id: json['id'] as int?,
		codigoCocina: json['codigoCocina'] as String?,
		nombreCocina: json['nombreCocina'] as String?,
	);

	static List<Cocina> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Cocina> items =
		bienvenidaList.map((e) => Cocina.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoCocina": codigoCocina,
			"nombreCocina": nombreCocina
		};
	}

}
