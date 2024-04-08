import 'package:floor/floor.dart';
@entity
class Version {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? versionCondicion;
  String? versionOperadores;
  String? versionAplicacionVigente;
  String? versionUbigeo;
  String? versionAsistenciaTecnica;
  String? versionCampaniaSalud;
  String? versionCronogramaPago;
  String? versionLocalPago;
  String? versionModalidadPago;
  String? versionPuntoPago;
  String? versionTipoDiscapacidad;
  String? versionTecho;
  String? versionPared;
  String? versionCocina;
  String? versionAgua;
  String? versionSaneamiento;
  String? versionLuz;
  String? versionSaberes;
  String? versionSaberesTema;
  String? versionSaberesGrado;
  String? versionSaberesNivel;
  String? versionTipoDiscapacidadSaberes;
  String? versionTipoCampania;
  String? versionCharlaInclusion;
  String? versionCharlaGenero;
  String? versionInstancia;
  String? versionTipoVictima;
  String? versionTipoViolencia;
  String? versionCharlaDiscapacidad;
  String? versionCharlaSalud;
  String? versionOtrasEnfermedades;
  String? versionUltimoControlSalud;
  String? versionProximaCitaSalud;
  String? versionPeriodoDiagnostico;
  String? versionMedicacionDiabetes;
  String? versionMedicacionHipertension;
  String? versionMedicacionArtritis;
  String? versionDiagnosticoVisual;
  String? versionDiagnosticoBucal;
  String? versionAno;

  Version({
      this.id,
      this.versionCondicion,
      this.versionOperadores,
      this.versionAplicacionVigente,
      this.versionUbigeo,
      this.versionAsistenciaTecnica,
      this.versionCampaniaSalud,
      this.versionCronogramaPago,
      this.versionLocalPago,
      this.versionModalidadPago,
      this.versionPuntoPago,
      this.versionTipoDiscapacidad,
      this.versionTecho,
      this.versionPared,
      this.versionCocina,
      this.versionAgua,
      this.versionSaneamiento,
      this.versionLuz,
      this.versionSaberes,
      this.versionSaberesTema,
      this.versionSaberesGrado,
      this.versionSaberesNivel,
      this.versionTipoDiscapacidadSaberes,
      this.versionTipoCampania,
      this.versionCharlaInclusion,
      this.versionCharlaGenero,
      this.versionInstancia,
      this.versionTipoVictima,
      this.versionTipoViolencia,
      this.versionCharlaDiscapacidad,
      this.versionCharlaSalud,
      this.versionOtrasEnfermedades,
      this.versionUltimoControlSalud,
      this.versionProximaCitaSalud,
      this.versionPeriodoDiagnostico,
      this.versionMedicacionDiabetes,
      this.versionMedicacionHipertension,
      this.versionMedicacionArtritis,
      this.versionDiagnosticoVisual,
      this.versionDiagnosticoBucal,
      this.versionAno});



factory Version.fromJson(dynamic json) {
    return Version(
        versionCondicion: json['versionCondicion'],
        versionOperadores: json['versionOperadores'],
        versionAplicacionVigente: json['versionAplicacionVigente'],
        versionUbigeo: json['versionUbigeo'],
        versionAsistenciaTecnica: json['versionAsistenciaTecnica'],
        versionCampaniaSalud: json['versionCampaniaSalud'],
        versionCronogramaPago: json['versionCronogramaPago'],
        versionLocalPago: json['versionLocalPago'],
        versionModalidadPago: json['versionModalidadPago'],
        versionPuntoPago: json['versionPuntoPago'],
        versionTipoDiscapacidad: json['versionTipoDiscapacidad'],
        versionTecho: json['versionTecho'],
        versionPared: json['versionPared'],
        versionCocina: json['versionCocina'],
        versionAgua: json['versionAgua'],
        versionSaneamiento: json['versionSaneamiento'],
        versionLuz: json['versionLuz'],
        versionSaberes: json['versionSaberes'],
        versionSaberesTema: json['versionSaberesTema'],
        versionSaberesGrado: json['versionSaberesGrado'],
        versionSaberesNivel: json['versionSaberesNivel'],
        versionTipoDiscapacidadSaberes: json['versionTipoDiscapacidadSaberes'],
        versionTipoCampania: json['versionTipoCampania'],
        versionCharlaInclusion: json['versionCharlaInclusion'],
        versionCharlaGenero: json['versionCharlaGenero'],
        versionInstancia: json['versionInstancia'],
        versionMedicacionDiabetes: json['versionMedicacionDiabetes'],
        versionTipoViolencia: json['versionTipoViolencia'],
        versionCharlaDiscapacidad: json['versionCharlaDiscapacidad'],
        versionCharlaSalud: json['versionCharlaSalud'],
        versionOtrasEnfermedades: json['versionOtrasEnfermedades'],
        versionUltimoControlSalud: json['versionUltimoControlSalud'],
        versionProximaCitaSalud: json['versionProximaCitaSalud'],
        versionPeriodoDiagnostico: json['versionPeriodoDiagnostico'],
        versionMedicacionHipertension: json['versionMedicacionHipertension'],
        versionMedicacionArtritis: json['versionMedicacionArtritis'],
        versionDiagnosticoVisual: json['versionDiagnosticoVisual'],
        versionDiagnosticoBucal: json['versionDiagnosticoBucal'],
        versionAno: json['versionAno']);
  }

  static List<Version> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Version> items =
    bienvenidaList.map((e) => Version.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() { return {
    'id': id,
    'versionCondicion': versionCondicion,
    'versionOperadores': versionOperadores,
    'versionAplicacionVigente': versionAplicacionVigente,
    'versionUbigeo': versionUbigeo,
    'versionAsistenciaTecnica': versionAsistenciaTecnica,
    'versionCampaniaSalud': versionCampaniaSalud,
    'versionCronogramaPago': versionCronogramaPago,
    'versionLocalPago': versionLocalPago,
    'versionModalidadPago': versionModalidadPago,
    'versionPuntoPago': versionPuntoPago,
    'versionTipoDiscapacidad': versionTipoDiscapacidad,
    'versionTecho': versionTecho,
    'versionPared': versionPared,
    'versionCocina': versionCocina,
    'versionAgua': versionAgua,
    'versionSaneamiento': versionSaneamiento,
    'versionLuz': versionLuz,
    'versionSaberes': versionSaberes,
    'versionSaberesTema': versionSaberesTema,
    'versionSaberesGrado': versionSaberesGrado,
    'versionSaberesNivel': versionSaberesNivel,
    'versionTipoDiscapacidadSaberes': versionTipoDiscapacidadSaberes,
    'versionTipoCampania': versionTipoCampania,
    'versionCharlaInclusion': versionCharlaInclusion,
    'versionCharlaGenero': versionCharlaGenero,
    'versionInstancia': versionInstancia,
    'versionTipoVictima': versionTipoVictima,
    'versionTipoViolencia': versionTipoViolencia,
    'versionCharlaDiscapacidad': versionCharlaDiscapacidad,
    'versionCharlaSalud': versionCharlaSalud,
    'versionOtrasEnfermedades': versionOtrasEnfermedades,
    'versionUltimoControlSalud': versionUltimoControlSalud,
    'versionProximaCitaSalud': versionProximaCitaSalud,
    'versionPeriodoDiagnostico': versionPeriodoDiagnostico,
    'versionMedicacionDiabetes': versionMedicacionDiabetes,
    'versionMedicacionHipertension': versionMedicacionHipertension,
    'versionMedicacionArtritis': versionMedicacionArtritis,
    'versionDiagnosticoVisual': versionDiagnosticoVisual,
    'versionDiagnosticoBucal': versionDiagnosticoBucal,
    'versionAno': versionAno,
  };
   
  }

}