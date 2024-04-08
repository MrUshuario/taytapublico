import 'package:floor/floor.dart';
@entity
class SaberesProductivoGrado {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoSaberesProductivoGrado;
	String? descripcionGrado;
	String? orden;

	SaberesProductivoGrado({this.id, this.codigoSaberesProductivoGrado, this.descripcionGrado, this.orden});

	factory SaberesProductivoGrado.fromJson(dynamic json) => SaberesProductivoGrado(
		id: json['id'] as int?,
		codigoSaberesProductivoGrado: json['codigoSaberesProductivoGrado'] as String?,
		descripcionGrado: json['descripcionGrado'] as String?,
		orden: json['orden'] as String?,
	);

	static List<SaberesProductivoGrado> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesProductivoGrado> items =
		bienvenidaList.map((e) => SaberesProductivoGrado.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoSaberesProductivoGrado": codigoSaberesProductivoGrado,
			"descripcionGrado": descripcionGrado,
			"orden": orden
		};
	}

}
