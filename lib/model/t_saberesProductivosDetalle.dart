import 'package:floor/floor.dart';
@entity
class SaberesProductivosDetalle {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? dni;
	String? apellidoPaterno;
	String? apellidoMaterno;
	String? nombres;
	String? sexo;
	String? edad;
	String? fechaNacimiento;
	String? nroNino;
	String? edadNino;
	String? tieneAnemia;
	String? recibeLactanciaMaterna;
	String? recibeLactanciaMaternaySulfatoFerroso;
	String? recibeLecheMaterna;
	String? recibeSuplemento23;
	String? sabePrepararElSuplemento23;
	String? recibeSuplemento36;
	String? sabePrepararElSuplemento36;
	String? alimento123;
	String? alimento223;
	String? alimento323;
	String? alimento136;
	String? alimento236;
	String? alimento336;
	String? establecimientoSalud;
	String? estaAfiliadoSis;
	String? fechaUltimaHemoglobina;
	String? valorHemoglobina;
	String? ninoRecibeTratamientoAnemia;
	String? recibeGotasSulfatoFerroso;

	SaberesProductivosDetalle(
      this.id,
      this.dni,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.nombres,
      this.sexo,
      this.edad,
      this.fechaNacimiento,
      this.nroNino,
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
      this.establecimientoSalud,
      this.estaAfiliadoSis,
      this.fechaUltimaHemoglobina,
      this.valorHemoglobina,
      this.ninoRecibeTratamientoAnemia,
      this.recibeGotasSulfatoFerroso);

	factory SaberesProductivosDetalle.fromJson(dynamic json) =>
			SaberesProductivosDetalle(
				json['id'] as int?,
				json['dni'] as String?,
				json['apellidoPaterno'] as String?,
				json['apellidoMaterno'] as String?,
				json['nombres'] as String?,
				json['sexo'] as String?,
				json['edad'] as String?,
				json['fechaNacimiento'] as String?,
				json['nroNino'] as String?,
				json['edadNino'] as String?,
				json['tieneAnemia'] as String?,
				json['recibeLactanciaMaterna'] as String?,
				json['recibeLactanciaMaternaySulfatoFerroso'] as String?,
				json['recibeLecheMaterna'] as String?,
				json['recibeSuplemento23'] as String?,
				json['sabePrepararElSuplemento23'] as String?,
				json['recibeSuplemento36'] as String?,
				json['sabePrepararElSuplemento36'] as String?,
				json['alimento123'] as String?,
				json['alimento223'] as String?,
				json['alimento323'] as String?,
				json['alimento136'] as String?,
				json['alimento236'] as String?,
				json['alimento336'] as String?,
				json['establecimientoSalud'] as String?,
				json['estaAfiliadoSis'] as String?,
				json['fechaUltimaHemoglobina'] as String?,
				json['valorHemoglobina'] as String?,
				json['ninoRecibeTratamientoAnemia'] as String?,
				json['recibeGotasSulfatoFerroso'] as String?,
			);

	static List<SaberesProductivosDetalle> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesProductivosDetalle> items =
		bienvenidaList.map((e) => SaberesProductivosDetalle.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() { return {
		'id': id,
		'dni': dni,
		'apellidoPaterno': apellidoPaterno,
		'apellidoMaterno': apellidoMaterno,
		'nombres': nombres,
		'sexo': sexo,
		'edad': edad,
		'fechaNacimiento': fechaNacimiento,
		'nroNino': nroNino,
		'edadNino': edadNino,
		'tieneAnemia': tieneAnemia,
		'recibeLactanciaMaterna': recibeLactanciaMaterna,
		'recibeLactanciaMaternaySulfatoFerroso': recibeLactanciaMaternaySulfatoFerroso,
		'recibeLecheMaterna': recibeLecheMaterna,
		'recibeSuplemento23': recibeSuplemento23,
		'sabePrepararElSuplemento23': sabePrepararElSuplemento23,
		'recibeSuplemento36': recibeSuplemento36,
		'sabePrepararElSuplemento36': sabePrepararElSuplemento36,
		'alimento123': alimento123,
		'alimento223': alimento223,
		'alimento323': alimento323,
		'alimento136': alimento136,
		'alimento236': alimento236,
		'alimento336': alimento336,
		'establecimientoSalud': establecimientoSalud,
		'estaAfiliadoSis': estaAfiliadoSis,
		'fechaUltimaHemoglobina': fechaUltimaHemoglobina,
		'valorHemoglobina': valorHemoglobina,
		'ninoRecibeTratamientoAnemia': ninoRecibeTratamientoAnemia,
		'recibeGotasSulfatoFerroso': recibeGotasSulfatoFerroso,
		};
	}

}
