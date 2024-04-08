import 'package:floor/floor.dart';
@entity
 class VisitaColectiva {
  @PrimaryKey(autoGenerate: true)
    int?     id;
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
    String?  fecha_tablet_FOTO01;
    String?  fecha_tablet_FOTO02;
    String?  fecha_tablet_FOTO03;

    VisitaColectiva(
        {this.id, this.acciones, this.observaciones, this.Foto1, this.Foto2,
            this.Foto3, this.fecha_registro, this.latitud, this.longitd, this.IMEI,
            this.user_id, this.fecha_tablet, this.fecha_tablet_FOTO01, this.fecha_tablet_FOTO02, this.fecha_tablet_FOTO03
        });

    factory VisitaColectiva.fromJson(dynamic json) =>
        VisitaColectiva(
          id: json['id'] as int?,
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
          fecha_tablet_FOTO01: json['fecha_tablet_FOTO01'] as String?,
          fecha_tablet_FOTO02: json['fecha_tablet_FOTO02'] as String?,
          fecha_tablet_FOTO03: json['fecha_tablet_FOTO03'] as String?,
        );

    static List<VisitaColectiva> listFromJson(dynamic json) {
      var bienvenidaList = json as List;
      List<VisitaColectiva> items =
      bienvenidaList.map((e) => VisitaColectiva.fromJson(e)).toList();
      return items ?? [];
    }

    Map<String, dynamic> toMap() { return {
      'id': id,
      'acciones': acciones,
      'observaciones': observaciones,
      'Foto1': Foto1,
      'Foto2': Foto2,
      'Foto3': Foto3,
      'fecha_registro': fecha_registro,
      'latitud': latitud,
      'longitd': longitd,
      'IMEI': IMEI,
      'user_id': user_id,
      'fecha_tablet': fecha_tablet,
      'fecha_tablet_FOTO01': fecha_tablet_FOTO01,
      'fecha_tablet_FOTO02': fecha_tablet_FOTO02,
      'fecha_tablet_FOTO03': fecha_tablet_FOTO03,
    };
    }

 }
