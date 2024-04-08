import 'package:floor/floor.dart';

@entity
class Visitas {
  @PrimaryKey(autoGenerate: true)
  int? codigoVisita;


  String? apepat;
  String? apemat;
  String? nombres;

  int? flagVictimaUsuario; //RAdio USUIARIO 1 FAMILIAR 2 OTROS 3
  int? codigoViolenciaDetectada; //Viende de un select pero debo agarrar el index
  int? codigoVictima; //VIOLENCIA SELECT
  int? codigoVinculoPersonaAgresora; //VIOLENCIA SELECT
  int? codigoInstancia; //Instancia
  int? flagInstanciaSi; //se procederea derivacion?
  String? observacionSaberes; //INFORMACION DEL CASO

  String? placa; //BITACORA
  int? kilometraje; //BITACORA
  String? monto; //BITACORA
  String? galones; //BITACORA
  String? grifo; //BITACORA

  String? telefonoContacto; //contacto referencia
  String? personaContacto; //contacto referencia

  String? fechaFallecimiento; // VISITA PRESENCIAL FECHA FALLECIMIENTO
  int?      tipoCondicion; //VISITA PRESENCIAL OCURRENCIA = 0 | VISITA = 1
  String?  direccion; //FORMULARIO NO MUERTO
  String?  distrito; //FORMULARIO NO MUERTO
  String?   recibeTratamientoDiabetes; //SI COBRO (1) No COBRO (2)
  String? otrosDiabetes; //DETALLAR PORQUE
  int? codigoMedicacionDiabetes; //ATV AGENCIA
  int? cumpleTratamientoHipertension; //Por algu nmotivo es declaracion jurada
  String? descripcionMedicacionOtraEnfermedad; // DESCIRPCION VULNERABILIDAD ADICIONAL SELECT
  int? recibeTratamientoOtraEnfermedad; // INDICE VULNERABILIDAD ADICIONAL SELECT
  int? codigoSaberesTema; //CHARLA INDICE //USUARIOS PRODUCTOS (ENCUENTRO SABERES)
  int? tieneLentes; //RADIO EDUCACION FINANCIERA

  /* NO SE PUEDE ENVIAR SE USA PARA CREAR LA TABLA CONDICION
  String? descripcionCondicion; //VISITA PRESENCIAL CONDICION EL TEXTO DE LA SQL //NO HAY EN PERSONAL
  int? codigoCondicion; // VISITA PRESENCIAL CONDICION EL POSICIONAMIENTO DE LA SQL //NO HAY EN PERSONAL
   */

  String? observacion; //observacion del caso

  String? codigoOperador;
  int? codigoRegistro; //TIPO REGISTRO EN TABLA VISITA
  String? dni;
  String? fechaRegistro; //FECHA GPS, ES LA FECHA QUE MARCA DONDE SE DIBUJARA EN EL SISTEMA (FECHA DEL DISPOSITIVO)

  String? fechaEncuentro; //FECHA SECUNDARIA; ESTA NO SE MARCA EN EL SISTEMA
  String? codigoModular; //ENCUENTROSABERES TIPO REUNION P W M
  String? saberEspecifico;
  String? puntoFocal; //SABERES ESPECIFICO AUTORIDAD
  int? codigoSaberesGrado; //LOGRO VENDER SI 1 NO 0
  int? nroNinos; //USUARIOS SABERES
  int? nroNinas; //USUARIAS SABERES
  //int? codigoSaberesTema; //USUARIOS PRODUCTOS
  int? codigoSaberesNivel; //USUARIOS PRODUCTOS


  int? seRealizoFechaProgramada; //PUNTO DE PAGO

  //String? tipoCondicion; //String? descripcionCondicion;//SELECT DE VISITA PRESENCIAL Y REMOTA
  //int? codigoCondicion;//SELECT DE VISITA PRESENCIAL Y REMOTA

  String? fechaTablet;
  String? fechaTabletFotoDos;
  String? fechaTabletFotoTres;
  String? fechaTabletFotoUno;
  String? fotoDos;
  String? fotoTres;
  String? fotoUno;
  String? freeEspacioTablet;
  String? longitud;
  String? latitud;
  String? altitud;
  String? imei;
  int? recorrido;                     // INICIO/FIN ACTIVIDADES INICIO ES 0 FIN ES 1
  String? totalEspacioTablet;
  String? versionAplicacion;
  int? versionCondicion;
  int? versionOperador;

  Visitas(
      {this.altitud,
      this.apepat,
      this.apemat,
        this.codigoViolenciaDetectada,
       this.flagVictimaUsuario,
       this.codigoVictima,
       this.codigoVinculoPersonaAgresora,
       this.codigoInstancia,
       this.flagInstanciaSi,
       this.observacionSaberes,
        this.placa,
        this.kilometraje,
        this.monto,
        this.galones,
        this.grifo,

        this.telefonoContacto,
        this.personaContacto,

        this.fechaFallecimiento,
        this.tipoCondicion,
        this.direccion,
        this.distrito,
        this.recibeTratamientoDiabetes,
        this.otrosDiabetes,
        this.codigoMedicacionDiabetes,
        this.cumpleTratamientoHipertension,
        this.descripcionMedicacionOtraEnfermedad,
        this.recibeTratamientoOtraEnfermedad,
        this.codigoSaberesTema,
        this.tieneLentes,




        this.nombres,
      this.codigoOperador,
      this.codigoRegistro,
      this.codigoVisita,
      this.dni,
      this.fechaRegistro,

        this.fechaEncuentro,
        this.codigoModular,
        this.saberEspecifico,
        this.puntoFocal,
        this.codigoSaberesGrado,
        this.nroNinos,
        this.nroNinas,
        this.codigoSaberesNivel,

        //this.descripcionCondicion, ¿tipocondicion?
        //this.codigoCondicion,

        this.seRealizoFechaProgramada,

        this.fechaTablet,
      this.fechaTabletFotoDos,
      this.fechaTabletFotoTres,
      this.fechaTabletFotoUno,
      this.fotoDos,
      this.fotoTres,
      this.fotoUno,
      this.freeEspacioTablet,
      this.imei,
      this.latitud,
      this.longitud,
      this.observacion,
      this.recorrido,
      this.totalEspacioTablet,
      this.versionAplicacion,
      this.versionCondicion,
      this.versionOperador});

  factory Visitas.fromJson(dynamic json) {
    return Visitas(
      altitud: json['altitud'],
      apepat: json['apepat'],
      apemat: json['apemat'],
      nombres: json['nombres'],
      codigoViolenciaDetectada: json['codigoViolenciaDetectada'],

      flagVictimaUsuario: json['flagVictimaUsuario'],
      codigoVictima:  json['codigoVictima'],
      codigoVinculoPersonaAgresora: json['codigoVinculoPersonaAgresora'],
      codigoInstancia:  json['codigoInstancia'],
      flagInstanciaSi:  json['flagInstanciaSi'],
      observacionSaberes: json['observacionSaberes'],

      placa: json["placa"],
      kilometraje: json['kilometraje'],
      monto: json['monto'],
      galones: json['galones'],
      grifo: json['grifo'],

      telefonoContacto:json['telefonoContacto'],
      personaContacto:json['personaContacto'],

      fechaFallecimiento:json['fechaFallecimiento'],
      tipoCondicion:json['tipoCondicion'],
      direccion:json['direccion'],
      distrito:json['distrito'],
      recibeTratamientoDiabetes:json['recibeTratamientoDiabetes'],
      otrosDiabetes:json['otrosDiabetes'],
      codigoMedicacionDiabetes:json['codigoMedicacionDiabetes'],
      cumpleTratamientoHipertension:json['cumpleTratamientoHipertension'],
      descripcionMedicacionOtraEnfermedad:json['descripcionMedicacionOtraEnfermedad'],
      recibeTratamientoOtraEnfermedad:json['recibeTratamientoOtraEnfermedad'],
      codigoSaberesTema:json['codigoSaberesTema'],
      tieneLentes:json['tieneLentes'],

      codigoOperador: json['codigoOperador'],
      codigoRegistro: json['codigoRegistro'],
      codigoVisita: json['codigoVisita'],
      dni: json['dni'],
      fechaRegistro: json['fechaRegistro'],

      fechaEncuentro: json['fechaEncuentro'],
      codigoModular:json['codigoModular'],
      saberEspecifico:json['saberEspecifico'],
      puntoFocal:json['puntoFocal'],
      codigoSaberesGrado:json['codigoSaberesGrado'],
      nroNinos:json['nroNinos'],
      nroNinas:json['nroNinas'],
      codigoSaberesNivel:json['codigoSaberesNivel'],

      //descripcionCondicion:json['descripcionCondicion'],
      //codigoCondicion:json['codigoCondicion'],

      seRealizoFechaProgramada: json['seRealizoFechaProgramada'],

      fechaTablet: json['fechaTablet'],
      fechaTabletFotoDos: json['fechaTabletFotoDos'],
      fechaTabletFotoTres: json['fechaTabletFotoTres'],
      fechaTabletFotoUno: json['fechaTabletFotoUno'],
      fotoDos: json['fotoDos'],
      fotoTres: json['fotoTres'],
      fotoUno: json['fotoUno'],
      freeEspacioTablet: json['freeEspacioTablet'],
      imei: json['imei'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      observacion: json['observacion'],
      recorrido: json['recorrido'],
      totalEspacioTablet: json['totalEspacioTablet'],
      versionAplicacion: json['versionAplicacion'],
      versionCondicion: json['versionCondicion'],
      versionOperador: json['versionOperador'],
    );
  }

  static List<Visitas> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Visitas> items =
        bienvenidaList.map((e) => Visitas.fromJson(e)).toList();
    return items;
  }

  Map<String, dynamic> toMap() {
    return {
      "altitud": altitud,
      "apepat": apepat,
      "apemat": apemat,
      "nombres": nombres,
      "codigoViolenciaDetectada": codigoViolenciaDetectada,
      "flagVictimaUsuario": flagVictimaUsuario,
      "codigoVictima": codigoVictima,
      "codigoVinculoPersonaAgresora": codigoVinculoPersonaAgresora,
      "codigoInstancia":  codigoInstancia,
      "flagInstanciaSi":  flagInstanciaSi,
      "observacionSaberes": observacionSaberes,

      "placa": placa,
      "kilometraje": kilometraje,
      "monto": monto,
      "galones": galones,
      "grifo": grifo,

      "telefonoContacto": telefonoContacto,
      "personaContacto": personaContacto,

      "fechaFallecimiento":fechaFallecimiento,
      "tipoCondicion":tipoCondicion,
      "direccion":direccion,
      "distrito":distrito,
      "recibeTratamientoDiabetes":recibeTratamientoDiabetes,
      "otrosDiabetes":otrosDiabetes,
      "codigoMedicacionDiabetes":codigoMedicacionDiabetes,
      "cumpleTratamientoHipertension":cumpleTratamientoHipertension,
      "descripcionMedicacionOtraEnfermedad":descripcionMedicacionOtraEnfermedad,
      "recibeTratamientoOtraEnfermedad":recibeTratamientoOtraEnfermedad,
      "codigoSaberesTema":codigoSaberesTema,
      "tieneLentes":tieneLentes,

      "codigoOperador": codigoOperador,
      "codigoRegistro": codigoRegistro,
      "codigoVisita": codigoVisita,
      "dni": dni,
      "fechaRegistro": fechaRegistro,

      "fechaEncuentro":fechaEncuentro,
      "codigoModular":codigoModular,
      "saberEspecifico":saberEspecifico,
      "puntoFocal":puntoFocal,
      "codigoSaberesGrado":codigoSaberesGrado,
      "nroNinos":nroNinos,
      "nroNinas":nroNinas,
      "codigoSaberesNivel":codigoSaberesNivel,

      //"descripcionCondicion":descripcionCondicion,
      //"codigoCondicion":codigoCondicion,

      "seRealizoFechaProgramada": seRealizoFechaProgramada,

      "fechaTablet": fechaTablet,
      "fechaTabletFotoDos": fechaTabletFotoDos,
      "fechaTabletFotoTres": fechaTabletFotoTres,
      "fechaTabletFotoUno": fechaTabletFotoUno,
      "fotoDos": fotoDos,
      "fotoTres": fotoTres,
      "fotoUno": fotoUno,
      "freeEspacioTablet": freeEspacioTablet,
      "imei": imei,
      "latitud": latitud,
      "longitud": longitud,
      "observacion": observacion,
      "recorrido": recorrido,
      "totalEspacioTablet": totalEspacioTablet,
      "versionAplicacion": versionAplicacion,
      "versionCondicion": versionCondicion,
      "versionOperador": versionOperador
    };
  }
}
