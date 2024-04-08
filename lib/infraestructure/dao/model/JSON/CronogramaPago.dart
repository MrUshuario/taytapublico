
class CronogramaPago {

	String? perope;
	String? fechaInicio;
	int? idCronog;
	String? fechaFin;
	String? fechaCierre;

	CronogramaPago({this.perope, this.fechaInicio, this.idCronog, this.fechaFin,
      this.fechaCierre});

	factory CronogramaPago.fromJson(dynamic json)  =>
			CronogramaPago(
				perope: json['perope'] as String?,
				fechaInicio: json['fechaInicio'] as String?,
				idCronog: json['idCronog'] as int?,
				fechaFin: json['fechaFin'] as String?,
				fechaCierre: json['fechaCierre'] as String?,
			);

	static List<CronogramaPago> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CronogramaPago> items =
		bienvenidaList.map((e) => CronogramaPago.fromJson(e)).toList();
		return items ?? [];
	}
}
