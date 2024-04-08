import 'package:floor/floor.dart';
@entity
class VcolAcciones {
    @PrimaryKey(autoGenerate: true)
    int? id;
    String? codigo_acciones;
    String? descripcion_acciones;

    VcolAcciones({this.id, this.codigo_acciones, this.descripcion_acciones});

    factory VcolAcciones.fromJson(dynamic json) {
        return VcolAcciones(
            id: json['id'],
            codigo_acciones: json['codigo_acciones'],
            descripcion_acciones: json['descripcion_acciones']
        );
    }


    static List<VcolAcciones> listFromJson(dynamic json) {
        var bienvenidaList = json as List;
        List<VcolAcciones> items =
        bienvenidaList.map((e) => VcolAcciones.fromJson(e)).toList();
        return items ?? [];
    }

    Map<String, dynamic> toMap() {
        return {
            "id": id,
            "codigo_acciones": codigo_acciones,
            "descripcion_acciones": descripcion_acciones,
        };
    }

}
