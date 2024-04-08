import 'package:floor/floor.dart';
@entity
class Miembros {
  @PrimaryKey(autoGenerate: true)
  int? id;
	String? fechaNacimiento;
  String? ocurrencia;
  String? hogarId;
  String? fallecido;
  String? gestante;

  Miembros({this.id, this.fechaNacimiento, this.ocurrencia, this.hogarId,
      this.fallecido, this.gestante});



  factory Miembros.fromJson(dynamic json) {
    return Miembros(
      id: json['id'],
      fechaNacimiento: json['fechaNacimiento'],
      ocurrencia: json['ocurrencia'],
      hogarId: json['hogarId'],
      fallecido: json['fallecido'],
      gestante: json['gestante'],);
  }

  static List<Miembros> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Miembros> items =
    bienvenidaList.map((e) => Miembros.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fechaNacimiento": fechaNacimiento,
      "ocurrencia": ocurrencia,
      "hogarId": hogarId,
      "fallecido": fallecido,
      "gestante": gestante

    };
  }
  
}
