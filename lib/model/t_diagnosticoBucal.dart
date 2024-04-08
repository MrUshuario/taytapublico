import 'package:floor/floor.dart';
@entity
class DiagnosticoBucal {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoDiagnosticoBucal;
	String? diagnostico;

	DiagnosticoBucal({this.id, this.codigoDiagnosticoBucal, this.diagnostico});

	factory DiagnosticoBucal.fromJson(dynamic json)  => DiagnosticoBucal(
		id: json['id'] as int?,
		codigoDiagnosticoBucal: json['codigoDiagnosticoBucal'] as String?,
		diagnostico: json['diagnostico'] as String?,
	);

	static List<DiagnosticoBucal> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<DiagnosticoBucal> items =
		bienvenidaList.map((e) => DiagnosticoBucal.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoDiagnosticoBucal": codigoDiagnosticoBucal,
			"diagnostico": diagnostico,
		};
	}

}
