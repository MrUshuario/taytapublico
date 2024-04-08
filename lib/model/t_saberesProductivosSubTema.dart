import 'package:floor/floor.dart';
@entity
class SaberesProductivosSubTema {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoSaberesProductivosSubTema;
	String? descripcionSubTema;
	String? codigoSaberesTema;

	SaberesProductivosSubTema({this.id, this.codigoSaberesProductivosSubTema, this.descripcionSubTema,
      this.codigoSaberesTema});

	factory SaberesProductivosSubTema.fromJson(dynamic json)  =>
			SaberesProductivosSubTema(
				id: json['id'] as int?,
				codigoSaberesProductivosSubTema: json['codigoSaberesProductivosSubTema'] as String?,
				descripcionSubTema: json['descripcionSubTema'] as String?,
				codigoSaberesTema: json['codigoSaberesTema'] as String?,
			);

	static List<SaberesProductivosSubTema> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesProductivosSubTema> items =
		bienvenidaList.map((e) => SaberesProductivosSubTema.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoSaberesProductivosSubTema": codigoSaberesProductivosSubTema,
			"descripcionSubTema": descripcionSubTema,
			"codigoSaberesTema": codigoSaberesTema
		};
	}

}
