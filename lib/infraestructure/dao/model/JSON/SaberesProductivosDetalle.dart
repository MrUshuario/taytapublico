
class SaberesProductivosDetalle {

	int? codigoSaberesProdDet;
	int? codigoSaberesProd;
	String? dni;
	String? apellidoPaterno;
	String? apellidoMaterno;
	String? nombres;
	String? sexo;
	String? edad;
	String? fechaNacimiento;

	int? edadNino;
	int? tieneAnemia;
	int? recibeLactanciaMaterna;
	int? recibeLactanciaMaternaySulfatoFerroso;
	int? recibeLecheMaterna;
	int? recibeSuplemento23;
	int? sabePrepararElSuplemento23;
	int? recibeSuplemento36;
	int? sabePrepararElSuplemento36;
	String? alimento123;
	String? alimento223;
	String? alimento323;
	String? alimento136;
	String? alimento236;
	String? alimento336;
	int? nroNino;

	String? establecimientoSalud;
	int? estaAfiliadoSis;
	String? fechaUltimaHemoglobina;
	String? valorHemoglobina;
	int? ninoRecibeTratamientoAnemia;
	int? recibeGotasSulfatoFerroso;

	SaberesProductivosDetalle({
      this.codigoSaberesProdDet,
      this.codigoSaberesProd,
      this.dni,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.nombres,
      this.sexo,
      this.edad,
      this.fechaNacimiento,
      this.edadNino,
      this.tieneAnemia,
      this.recibeLactanciaMaterna,
      this.recibeLactanciaMaternaySulfatoFerroso,
      this.recibeLecheMaterna,
      this.recibeSuplemento23,
      this.sabePrepararElSuplemento23,
      this.recibeSuplemento36,
      this.sabePrepararElSuplemento36,
      this.alimento123,
      this.alimento223,
      this.alimento323,
      this.alimento136,
      this.alimento236,
      this.alimento336,
      this.nroNino,
      this.establecimientoSalud,
      this.estaAfiliadoSis,
      this.fechaUltimaHemoglobina,
      this.valorHemoglobina,
      this.ninoRecibeTratamientoAnemia,
      this.recibeGotasSulfatoFerroso});

	factory SaberesProductivosDetalle.fromJson(dynamic json)  =>
			SaberesProductivosDetalle(
				codigoSaberesProdDet: json['codigoSaberesProdDet'] as int?,
				codigoSaberesProd: json['codigoSaberesProd'] as int?,
				dni: json['dni'] as String?,
				apellidoPaterno: json['apellidoPaterno'] as String?,
				apellidoMaterno: json['apellidoMaterno'] as String?,
				nombres: json['nombres'] as String?,
				sexo: json['sexo'] as String?,
				edad: json['edad'] as String?,
				fechaNacimiento: json['fechaNacimiento'] as String?,
				edadNino: json['edadNino'] as int?,
				tieneAnemia: json['tieneAnemia'] as int?,
				recibeLactanciaMaterna: json['recibeLactanciaMaterna'] as int?,
				recibeLactanciaMaternaySulfatoFerroso:
				json['recibeLactanciaMaternaySulfatoFerroso'] as int?,
				recibeLecheMaterna: json['recibeLecheMaterna'] as int?,
				recibeSuplemento23: json['recibeSuplemento23'] as int?,
				sabePrepararElSuplemento23: json['sabePrepararElSuplemento23'] as int?,
				recibeSuplemento36: json['recibeSuplemento36'] as int?,
				sabePrepararElSuplemento36: json['sabePrepararElSuplemento36'] as int?,
				alimento123: json['alimento123'] as String?,
				alimento223: json['alimento223'] as String?,
				alimento323: json['alimento323'] as String?,
				alimento136: json['alimento136'] as String?,
				alimento236: json['alimento236'] as String?,
				alimento336: json['alimento336'] as String?,
				nroNino: json['nroNino'] as int?,
				establecimientoSalud: json['establecimientoSalud'] as String?,
				estaAfiliadoSis: json['estaAfiliadoSis'] as int?,
				fechaUltimaHemoglobina: json['fechaUltimaHemoglobina'] as String?,
				valorHemoglobina: json['valorHemoglobina'] as String?,
				ninoRecibeTratamientoAnemia: json['ninoRecibeTratamientoAnemia'] as int?,
				recibeGotasSulfatoFerroso: json['recibeGotasSulfatoFerroso'] as int?,
			);

	static List<SaberesProductivosDetalle> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesProductivosDetalle> items =
		bienvenidaList.map((e) => SaberesProductivosDetalle.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"codigoSaberesProdDet": codigoSaberesProdDet,
			"codigoSaberesProd": codigoSaberesProd,
			"dni": dni,
			"apellidoPaterno": apellidoPaterno,
			"apellidoMaterno": apellidoMaterno,
			"nombres": nombres,
			"sexo": sexo,
			"edad": edad,
			"fechaNacimiento": fechaNacimiento,
			"edadNino": edadNino,
			"tieneAnemia": tieneAnemia,
			"recibeLactanciaMaterna": recibeLactanciaMaterna,
			"recibeLactanciaMaternaySulfatoFerroso": recibeLactanciaMaternaySulfatoFerroso,
			"recibeLecheMaterna": recibeLecheMaterna,
			"recibeSuplemento23": recibeSuplemento23,
			"sabePrepararElSuplemento23": sabePrepararElSuplemento23,
			"recibeSuplemento36": recibeSuplemento36,
			"sabePrepararElSuplemento36": sabePrepararElSuplemento36,
			"alimento123": alimento123,
			"alimento223": alimento223,
			"alimento323": alimento323,
			"alimento136": alimento136,
			"alimento236": alimento236,
			"alimento336": alimento336,
			"nroNino": nroNino,
			"establecimientoSalud": establecimientoSalud,
			"estaAfiliadoSis": estaAfiliadoSis,
			"fechaUltimaHemoglobina": fechaUltimaHemoglobina,
			"valorHemoglobina": valorHemoglobina,
			"ninoRecibeTratamientoAnemia": ninoRecibeTratamientoAnemia,
			"recibeGotasSulfatoFerroso": recibeGotasSulfatoFerroso,
		};
	}

}
