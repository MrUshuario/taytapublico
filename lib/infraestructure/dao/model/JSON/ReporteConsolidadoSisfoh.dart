
class ReporteConsolidadoSisfoh {

	String? numeroLista;
	String? numeroIdentificacion;
	String? sprimerApellido;
	String? ssegundoApellido;
	String? snombres;
	String? sfechaNacimiento;
	String? sedad;
	String? nombreDepartamento;
	String? nombreProvincia;
	String? nombreDistrito;
	String? sDireccion;
	String? fechaAsignaCset;
	String? fechaCaducidadCset;
	String? listaVigente;
	String? documento;

	ReporteConsolidadoSisfoh({
      this.numeroLista,
      this.numeroIdentificacion,
      this.sprimerApellido,
      this.ssegundoApellido,
      this.snombres,
      this.sfechaNacimiento,
      this.sedad,
      this.nombreDepartamento,
      this.nombreProvincia,
      this.nombreDistrito,
      this.sDireccion,
      this.fechaAsignaCset,
			this.fechaCaducidadCset,
      this.listaVigente,
      this.documento});

	factory ReporteConsolidadoSisfoh.fromJson(dynamic json)  =>
			ReporteConsolidadoSisfoh(
				numeroLista: json['numeroLista'] as String?,
				numeroIdentificacion: json['numeroIdentificacion'] as String?,
				sprimerApellido: json['sprimerApellido'] as String?,
				ssegundoApellido: json['ssegundoApellido'] as String?,
				snombres: json['snombres'] as String?,
				sfechaNacimiento: json['sfechaNacimiento'] as String?,
				sedad: json['sedad'] as String?,
				nombreDepartamento: json['nombreDepartamento'] as String?,
				nombreProvincia: json['nombreProvincia'] as String?,
				nombreDistrito: json['nombreDistrito'] as String?,
				sDireccion: json['sDireccion'] as String?,
				fechaAsignaCset: json['fechaAsignaCset'] as String?,
				fechaCaducidadCset: json['fechaCaducidadCset'] as String?,
				listaVigente: json['listaVigente'] as String?,
				documento: json['documento'] as String?,
			);

	static List<ReporteConsolidadoSisfoh> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ReporteConsolidadoSisfoh> items =
		bienvenidaList.map((e) => ReporteConsolidadoSisfoh.fromJson(e)).toList();
		return items ?? [];
	}

}
