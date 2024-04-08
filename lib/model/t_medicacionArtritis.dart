import 'package:floor/floor.dart';
@entity
class MedicacionArtritis {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoMedicacionArtritis;
	String? medicacion;

	MedicacionArtritis({this.id, this.codigoMedicacionArtritis, this.medicacion});

	factory MedicacionArtritis.fromJson(dynamic json)  => MedicacionArtritis(
		id: json['id'] as int?,
		codigoMedicacionArtritis: json['codigoMedicacionArtritis'] as String?,
		medicacion: json['medicacion'] as String?,
	);

	static List<MedicacionArtritis> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<MedicacionArtritis> items =
		bienvenidaList.map((e) => MedicacionArtritis.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoMedicacionArtritis": codigoMedicacionArtritis,
			"medicacion": medicacion
		};
	}

}
