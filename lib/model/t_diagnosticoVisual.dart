import 'package:floor/floor.dart';
@entity
class DiagnosticoVisual {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoDiagnosticoVisual;
	String? diagnostico;

	DiagnosticoVisual({this.id, this.codigoDiagnosticoVisual, this.diagnostico});

	factory DiagnosticoVisual.fromJson(dynamic json)  => DiagnosticoVisual(
		id: json['id'] as int?,
		codigoDiagnosticoVisual: json['codigoDiagnosticoVisual'] as String?,
		diagnostico: json['diagnostico'] as String?,
	);

	static List<DiagnosticoVisual> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<DiagnosticoVisual> items =
		bienvenidaList.map((e) => DiagnosticoVisual.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoDiagnosticoVisual": codigoDiagnosticoVisual,
			"diagnostico": diagnostico,
		};
	}

}
