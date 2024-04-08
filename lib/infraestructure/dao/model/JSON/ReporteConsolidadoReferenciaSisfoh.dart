
class ReporteConsolidadoReferenciaSisfoh {

	String? dni;
	String? condicion;
	String? lista;
	String? documento;

	ReporteConsolidadoReferenciaSisfoh({
      this.dni, this.condicion, this.lista, this.documento});

	factory ReporteConsolidadoReferenciaSisfoh.fromJson(dynamic json)  =>
			ReporteConsolidadoReferenciaSisfoh(
				dni: json['dni'] as String?,
				condicion: json['condicion'] as String?,
				lista: json['lista'] as String?,
				documento: json['documento'] as String?,
			);

	static List<ReporteConsolidadoReferenciaSisfoh> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ReporteConsolidadoReferenciaSisfoh> items =
		bienvenidaList.map((e) => ReporteConsolidadoReferenciaSisfoh.fromJson(e)).toList();
		return items ?? [];
	}

}
