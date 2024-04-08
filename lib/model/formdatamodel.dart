import 'package:floor/floor.dart';

import '../viewmodels/UI/opciones/menu_inicio_fin.dart';

@entity
class FormDataModel {
  @PrimaryKey(autoGenerate: true)
  int? id;
  EstadoActividad? estadoActividad;
  String? observaciones;
  String? tipoRegistro;
  String? fechaRegistro;

  FormDataModel(
      {this.id, this.estadoActividad, this.observaciones, this.tipoRegistro, this.fechaRegistro});

  factory FormDataModel.fromJson(dynamic json) {
    return FormDataModel(
        id: json['id'],
        estadoActividad: json['estadoActividad'],
        observaciones: json['observaciones'],
        tipoRegistro: json['tipoRegistro'],
        fechaRegistro: json['fechaRegistro']);
  }

  static List<FormDataModel> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<FormDataModel> items =
    bienvenidaList.map((e) => FormDataModel.fromJson(e)).toList();
    return items;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "estadoActividad": estadoActividad,
      "observaciones": observaciones,
      "tipoRegistro": tipoRegistro,
      "fechaRegistro": fechaRegistro
    };
  }
}