import 'package:floor/floor.dart';
@entity
class Recorrido {
    @PrimaryKey(autoGenerate: true)
    int? id; //id recorrido
    String? id_usuario;
    String? latitud;
    String? longitud;
    String? fecha;
    String? hora;
    String? estado;

    Recorrido({this.id, this.id_usuario, this.latitud, this.longitud,
      this.fecha, this.hora, this.estado});



    factory Recorrido.fromJson(dynamic json) {
        return Recorrido(
            id: json['id'],
            id_usuario: json['id_usuario'],
            latitud: json['latitud'],
            longitud: json['longitud'],
            fecha: json['fecha'],
            hora: json['hora'],
            estado: json['estado']);
    }

    static List<Recorrido> listFromJson(dynamic json) {
        var bienvenidaList = json as List;
        List<Recorrido> items =
        bienvenidaList.map((e) => Recorrido.fromJson(e)).toList();
        return items ?? [];
    }

    Map<String, dynamic> toMap() {
        return {
            "id": id,
            "id_usuario": id_usuario,
            "latitud": latitud,
            "longitud": longitud,
            "fecha": fecha,
            "hora": hora,
            "estado": estado
        };
    }
    
}
