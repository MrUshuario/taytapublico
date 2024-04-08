
class VisitaColectiva_Detalle {

    int? id_detalle_visita_colectiva;
    int? id_visita_colectiva;
    String? appa;
    String? apma;
    String? nombres;
    String? DNI;

    VisitaColectiva_Detalle({this.id_detalle_visita_colectiva,
      this.id_visita_colectiva, this.appa, this.apma, this.nombres, this.DNI});

    factory VisitaColectiva_Detalle.fromJson(dynamic json)  =>
        VisitaColectiva_Detalle(
            id_detalle_visita_colectiva: json['id_detalle_visita_colectiva'] as int?,
            id_visita_colectiva: json['id_visita_colectiva'] as int?,
            appa: json['appa'] as String?,
            apma: json['apma'] as String?,
            nombres: json['nombres'] as String?,
            DNI: json['DNI'] as String?,
        );

    static List<VisitaColectiva_Detalle> listFromJson(dynamic json) {
      var bienvenidaList = json as List;
      List<VisitaColectiva_Detalle> items =
      bienvenidaList.map((e) => VisitaColectiva_Detalle.fromJson(e)).toList();
      return items ?? [];
    }


}
