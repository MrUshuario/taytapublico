import 'package:floor/floor.dart';
@entity
 class Ubigeo {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoImei;
	String? nombre_departamento;
	String? nombre_provincia;
	String? nombre_distrito;

	Ubigeo({this.id, this.codigoImei, this.nombre_departamento,
      this.nombre_provincia, this.nombre_distrito});

	factory Ubigeo.fromJson(dynamic json) => Ubigeo(
		id: json['id'] as int?,
		codigoImei: json['codigoImei'] as String?,
		nombre_departamento: json['nombre_departamento'] as String?,
		nombre_provincia: json['nombre_provincia'] as String?,
		nombre_distrito: json['nombre_distrito'] as String?,
	);

	static List<Ubigeo> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Ubigeo> items =
		bienvenidaList.map((e) => Ubigeo.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoImei": codigoImei,
			"nombre_departamento": nombre_departamento,
			"nombre_provincia": nombre_provincia,
			"nombre_distrito": nombre_distrito
		};
	}


}
