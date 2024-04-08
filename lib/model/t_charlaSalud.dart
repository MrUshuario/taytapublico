import 'package:floor/floor.dart';
@entity
class CharlaSalud {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoCharlaSalud;
	String? charlaSalud;

	CharlaSalud({this.id, this.codigoCharlaSalud, this.charlaSalud});

	factory CharlaSalud.fromJson(dynamic json)  => CharlaSalud(
		id: json['id'] as int?,
		codigoCharlaSalud: json['codigoCharlaSalud'] as String?,
		charlaSalud: json['charlaSalud'] as String?,
	);

	static List<CharlaSalud> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CharlaSalud> items =
		bienvenidaList.map((e) => CharlaSalud.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoCharlaSalud": codigoCharlaSalud,
			"charlaSalud": charlaSalud
		};
	}

}
