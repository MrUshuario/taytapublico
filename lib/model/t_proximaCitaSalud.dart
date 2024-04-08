import 'package:floor/floor.dart';
@entity
class ProximaCitaSalud {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoProximaCita;
	String? descripcion;

	ProximaCitaSalud({this.id, this.codigoProximaCita, this.descripcion});

	factory ProximaCitaSalud.fromJson(dynamic json)  =>
			ProximaCitaSalud(
				id: json['id'] as int?,
				codigoProximaCita: json['codigoProximaCita'] as String?,
				descripcion: json['descripcion'] as String?,
			);

	static List<ProximaCitaSalud> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ProximaCitaSalud> items =
		bienvenidaList.map((e) => ProximaCitaSalud.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoProximaCita": codigoProximaCita,
			"descripcion": descripcion
		};
	}

}
