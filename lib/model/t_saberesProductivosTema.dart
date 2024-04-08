import 'package:floor/floor.dart';
@entity
 class SaberesProductivosTema {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoSaberesTema;
	String? descripcionTema;
	String? codigoSaberesTema2;
	String? descripcionTema2;

	SaberesProductivosTema({this.id, this.codigoSaberesTema, this.descripcionTema, this.codigoSaberesTema2, this.descripcionTema2});

	factory SaberesProductivosTema.fromJson(dynamic json)  => SaberesProductivosTema(
		id: json['id'] as int?,
		codigoSaberesTema: json['descripcionTema'] as String?,
		descripcionTema: json['descripcionTema'] as String?,
		codigoSaberesTema2: json['codigoSaberesTema2'] as String?,
		descripcionTema2: json['descripcionTema2'] as String?,
	);

	static List<SaberesProductivosTema> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesProductivosTema> items =
		bienvenidaList.map((e) => SaberesProductivosTema.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoSaberesTema": codigoSaberesTema,
			"descripcionTema": descripcionTema,
			"codigoSaberesTema2": codigoSaberesTema2,
			"descripcionTema2": descripcionTema2,
		};
	}

}
