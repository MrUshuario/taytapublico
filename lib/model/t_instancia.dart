import 'package:floor/floor.dart';
@entity
class Instancia {

	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoInstancia;
	String? instancia;

	Instancia({this.id, this.codigoInstancia, this.instancia});

	factory Instancia.fromJson(dynamic json)  => Instancia(
		id: json['id'] as int?,
		codigoInstancia: json['codigoInstancia'] as String?,
		instancia: json['instancia'] as String?,
	);

	static List<Instancia> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Instancia> items =
		bienvenidaList.map((e) => Instancia.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoInstancia": codigoInstancia,
			"instancia": instancia,
		};
	}

}
