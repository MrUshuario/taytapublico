
class ReporteConsolidadoVerificaciones {

	String? dni;
	String? nombres;
	String? ubigeo;
	String? actividad;
	String? condicion;
	String? sustento;
	String? ddjj;
	String? indicaCta;
	String? ctaVigilada;
	String? onp;
	String? sbs;
	String? esSalud;
	String? reincorporado;
	String? priorizado;
	String? visitado;
	String? foto;
	String? georeferencia;
	String? observado;

	ReporteConsolidadoVerificaciones({
      this.dni,
      this.nombres,
      this.ubigeo,
      this.actividad,
      this.condicion,
      this.sustento,
      this.ddjj,
      this.indicaCta,
      this.ctaVigilada,
      this.onp,
      this.sbs,
      this.esSalud,
      this.reincorporado,
      this.priorizado,
      this.visitado,
      this.foto,
      this.georeferencia,
      this.observado});

	factory ReporteConsolidadoVerificaciones.fromJson(dynamic json)  =>
			ReporteConsolidadoVerificaciones(
				dni: json['dni'] as String?,
				nombres: json['nombres'] as String?,
				ubigeo: json['ubigeo'] as String?,
				actividad: json['actividad'] as String?,
				condicion: json['condicion'] as String?,
				sustento: json['sustento'] as String?,
				ddjj: json['ddjj'] as String?,
				indicaCta: json['indicaCta'] as String?,
				ctaVigilada: json['ctaVigilada'] as String?,
				onp: json['onp'] as String?,
				sbs: json['sbs'] as String?,
				esSalud: json['esSalud'] as String?,
				reincorporado: json['reincorporado'] as String?,
				priorizado: json['priorizado'] as String?,
				visitado: json['visitado'] as String?,
				foto: json['foto'] as String?,
				georeferencia: json['georeferencia'] as String?,
				observado: json['observado'] as String?,
			);

	static List<ReporteConsolidadoVerificaciones> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ReporteConsolidadoVerificaciones> items =
		bienvenidaList.map((e) => ReporteConsolidadoVerificaciones.fromJson(e)).toList();
		return items ?? [];
	}

}
