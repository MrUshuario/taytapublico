import 'package:floor/floor.dart';
@entity
class SaberesProductivos {
    @PrimaryKey(autoGenerate: true)
    int? id;
    String? fecha;
    String? codigoModular;
    String? codigoRegistroSaberes;
    String? nroNinos;
    String? nroNinas;

    SaberesProductivos({this.id, this.fecha, this.codigoModular,
      this.codigoRegistroSaberes, this.nroNinos, this.nroNinas});


    factory SaberesProductivos.fromJson(dynamic json) {
        return SaberesProductivos(
            id: json['id'],
            fecha: json['fecha'],
            codigoModular: json['codigoModular'],
            codigoRegistroSaberes: json['codigoRegistroSaberes'],
            nroNinos: json['nroNinos'],
            nroNinas: json['nroNinas'],
        );
    }

    static List<SaberesProductivos> listFromJson(dynamic json) {
        var bienvenidaList = json as List;
        List<SaberesProductivos> items =
        bienvenidaList.map((e) => SaberesProductivos.fromJson(e)).toList();
        return items ?? [];
    }

    Map<String, dynamic> toMap() {
        return {
            "id": id,
            "fecha": fecha,
            "codigoModular": codigoModular,
            "codigoRegistroSaberes": codigoRegistroSaberes,
            "nroNinos": nroNinos,
            "nroNinas": nroNinas
        };
    }
    
}
