import 'package:floor/floor.dart';
@entity
class TipoCampania {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoTipoCampania;
	String? descripcionCampania;

	TipoCampania({this.id, this.codigoTipoCampania, this.descripcionCampania});

	factory TipoCampania.fromJson(dynamic json)  => TipoCampania(
		id: json['id'] as int?,
		codigoTipoCampania: json['codigoTipoCampania'] as String?,
		descripcionCampania: json['descripcionCampania'] as String?,
	);

	static List<TipoCampania> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<TipoCampania> items =
		bienvenidaList.map((e) => TipoCampania.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoTipoCampania": codigoTipoCampania,
			"descripcionCampania": descripcionCampania
		};
	}
}
