import 'package:floor/floor.dart';
@entity
class SaberesProductivosNivel {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoSaberesProductivosNivel;
	String? descripcionNivel;

	SaberesProductivosNivel({this.id, this.codigoSaberesProductivosNivel, this.descripcionNivel});

	factory SaberesProductivosNivel.fromJson(dynamic json)  => SaberesProductivosNivel(
		id: json['id'] as int?,
		codigoSaberesProductivosNivel: json['codigoSaberesProductivosNivel'] as String?,
		descripcionNivel: json['descripcionNivel'] as String?,
	);

	static List<SaberesProductivosNivel> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesProductivosNivel> items =
		bienvenidaList.map((e) => SaberesProductivosNivel.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoSaberesProductivosNivel": codigoSaberesProductivosNivel,
			"descripcionNivel": descripcionNivel
		};
	}

}
