import 'package:floor/floor.dart';
@entity
class CronogramaConocimiento {
    @PrimaryKey(autoGenerate: true)
    int? id;
    int? dia_limite;
    int? mes_limite;
    int? ano_limite;

    CronogramaConocimiento({
      this.id, this.dia_limite, this.mes_limite, this.ano_limite});

    factory CronogramaConocimiento.fromJson(dynamic json) {
        return CronogramaConocimiento(
            id: json['id'],
            dia_limite: json['dia_limite'],
            mes_limite: json['mes_limite'],
            ano_limite: json['ano_limite'],);
    }

    static List<CronogramaConocimiento> listFromJson(dynamic json) {
        var bienvenidaList = json as List;
        List<CronogramaConocimiento> items =
        bienvenidaList.map((e) => CronogramaConocimiento.fromJson(e)).toList();
        return items ?? [];
    }

    Map<String, dynamic> toMap() {
        return {
            "id": id,
            "dia_limite": dia_limite,
            "mes_limite": mes_limite,
            "ano_limite": ano_limite
        };
    }
    
}
