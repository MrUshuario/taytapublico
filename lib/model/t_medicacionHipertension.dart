import 'package:floor/floor.dart';
@entity
class MedicacionHipertension {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoMedicacionHipertension;
	String? medicacion;

	MedicacionHipertension({this.id, this.codigoMedicacionHipertension, this.medicacion});

	factory MedicacionHipertension.fromJson(dynamic json)  => MedicacionHipertension(
		id: json['id'] as int?,
		codigoMedicacionHipertension: json['codigoMedicacionHipertension'] as String?,
		medicacion: json['medicacion'] as String?,
	);

	static List<MedicacionHipertension> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<MedicacionHipertension> items =
		bienvenidaList.map((e) => MedicacionHipertension.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoMedicacionHipertension": codigoMedicacionHipertension,
			"medicacion": medicacion
		};
	}


}
