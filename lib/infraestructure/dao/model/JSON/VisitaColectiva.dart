
 class VisitaColectiva {

    int?     id_visitacolectiva;
    String?  acciones;
    String?  observaciones;
    String?  Foto1;
    String?  Foto2;
    String?  Foto3;
    String?  fecha_registro;
    String?  latitud;
    String?  longitd;
    String?  IMEI;
    String?  user_id;
    String?  fecha_tablet;

    VisitaColectiva(
        {this.id_visitacolectiva, this.acciones, this.observaciones, this.Foto1, this.Foto2,
            this.Foto3, this.fecha_registro, this.latitud, this.longitd, this.IMEI,
            this.user_id, this.fecha_tablet
        });

    factory VisitaColectiva.fromJson(dynamic json) =>
        VisitaColectiva(
          id_visitacolectiva: json['id_visitacolectiva'] as int?,
          acciones: json['acciones'] as String?,
          observaciones: json['observaciones'] as String?,
          Foto1: json['Foto1'] as String?,
          Foto2: json['Foto2'] as String?,
          Foto3: json['Foto3'] as String?,
          fecha_registro: json['fecha_registro'] as String?,
          latitud: json['latitud'] as String?,
          longitd: json['longitd'] as String?,
          IMEI: json['IMEI'] as String?,
          user_id: json['user_id'] as String?,
          fecha_tablet: json['fecha_tablet'] as String?,
        );

    static List<VisitaColectiva> listFromJson(dynamic json) {
      var bienvenidaList = json as List;
      List<VisitaColectiva> items =
      bienvenidaList.map((e) => VisitaColectiva.fromJson(e)).toList();
      return items ?? [];
    }

 }
