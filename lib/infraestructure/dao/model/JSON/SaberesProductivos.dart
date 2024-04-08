
class SaberesProductivos {

	int? codigoSaberesProd;
	String? ubigeo;
	String? fecha;
	String? codigoModular;
	String? codigoRegistro;
	int? codigoSaberesTipologia;
	int? nroUsuariosMasculino;
	int? nroUsuariosFemenino;
	int? nroNinos;
	int? nroNinas;
    String? comentario;
    String? usuarioCreacion;
    String? fechaCreacion;
    String? versionAplicacion;
    String? fechaSincronizacion;
    String? latitud;
    String? longitud;
    String? altitud;
    String? imei;
    int? codRegistro;
    
    List<SaberesProductivos>? listaSaberes;

  SaberesProductivos({
      this.codigoSaberesProd,
      this.ubigeo,
      this.fecha,
      this.codigoModular,
      this.codigoRegistro,
      this.codigoSaberesTipologia,
      this.nroUsuariosMasculino,
      this.nroUsuariosFemenino,
      this.nroNinos,
      this.nroNinas,
      this.comentario,
      this.usuarioCreacion,
      this.fechaCreacion,
      this.versionAplicacion,
      this.fechaSincronizacion,
      this.latitud,
      this.longitud,
      this.altitud,
      this.imei,
      this.codRegistro,
      this.listaSaberes});

  factory SaberesProductivos.fromJson(dynamic json)  =>
      SaberesProductivos(
        codigoSaberesProd: json['codigoSaberesProd'] as int?,
        ubigeo: json['ubigeo'] as String?,
        fecha: json['fecha'] as String?,
        codigoModular: json['codigoModular'] as String?,
        codigoRegistro: json['codigoRegistro'] as String?,
        codigoSaberesTipologia: json['codigoSaberesTipologia'] as int?,
        nroUsuariosMasculino: json['nroUsuariosMasculino'] as int?,
        nroUsuariosFemenino: json['nroUsuariosFemenino'] as int?,
        nroNinos: json['nroNinos'] as int?,
        nroNinas: json['nroNinas'] as int?,
        comentario: json['comentario'] as String?,
        usuarioCreacion: json['usuarioCreacion'] as String?,
        fechaCreacion: json['fechaCreacion'] as String?,
        versionAplicacion: json['versionAplicacion'] as String?,
        fechaSincronizacion: json['fechaSincronizacion'] as String?,
        latitud: json['latitud'] as String?,
        longitud: json['longitud'] as String?,
        altitud: json['altitud'] as String?,
        imei: json['imei'] as String?,
        codRegistro: json['codRegistro'] as int?,
        listaSaberes: (json['listaSaberes'] as List<dynamic>?)
            ?.map((e) =>
            SaberesProductivos.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  static List<SaberesProductivos> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<SaberesProductivos> items =
    bienvenidaList.map((e) => SaberesProductivos.fromJson(e)).toList();
    return items ?? [];
  }
}
