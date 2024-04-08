
class ReporteConsolidadoDeclaracionesJuradas {

	String? numeroIdentificacion;
	String? primerApellido;
	String? segundoApellido;
	String? nombres;
	String? sexo;
	String? departamento;
	String? provincia;
	String? distrito;
	String? fechaDdjj;
	String? documento;
	String? fechaCreacion;
	String? direccion;
	String? ddjjValida;

	ReporteConsolidadoDeclaracionesJuradas({
      this.numeroIdentificacion,
      this.primerApellido,
      this.segundoApellido,
      this.nombres,
      this.sexo,
      this.departamento,
      this.provincia,
      this.distrito,
      this.fechaDdjj,
      this.documento,
			this.fechaCreacion,
      this.direccion,
      this.ddjjValida});

	factory ReporteConsolidadoDeclaracionesJuradas.fromJson(dynamic json)  =>
			ReporteConsolidadoDeclaracionesJuradas(
				numeroIdentificacion: json['numeroIdentificacion'] as String?,
				primerApellido: json['primerApellido'] as String?,
				segundoApellido: json['segundoApellido'] as String?,
				nombres: json['nombres'] as String?,
				sexo: json['sexo'] as String?,
				departamento: json['departamento'] as String?,
				provincia: json['provincia'] as String?,
				distrito: json['distrito'] as String?,
				fechaDdjj: json['fechaDdjj'] as String?,
				documento: json['documento'] as String?,
				fechaCreacion: json['fechaCreacion'] as String?,
				direccion: json['direccion'] as String?,
				ddjjValida: json['ddjjValida'] as String?,
			);

	static List<ReporteConsolidadoDeclaracionesJuradas> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ReporteConsolidadoDeclaracionesJuradas> items =
		bienvenidaList.map((e) => ReporteConsolidadoDeclaracionesJuradas.fromJson(e)).toList();
		return items ?? [];
	}

}
