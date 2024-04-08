//https://www.youtube.com/watch?v=y2uQ7XTgne8

class padronModel {

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


  padronModel({
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
      this.padronPersonaContacto});

  factory padronModel.fromJson(dynamic json) {
    return padronModel(
        padronDni: (json['padronDni'].toString()),
        padronPaterno: (json['padronPaterno'].toString()),
        padronMaterno: json['padronMaterno'].toString(),
        padronNombres: (json['padronNombres'].toString()),
        padronsexo: (json['padronsexo'].toString()),
        padronFechaNacimiento: (json['padronFechaNacimiento'].toString()),
        padronUbigeo: (json['padronUbigeo'].toString()),
        padronDepartamento: (json['padronDepartamento'].toString()),
        padronProvincia: (json['padronProvincia'].toString()),
        padronDistrito: (json['padronDistrito'].toString()),
        padronSDireccion: (json['padronSDireccion'].toString()),
        padronCentroPoblado: (json['padronCentroPoblado'].toString()),
        padronLatitud: (json['padronLatitud'].toString()),
        padronLongitud: (json['padronLongitud'].toString()),
        padronPerope: (json['padronPerope'].toString()),
        padronEdad: (json['padronEdad'].toString()),
        flagPlanTrabajo: (json['flagPlanTrabajo']),
        padronDDireccion: (json['padronDDireccion'].toString()),
        padronDireccionP65: (json['padronDireccionP65'].toString()),
        padronCodigoTipoCondicion: (json['padronCodigoTipoCondicion'].toString()),
        padronDescripcionCondicion: (json['padronDescripcionCondicion'].toString()),
        padronFechaVisita: (json['padronFechaVisita'].toString()),
        padronUsuario: (json['padronUsuario']),
        padronPrioridad: (json['padronPrioridad']),
        padronContactoTelefonico: (json['padronContactoTelefonico'].toString()),
        padronPersonaContacto: (json['padronPersonaContacto'].toString()),
        );
  }

  static List<padronModel> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<padronModel> items =
    bienvenidaList.map((e) => padronModel.fromJson(e)).toList();
    return items ?? [];
  }
}