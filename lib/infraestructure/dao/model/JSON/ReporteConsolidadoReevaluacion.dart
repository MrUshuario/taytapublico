
class ReporteConsolidadoReevaluacion {
	
	String? consecutivo;
	String? dni;
	String? paterno;
	String? materno;
	String? nombres;
	String? fechaOficio;
	String? departamento;
	String? provincia;
	String? distrito;
	String? referencia;

	ReporteConsolidadoReevaluacion({
      this.consecutivo,
      this.dni,
      this.paterno,
      this.materno,
      this.nombres,
      this.fechaOficio,
      this.departamento,
      this.provincia,
      this.distrito,
      this.referencia});

	factory ReporteConsolidadoReevaluacion.fromJson(dynamic json)  =>
			ReporteConsolidadoReevaluacion(
				consecutivo: json['consecutivo'] as String?,
				dni: json['dni'] as String?,
				paterno: json['paterno'] as String?,
				materno: json['materno'] as String?,
				nombres: json['nombres'] as String?,
				fechaOficio: json['fechaOficio'] as String?,
				departamento: json['departamento'] as String?,
				provincia: json['provincia'] as String?,
				distrito: json['distrito'] as String?,
				referencia: json['referencia'] as String?,
			);

	static List<ReporteConsolidadoReevaluacion> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ReporteConsolidadoReevaluacion> items =
		bienvenidaList.map((e) => ReporteConsolidadoReevaluacion.fromJson(e)).toList();
		return items ?? [];
	}
}
