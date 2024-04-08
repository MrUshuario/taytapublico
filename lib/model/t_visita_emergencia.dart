/*
import 'package:floor/floor.dart';

@entity
class Visitas {
  @PrimaryKey(autoGenerate: true)
  int? codigoVisita;
  String? altitud;
  String? apepat;
  String? apemat;
  String? codigoOperador;
  int? codigoRegistro;
  String? dni;
  String? fechaRegistro;
  String? fechaTablet;
  String? fechaTabletFotoDos;
  String? fechaTabletFotoTres;
  String? fechaTabletFotoUno;
  String? fotoDos;
  String? fotoTres;
  String? fotoUno;
  String? freeEspacioTablet;
  String? imei;
  String? latitud;
  String? longitud;
  String? observacion;
  int? recorrido;
  int? tipoCondicion;
  String? totalEspacioTablet;
  String? versionAplicacion;
  int? versionCondicion;
  int? versionOperador;

  Visitas(
      {this.altitud,
      this.apepat,
      this.apemat,
      this.codigoOperador,
      this.codigoRegistro,
      this.codigoVisita,
      this.dni,
      this.fechaRegistro,
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
      this.tipoCondicion,
      this.totalEspacioTablet,
      this.versionAplicacion,
      this.versionCondicion,
      this.versionOperador});

  factory Visitas.fromJson(dynamic json) {
    return Visitas(
      altitud: json['altitud'],
      apepat: json['apepat'],
      apemat: json['apemat'],
      codigoOperador: json['codigoOperador'],
      codigoRegistro: json['codigoRegistro'],
      codigoVisita: json['codigoVisita'],
      dni: json['dni'],
      fechaRegistro: json['fechaRegistro'],
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
      tipoCondicion: json['tipoCondicion'],
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
      "codigoOperador": codigoOperador,
      "codigoRegistro": codigoRegistro,
      "codigoVisita": codigoVisita,
      "dni": dni,
      "fechaRegistro": fechaRegistro,
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
      "tipoCondicion": tipoCondicion,
      "totalEspacioTablet": totalEspacioTablet,
      "versionAplicacion": versionAplicacion,
      "versionCondicion": versionCondicion,
      "versionOperador": versionOperador
    };
  }
}
*/