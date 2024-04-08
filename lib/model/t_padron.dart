import 'package:floor/floor.dart';
@entity
class Padron  {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? padronDni;
	String? padronPaterno;
	String? padronMaterno;
	String? padronNombres;
	String? padronsexo;
	String? padronFechaNacimiento;
	String? padronUbigeo;
	String? padronDepartamento;
	String? padronProvincia;
	String? padronDistrito;
	String? padronSDireccion;
	String? padronCentroPoblado;
	String? padronLatitud;
	String? padronLongitud;
	String? padronPerope;
	String? padronEdad;
	int? flagPlanTrabajo;
	String? padronDDireccion;
	String? padronDireccionP65;
	String? padronCodigoTipoCondicion;
	String? padronDescripcionCondicion;
	String? padronFechaVisita;
	int? padronUsuario;
	int? padronPrioridad;
	String? padronContactoTelefonico;
	String? padronPersonaContacto;
	String? indicePadronDni;
	String? indicePadronDepartamento;
	String? indicePadronProvincia;
	String? indicePadronDistrito;
	String? indicePadronPlanTrabajo;

	Padron({
      this.id,
      this.padronDni,
      this.padronPaterno,
      this.padronMaterno,
      this.padronNombres,
      this.padronsexo,
      this.padronFechaNacimiento,
      this.padronUbigeo,
      this.padronDepartamento,
      this.padronProvincia,
      this.padronDistrito,
      this.padronSDireccion,
      this.padronCentroPoblado,
      this.padronLatitud,
      this.padronLongitud,
      this.padronPerope,
      this.padronEdad,
      this.flagPlanTrabajo,
      this.padronDDireccion,
      this.padronDireccionP65,
      this.padronCodigoTipoCondicion,
      this.padronDescripcionCondicion,
      this.padronFechaVisita,
      this.padronUsuario,
      this.padronPrioridad,
      this.padronContactoTelefonico,
      this.padronPersonaContacto,});

	factory Padron.fromJson(dynamic json)  => Padron(
		id: json['id'] as int,
		padronDni: json['padronDni'] as String?,
		padronPaterno: json['padronPaterno'] as String?,
		padronMaterno: json['padronMaterno'] as String?,
		padronNombres: json['padronNombres'] as String?,
		padronsexo: json['padronsexo'] as String?,
		padronFechaNacimiento: json['padronFechaNacimiento'] as String?,
		padronUbigeo: json['padronUbigeo'] as String?,
		padronDepartamento: json['padronDepartamento'] as String?,
		padronProvincia: json['padronProvincia'] as String?,
		padronDistrito: json['padronDistrito'] as String?,
		padronSDireccion: json['padronSDireccion'] as String?,
		padronCentroPoblado: json['padronCentroPoblado'] as String?,
		padronLatitud: json['padronLatitud'] as String?,
		padronLongitud: json['padronLongitud'] as String?,
		padronPerope: json['padronPerope'] as String?,
		padronEdad: json['padronEdad'] as String?,
		flagPlanTrabajo: json['flagPlanTrabajo'],
		padronDDireccion: json['padronDDireccion'] as String?,
		padronDireccionP65: json['padronDireccionP65'] as String?,
		padronCodigoTipoCondicion: json['padronCodigoTipoCondicion'] as String?,
		padronDescripcionCondicion: json['padronDescripcionCondicion'] as String?,
		padronFechaVisita: json['padronFechaVisita'] as String?,
		padronUsuario: json['padronUsuario'],
		padronPrioridad: json['padronPrioridad'],
		padronContactoTelefonico: json['padronContactoTelefonico'] as String?,
		padronPersonaContacto: json['padronPersonaContacto'] as String?,
	);

	static List<Padron> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Padron> items =
		bienvenidaList.map((e) => Padron.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap(){
		return {
			'id': id,
			'padronDni': padronDni,
			'padronPaterno': padronPaterno,
			'padronMaterno': padronMaterno,
			'padronNombres': padronNombres,
			'padronsexo': padronsexo,
			'padronFechaNacimiento': padronFechaNacimiento,
			'padronUbigeo': padronUbigeo,
			'padronDepartamento': padronDepartamento,
			'padronProvincia': padronProvincia,
			'padronDistrito': padronDistrito,
			'padronSDireccion': padronSDireccion,
			'padronCentroPoblado': padronCentroPoblado,
			'padronLatitud': padronLatitud,
			'padronLongitud': padronLongitud,
			'padronPerope': padronPerope,
			'padronEdad': padronEdad,
			'flagPlanTrabajo': flagPlanTrabajo,
			'padronDDireccion': padronDDireccion,
			'padronDireccionP65': padronDireccionP65,
			'padronCodigoTipoCondicion': padronCodigoTipoCondicion,
			'padronDescripcionCondicion': padronDescripcionCondicion,
			'padronFechaVisita': padronFechaVisita,
			'padronUsuario': padronUsuario,
			'padronPrioridad': padronPrioridad,
			'padronContactoTelefonico': padronContactoTelefonico,
			'padronPersonaContacto': padronPersonaContacto,
		};

	}
	
}
