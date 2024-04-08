
class ReporteConsolidadoCuentasVigiladas {

	String? item;
	String? dni;
	String? motivo;
	String? docVigila;
	String? fechaDocVigila;
	String? docLevantaVigila;
	String? fechaDocLev;
	String? observacion;

	ReporteConsolidadoCuentasVigiladas({
      this.item,
      this.dni,
      this.motivo,
      this.docVigila,
      this.fechaDocVigila,
      this.docLevantaVigila,
			this.fechaDocLev,
      this.observacion});

	factory ReporteConsolidadoCuentasVigiladas.fromJson(dynamic json)  =>
			ReporteConsolidadoCuentasVigiladas(
				item: json['item'] as String?,
				dni: json['dni'] as String?,
				motivo: json['motivo'] as String?,
				docVigila: json['docVigila'] as String?,
				fechaDocVigila: json['fechaDocVigila'] as String?,
				docLevantaVigila: json['docLevantaVigila'] as String?,
				fechaDocLev: json['fechaDocLev'] as String?,
				observacion: json['observacion'] as String?,
			);

	static List<ReporteConsolidadoCuentasVigiladas> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ReporteConsolidadoCuentasVigiladas> items =
		bienvenidaList.map((e) => ReporteConsolidadoCuentasVigiladas.fromJson(e)).toList();
		return items ?? [];
	}

}
