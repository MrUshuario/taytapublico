
class PeriodoDiagnostico {

	int? codigoPeriodoDiagnostico;
	String? descripcion;

	PeriodoDiagnostico({this.codigoPeriodoDiagnostico, this.descripcion});

	factory PeriodoDiagnostico.fromJson(dynamic json)  =>
			PeriodoDiagnostico(
				codigoPeriodoDiagnostico: json['codigoPeriodoDiagnostico'] as int?,
				descripcion: json['descripcion'] as String?,
			);

	static List<PeriodoDiagnostico> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<PeriodoDiagnostico> items =
		bienvenidaList.map((e) => PeriodoDiagnostico.fromJson(e)).toList();
		return items ?? [];
	}

}
