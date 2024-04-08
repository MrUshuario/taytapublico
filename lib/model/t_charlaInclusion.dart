import 'package:floor/floor.dart';
@entity
class CharlaInclusion {
	//ERRONEAMENTE LE DICEN CHARLA FINANCIERA EN EL ANTIGUO
	@PrimaryKey(autoGenerate: true)
	int?  id;
	String? codigoCharlaInclusion;
	String? descripcionCharlaInclusion;

	CharlaInclusion({this.id, this.codigoCharlaInclusion, this.descripcionCharlaInclusion});

	factory CharlaInclusion.fromJson(dynamic json)  =>
			CharlaInclusion(
				id: json['id'] as int?,
				codigoCharlaInclusion: json['codigoCharlaInclusion'] as String?,
				descripcionCharlaInclusion: json['descripcionCharlaInclusion'] as String?,
			);

	static List<CharlaInclusion> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CharlaInclusion> items =
		bienvenidaList.map((e) => CharlaInclusion.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoCharlaInclusion": codigoCharlaInclusion,
			"descripcionCharlaInclusion": descripcionCharlaInclusion
		};
	}

}
