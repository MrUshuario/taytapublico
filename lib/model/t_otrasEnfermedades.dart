import 'package:floor/floor.dart';
@entity
class OtrasEnfermedad {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoCharlaSalud;
	String? descripcionOtrasEnfermedades;

	OtrasEnfermedad({this.id, this.codigoCharlaSalud, this.descripcionOtrasEnfermedades});

	factory OtrasEnfermedad.fromJson(dynamic json)  => OtrasEnfermedad(
		id: json['id'] as int?,
		codigoCharlaSalud: json['codigoCharlaSalud'] as String?,
		descripcionOtrasEnfermedades: json['descripcionOtrasEnfermedades'] as String?,
	);

	static List<OtrasEnfermedad> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<OtrasEnfermedad> items =
		bienvenidaList.map((e) => OtrasEnfermedad.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoCharlaSalud": codigoCharlaSalud,
			"descripcionOtrasEnfermedades": descripcionOtrasEnfermedades
		};
	}

}
