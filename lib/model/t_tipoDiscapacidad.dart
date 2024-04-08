import 'package:floor/floor.dart';
@entity
class TipoDiscapacidad {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoTipoDiscapacidad;
	String? descripcionTipoDiscapacidad;

	TipoDiscapacidad({this.id, this.codigoTipoDiscapacidad, this.descripcionTipoDiscapacidad});

	factory TipoDiscapacidad.fromJson(dynamic json) {
		return TipoDiscapacidad(
				id: json['id'],
				codigoTipoDiscapacidad: json['codigoTipoDiscapacidad'],
				descripcionTipoDiscapacidad: json['descripcionTipoDiscapacidad']
		);
	}


	static List<TipoDiscapacidad> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<TipoDiscapacidad> items =
		bienvenidaList.map((e) => TipoDiscapacidad.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoTipoDiscapacidad": codigoTipoDiscapacidad,
			"descripcionTipoDiscapacidad": descripcionTipoDiscapacidad
		};
	}
	
}
