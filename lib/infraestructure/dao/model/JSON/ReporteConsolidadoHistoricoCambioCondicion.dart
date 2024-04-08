
class ReporteConsolidadoHistoricoCambioCondicion {
	
	String? pcTerminal;
	String? perope;
	String? codigoReferencia;
	String? nombreColumna;
	String? valorAnt;
	String? valorAct;
	String? fechaRegistro;
	String? usuarioBaseDatos;
	String? fechaAprobacion;
	String? usuarioAprobacion;
	String? motivo;
	String? nombreDocumento;

	ReporteConsolidadoHistoricoCambioCondicion({
      this.pcTerminal,
      this.perope,
      this.codigoReferencia,
      this.nombreColumna,
      this.valorAnt,
      this.valorAct,
      this.fechaRegistro,
      this.usuarioBaseDatos,
      this.fechaAprobacion,
      this.usuarioAprobacion,
      this.motivo,
      this.nombreDocumento});

	factory ReporteConsolidadoHistoricoCambioCondicion.fromJson(dynamic json)  =>
			ReporteConsolidadoHistoricoCambioCondicion(
				pcTerminal: json['pcTerminal'] as String?,
				perope: json['perope'] as String?,
				codigoReferencia: json['codigoReferencia'] as String?,
				nombreColumna: json['nombreColumna'] as String?,
				valorAnt: json['valorAnt'] as String?,
				valorAct: json['valorAct'] as String?,
				fechaRegistro: json['fechaRegistro'] as String?,
				usuarioBaseDatos: json['usuarioBaseDatos'] as String?,
				fechaAprobacion: json['fechaAprobacion'] as String?,
				usuarioAprobacion: json['usuarioAprobacion'] as String?,
				motivo: json['motivo'] as String?,
				nombreDocumento: json['nombreDocumento'] as String?,
			);

	static List<ReporteConsolidadoHistoricoCambioCondicion> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ReporteConsolidadoHistoricoCambioCondicion> items =
		bienvenidaList.map((e) => ReporteConsolidadoHistoricoCambioCondicion.fromJson(e)).toList();
		return items ?? [];
	}
}
