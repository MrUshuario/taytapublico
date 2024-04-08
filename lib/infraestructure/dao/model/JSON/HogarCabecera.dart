import 'package:tayta/infraestructure/dao/model/JSON/HogarDetalle.dart';

class HogarCabecera {
	
	  int? codigoHogarCabecera;
    String? usuario;
    String? fechaRegistro;
    int? versionOperadores;
    String? versionAplicacion;
    String? latitud;
    String? longitud;
    String? imei;
    String? fechaTablet;
    int? codigoCocina;
    int? codigoAgua;
    int? codigoSaneamiento;
    int? codigoLuz;
    int? codigoProgramaSocial;
    List<HogarDetalle>? listaHogarDetalle;

    HogarCabecera({
      this.codigoHogarCabecera,
      this.usuario,
      this.fechaRegistro,
      this.versionOperadores,
      this.versionAplicacion,
      this.latitud,
      this.longitud,
      this.imei,
      this.fechaTablet,
      this.codigoCocina,
      this.codigoAgua,
      this.codigoSaneamiento,
      this.codigoLuz,
        this.codigoProgramaSocial,
      this.listaHogarDetalle});

    factory HogarCabecera.fromJson(dynamic json)  =>
        HogarCabecera(
          codigoHogarCabecera: json['codigoHogarCabecera'] as int?,
          usuario: json['usuario'] as String?,
          fechaRegistro: json['fechaRegistro'] as String?,
          versionOperadores: json['versionOperadores'] as int?,
          versionAplicacion: json['versionAplicacion'] as String?,
          latitud: json['latitud'] as String?,
          longitud: json['longitud'] as String?,
          imei: json['imei'] as String?,
          fechaTablet: json['fechaTablet'] as String?,
          codigoCocina: json['codigoCocina'] as int?,
          codigoAgua: json['codigoAgua'] as int?,
          codigoSaneamiento: json['codigoSaneamiento'] as int?,
          codigoLuz: json['codigoLuz'] as int?,
          codigoProgramaSocial: json['codigoProgramaSocial'] as int?,
          listaHogarDetalle: (json['listaHogarDetalle'] as List<dynamic>?)
              ?.map((e) => HogarDetalle.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

    static List<HogarCabecera> listFromJson(dynamic json) {
      var bienvenidaList = json as List;
      List<HogarCabecera> items =
      bienvenidaList.map((e) => HogarCabecera.fromJson(e)).toList();
      return items ?? [];
    }
}
