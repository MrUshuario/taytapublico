
class ReporteConsolidadoHistoricoPagaduria {

	String? perope;
	String? dni;
	String? tipusu;
	String? primerApellido;
	String? segundoApellido;
	String? nombres;
	String? fechaNacimiento;
	String? sexo;
	String? desUbigeo;
	String? direccion;
	String? edad;
	String? modpag;
	String? ptopag;
	String? lugarAgencia;
	String? mondepope;
	String? lista;

	ReporteConsolidadoHistoricoPagaduria({
      this.perope,
      this.dni,
      this.tipusu,
      this.primerApellido,
      this.segundoApellido,
      this.nombres,
      this.fechaNacimiento,
      this.sexo,
      this.desUbigeo,
      this.direccion,
      this.edad,
      this.modpag,
      this.ptopag,
      this.lugarAgencia,
      this.mondepope,
      this.lista});

	factory ReporteConsolidadoHistoricoPagaduria.fromJson(dynamic json)  =>
			ReporteConsolidadoHistoricoPagaduria(
				perope: json['perope'] as String?,
				dni: json['dni'] as String?,
				tipusu: json['tipusu'] as String?,
				primerApellido: json['primerApellido'] as String?,
				segundoApellido: json['segundoApellido'] as String?,
				nombres: json['nombres'] as String?,
				fechaNacimiento: json['fechaNacimiento'] as String?,
				sexo: json['sexo'] as String?,
				desUbigeo: json['desUbigeo'] as String?,
				direccion: json['direccion'] as String?,
				edad: json['edad'] as String?,
				modpag: json['modpag'] as String?,
				ptopag: json['ptopag'] as String?,
				lugarAgencia: json['lugarAgencia'] as String?,
				mondepope: json['mondepope'] as String?,
				lista: json['lista'] as String?,
			);

	static List<ReporteConsolidadoHistoricoPagaduria> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<ReporteConsolidadoHistoricoPagaduria> items =
		bienvenidaList.map((e) => ReporteConsolidadoHistoricoPagaduria.fromJson(e)).toList();
		return items ?? [];
	}

}
