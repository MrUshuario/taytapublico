
class HogarDetalle {

	int? codigoHogarDetalle;
    String? dni;
    String? apellidoPaterno;
    String? apellidoMaterno;
    String? nombres;
    String? fechaNacimiento;
    int? ocurrencia;
    
    int? fallecido;
    int? discapacidad;
    int? gestante;

  HogarDetalle({
      this.codigoHogarDetalle,
      this.dni,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.nombres,
      this.fechaNacimiento,
      this.ocurrencia,
      this.fallecido,
      this.discapacidad,
      this.gestante});

  factory HogarDetalle.fromJson(dynamic json)  => HogarDetalle(
      codigoHogarDetalle: json['codigoHogarDetalle'] as int?,
      dni: json['dni'] as String?,
      apellidoPaterno: json['apellidoPaterno'] as String?,
      apellidoMaterno: json['apellidoMaterno'] as String?,
      nombres: json['nombres'] as String?,
      fechaNacimiento: json['fechaNacimiento'] as String?,
      ocurrencia: json['ocurrencia'] as int?,
      fallecido: json['fallecido'] as int?,
      discapacidad: json['discapacidad'] as int?,
      gestante: json['gestante'] as int?,
  );

  static List<HogarDetalle> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<HogarDetalle> items =
    bienvenidaList.map((e) => HogarDetalle.fromJson(e)).toList();
    return items ?? [];
  }

}
