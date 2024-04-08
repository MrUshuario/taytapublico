import 'package:floor/floor.dart';
@entity
class Saneamiento {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoSaneamiento;
	String? nombreSaneamiento;

	Saneamiento({this.id, this.codigoSaneamiento, this.nombreSaneamiento});

	factory Saneamiento.fromJson(dynamic json)  => Saneamiento(
		id: json['id'] as int?,
		codigoSaneamiento: json['codigoSaneamiento'] as String?,
		nombreSaneamiento: json['nombreSaneamiento'] as String?,
	);

	static List<Saneamiento> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Saneamiento> items =
		bienvenidaList.map((e) => Saneamiento.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoSaneamiento": codigoSaneamiento,
			"nombreSaneamiento": nombreSaneamiento
		};
	}

}
