import 'package:floor/floor.dart';
@entity
class MedicacionDiabetes {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoMedicacionDiabetes;
	String? medicacion;

	MedicacionDiabetes({this.id, this.codigoMedicacionDiabetes, this.medicacion});

	factory MedicacionDiabetes.fromJson(dynamic json)  => MedicacionDiabetes(
		id: json['id'] as int?,
		codigoMedicacionDiabetes: json['codigoMedicacionDiabetes'] as String?,
		medicacion: json['medicacion'] as String?,
	);

	static List<MedicacionDiabetes> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<MedicacionDiabetes> items =
		bienvenidaList.map((e) => MedicacionDiabetes.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoMedicacionDiabetes": codigoMedicacionDiabetes,
			"medicacion": medicacion
		};
	}

}
