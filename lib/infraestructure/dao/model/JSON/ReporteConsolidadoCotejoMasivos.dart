
class ReporteConsolidadoCotejoMasivos {

	String? consecutivo;
	String? dni;
	String? paterno;
	String? materno;
	String? nombres;
	String? fechaProceso;
	String? departamento;
	String? provincia;
	String? distrito;
	String? direccion;

	ReporteConsolidadoCotejoMasivos({
      this.consecutivo,
      this.dni,
      this.paterno,
      this.materno,
      this.nombres,
      this.fechaProceso,
      this.departamento,
      this.provincia,
      this.distrito,
      this.direccion});

	factory ReporteConsolidadoCotejoMasivos.fromJson(dynamic json)  =>
			ReporteConsolidadoCotejoMasivos(
				consecutivo: json['consecutivo'] as String?,
				dni: json['dni'] as String?,
				paterno: json['paterno'] as String?,
				materno: json['materno'] as String?,
				nombres: json['nombres'] as String?,
				fechaProceso: json['fechaProceso'] as String?,
				departamento: json['departamento'] as String?,
				provincia: json['provincia'] as String?,
				distrito: json['distrito'] as String?,
				direccion: json['direccion'] as String?,
			);

	static List<ReporteConsolidadoCotejoMasivos> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ReporteConsolidadoCotejoMasivos> items =
		bienvenidaList.map((e) => ReporteConsolidadoCotejoMasivos.fromJson(e)).toList();
		return items ?? [];
	}
}
