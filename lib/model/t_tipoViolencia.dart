import 'package:floor/floor.dart';
@entity
 class TipoViolencia {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoTipoViolencia;
	String? descripcionTipoViolencia;

	TipoViolencia({this.id, this.codigoTipoViolencia, this.descripcionTipoViolencia});

	factory TipoViolencia.fromJson(dynamic json) {
		return TipoViolencia(
				id: json['id'],
				codigoTipoViolencia: json['versionCondicion'],
				descripcionTipoViolencia: json['versionOperadores']);
	}


	static List<TipoViolencia> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<TipoViolencia> items =
		bienvenidaList.map((e) => TipoViolencia.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoTipoViolencia": codigoTipoViolencia,
			"descripcionTipoViolencia": descripcionTipoViolencia
		};
	}


}
