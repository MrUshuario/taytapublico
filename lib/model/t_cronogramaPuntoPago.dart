import 'package:floor/floor.dart';
@entity
class CronogramaPuntoPago {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? perope;
	String? fechaInicio;
	String? codigoCronogramaPuntoPago;
	String? fechaFin;
	String? fechaCierre;

	CronogramaPuntoPago({this.id, this.perope, this.fechaInicio, this.codigoCronogramaPuntoPago, this.fechaFin,
      this.fechaCierre});

	factory CronogramaPuntoPago.fromJson(dynamic json)  =>
			CronogramaPuntoPago(
				id: json['id'] as int?,
				perope: json['perope'] as String?,
				fechaInicio: json['fechaInicio'] as String?,
				codigoCronogramaPuntoPago: json['codigoCronogramaPuntoPago'] as String?,
				fechaFin: json['fechaFin'] as String?,
				fechaCierre: json['fechaCierre'] as String?,
			);

	static List<CronogramaPuntoPago> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CronogramaPuntoPago> items =
		bienvenidaList.map((e) => CronogramaPuntoPago.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"perope": perope,
			"fechaInicio": fechaInicio,
			"codigoCronogramaPuntoPago": codigoCronogramaPuntoPago,
			"fechaFin": fechaFin,
			"fechaCierre": fechaCierre,
		};
	}

}
