import 'package:floor/floor.dart';
@entity
class PuntoPago {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoPuntoPago;
	String? codigoCronograma;
	String? tipoPuntoPago;
	String? codigoUbigeo;
	String? lugarAgencia;
	String? fechaPago;
	String? horaPago;
	String? totalUsuariosPago;

	PuntoPago({
			this.id,
			this.codigoCronograma,
      this.tipoPuntoPago,
      this.codigoPuntoPago,
      this.codigoUbigeo,
      this.lugarAgencia,
      this.fechaPago,
			this.horaPago,
      this.totalUsuariosPago});

	factory PuntoPago.fromJson(dynamic json)  => PuntoPago(
		id: json['id'] as int?,
		codigoCronograma: json['codigoCronograma'] as String?,
		tipoPuntoPago: json['tipoPuntoPago'] as String?,
		codigoPuntoPago: json['codigoPuntoPago'] as String?,
		codigoUbigeo: json['codigoUbigeo'] as String?,
		lugarAgencia: json['lugarAgencia'] as String?,
		fechaPago: json['fechaPago'] as String?,
		horaPago: json['horaPago'] as String?,
		totalUsuariosPago: json['totalUsuariosPago'] as String?,
	);

	static List<PuntoPago> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<PuntoPago> items =
		bienvenidaList.map((e) => PuntoPago.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoPuntoPago": codigoPuntoPago,
			"codigoCronograma": codigoCronograma,
			"tipoPuntoPago": tipoPuntoPago,
			"codigoUbigeo": codigoUbigeo,
			"lugarAgencia": lugarAgencia,
			"fechaPago": fechaPago,
			"horaPago": horaPago,
			"totalUsuariosPago": totalUsuariosPago
		};
	}

}
