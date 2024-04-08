import 'package:floor/floor.dart';
@entity
class SaberesProductivosSubTipologia {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? descripcionSubTipologia;
	String? codigoSaberesTipologia;

	SaberesProductivosSubTipologia({this.id,
      this.descripcionSubTipologia, this.codigoSaberesTipologia});

	factory SaberesProductivosSubTipologia.fromJson(dynamic json) =>
			SaberesProductivosSubTipologia(
				id: json['id'] as int?,
				descripcionSubTipologia: json['descripcionSubTipologia'] as String?,
				codigoSaberesTipologia: json['codigoSaberesTipologia'] as String?,
			);

	static List<SaberesProductivosSubTipologia> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesProductivosSubTipologia> items =
		bienvenidaList.map((e) => SaberesProductivosSubTipologia.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"descripcionSubTipologia": descripcionSubTipologia,
			"codigoSaberesTipologia": codigoSaberesTipologia
		};
	}

}
