import 'package:floor/floor.dart';
@entity
class PeriodoDiagnostico {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoPeriodoDiagnostico;
	String? descripcion;

	PeriodoDiagnostico({this.id, this.codigoPeriodoDiagnostico, this.descripcion});

	factory PeriodoDiagnostico.fromJson(dynamic json)  =>
			PeriodoDiagnostico(
				id: json['id'] as int?,
				codigoPeriodoDiagnostico: json['codigoPeriodoDiagnostico'] as String?,
				descripcion: json['descripcion'] as String?,
			);

	static List<PeriodoDiagnostico> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<PeriodoDiagnostico> items =
		bienvenidaList.map((e) => PeriodoDiagnostico.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoPeriodoDiagnostico": codigoPeriodoDiagnostico,
			"descripcion": descripcion
		};
	}

}
