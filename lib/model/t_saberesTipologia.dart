import 'package:floor/floor.dart';
@entity
class SaberesTipologia {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String?	saberesTipologia;
	String? codigoSaberesTipologia;
	String? descripcionTipologia;

	SaberesTipologia({this.id, this.saberesTipologia, this.codigoSaberesTipologia, this.descripcionTipologia});

	factory SaberesTipologia.fromJson(dynamic json)  =>
			SaberesTipologia(
				id: json['id'] as int?,
				saberesTipologia: json['saberesTipologia'] as String?,
				codigoSaberesTipologia: json['codigoSaberesTipologia'] as String?,
				descripcionTipologia: json['descripcionTipologia'] as String?,
			);

	static List<SaberesTipologia> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesTipologia> items =
		bienvenidaList.map((e) => SaberesTipologia.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"saberesTipologia": saberesTipologia,
			"codigoSaberesTipologia": codigoSaberesTipologia,
			"descripcionTipologia": descripcionTipologia
		};
	}

}
