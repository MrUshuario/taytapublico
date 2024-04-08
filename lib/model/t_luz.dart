import 'package:floor/floor.dart';
@entity
class Luz {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoLuz;
	String? nombreLuz;

	Luz({this.id, this.codigoLuz, this.nombreLuz});

	factory Luz.fromJson(dynamic json)  => Luz(
		id: json['id'] as int?,
		codigoLuz: json['codigoLuz'] as String?,
		nombreLuz: json['nombreLuz'] as String?,
	);

	static List<Luz> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Luz> items =
		bienvenidaList.map((e) => Luz.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoLuz": codigoLuz,
			"nombreLuz": nombreLuz
		};
	}

}
