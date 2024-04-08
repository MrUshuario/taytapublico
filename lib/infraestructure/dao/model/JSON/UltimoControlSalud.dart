
 class UltimoControlSalud {

	int? codigoUltimoControl;
	String? descripcion;

  UltimoControlSalud({this.codigoUltimoControl, this.descripcion});

  factory UltimoControlSalud.fromJson(dynamic json)  =>
      UltimoControlSalud(
        codigoUltimoControl: json['codigoUltimoControl'] as int?,
        descripcion: json['descripcion'] as String?,
      );

  static List<UltimoControlSalud> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<UltimoControlSalud> items =
    bienvenidaList.map((e) => UltimoControlSalud.fromJson(e)).toList();
    return items ?? [];
  }

}
