import 'package:floor/floor.dart';
@entity
class TipoVictima {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoTipoVictima;
	String? descripcionVictima;

	TipoVictima({this.id, this.codigoTipoVictima, this.descripcionVictima});

	factory TipoVictima.fromJson(dynamic json)  => TipoVictima(
		id: json['id'] as int?,
		codigoTipoVictima: json['codigoTipoVictima'] as String?,
		descripcionVictima: json['descripcionVictima'] as String?,
	);

	static List<TipoVictima> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<TipoVictima> items =
		bienvenidaList.map((e) => TipoVictima.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoTipoVictima": codigoTipoVictima,
			"descripcionVictima": descripcionVictima
		};
	}


}
