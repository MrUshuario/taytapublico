

import 'package:floor/floor.dart';

@entity
class ReponseInicioFinActividades {
  String? mensaje;
  int? indicador;

  ReponseInicioFinActividades(
      {this.mensaje,
        this.indicador});

  factory ReponseInicioFinActividades.fromJson(dynamic json) {
    return ReponseInicioFinActividades(
      mensaje: json['mensaje'],
      indicador: json['indicador'],
    );
  }

  static List<ReponseInicioFinActividades> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<ReponseInicioFinActividades> items =
    bienvenidaList.map((e) => ReponseInicioFinActividades.fromJson(e)).toList();
    return items;
  }

  Map<String, dynamic> toMap() {
    return {
      "mensaje": mensaje,
      "indicador": indicador,
    };
  }
}
