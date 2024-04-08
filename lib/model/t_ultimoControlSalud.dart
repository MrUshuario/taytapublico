import 'package:floor/floor.dart';
@entity
 class UltimoControlSalud {
  @PrimaryKey(autoGenerate: true)
  int? id;
	String? codigoUltimoControl;
	String? descripcion;

  UltimoControlSalud({this.id, this.codigoUltimoControl, this.descripcion});

  factory UltimoControlSalud.fromJson(dynamic json)  =>
      UltimoControlSalud(
        id: json['id'] as int?,
        codigoUltimoControl: json['codigoUltimoControl'] as String?,
        descripcion: json['descripcion'] as String?,
      );

  static List<UltimoControlSalud> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<UltimoControlSalud> items =
    bienvenidaList.map((e) => UltimoControlSalud.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "codigoUltimoControl": codigoUltimoControl,
      "descripcion": descripcion
    };
  }


 }
