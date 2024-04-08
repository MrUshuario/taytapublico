import 'package:floor/floor.dart';
@entity
class TemporalBeneficiario {
    @PrimaryKey(autoGenerate: true)
    int? id;
    String? dniTemporal;
    String? APPATemporal;
    String? APMATemporal;
    String? nombresTemporal;

    TemporalBeneficiario({
      this.id, this.dniTemporal, this.APPATemporal, this.APMATemporal, this.nombresTemporal});

    factory TemporalBeneficiario.fromJson(dynamic json) {
        return TemporalBeneficiario(
            id: json['id'],
            dniTemporal: json['dniTemporal'],
            APPATemporal: json['APPATemporal'],
            APMATemporal: json['APMATemporal'],
            nombresTemporal: json['nombresTemporal']
        );
    }

    static List<TemporalBeneficiario> listFromJson(dynamic json) {
        var bienvenidaList = json as List;
        List<TemporalBeneficiario> items =
        bienvenidaList.map((e) => TemporalBeneficiario.fromJson(e)).toList();
        return items ?? [];
    }

    Map<String, dynamic> toMap() {
        return {
            "id": id,
            "dniTemporal": dniTemporal,
            "APPATemporal": APPATemporal,
            "APMATemporal": APMATemporal,
            "nombresTemporal": nombresTemporal
        };
    }
    
}
