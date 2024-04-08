//https://www.youtube.com/watch?v=y2uQ7XTgne8

class versionesModel {

  int? versionCondicion;
  int? versionOperadores;
  String? versionAplicacionVigente;
  int? versionUbigeo;
  int? versionAsistenciaTecnica;
  int? versionCampaniaSalud;
  int? versionCronogramaPago;
  int? versionLocalPago;
  int? versionModalidadPago;
  int? versionPuntoPago;
  int? versionTipoDiscapacidad;
  int? versionTecho;
  int? versionPared;
  int? versionCocina;
  int? versionAgua;
  int? versionSaneamiento;
  int? versionLuz;
  int? versionSaberes;
  int? versionSaberesTema;
  int? versionSaberesGrado;
  int? versionSaberesNivel;
  int? versionTipoDiscapacidadSaberes;
  int? versionTipoCampania;
  int? versionCharlaInclusion;
  int? versionCharlaGenero;
  int? versionInstancia;
  int? versionTipoVictima;
  int? versionTipoViolencia;
  int? versionCharlaDiscapacidad;
  int? versionCharlaSalud;
  int? versionOtrasEnfermedades;
  int? versionUltimoControlSalud;
  int? versionProximaCitaSalud;
  int? versionPeriodoDiagnostico;
  int? versionMedicacionDiabetes;
  int? versionMedicacionHipertension;
  int? versionMedicacionArtritis;
  int? versionDiagnosticoVisual;
  int? versionDiagnosticoBucal;
  String? versionAno;


  versionesModel({
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
    this.versionAno
  });





  factory versionesModel.fromJson(dynamic json) {
    return versionesModel(
        versionCondicion: int.parse(json['versionCondicion'].toString()),
        versionOperadores: int.parse(json['versionOperadores'].toString()),
        versionAplicacionVigente: json['versionAplicacionVigente'].toString(),
        versionUbigeo: int.parse(json['versionUbigeo'].toString()),
        versionAsistenciaTecnica: int.parse(json['versionAsistenciaTecnica'].toString()),
        versionCampaniaSalud: int.parse(json['versionCampaniaSalud'].toString()),
        versionCronogramaPago: int.parse(json['versionCronogramaPago'].toString()),
        versionLocalPago: int.parse(json['versionLocalPago'].toString()),
        versionModalidadPago: int.parse(json['versionModalidadPago'].toString()),
        versionPuntoPago: int.parse(json['versionPuntoPago'].toString()),
        versionTipoDiscapacidad: int.parse(json['versionTipoDiscapacidad'].toString()),
        versionTecho: int.parse(json['versionTecho'].toString()),
        versionPared: int.parse(json['versionPared'].toString()),
        versionCocina: int.parse(json['versionCocina'].toString()),
        versionAgua: int.parse(json['versionAgua'].toString()),
        versionSaneamiento: int.parse(json['versionSaneamiento'].toString()),
        versionLuz: int.parse(json['versionLuz'].toString()),
        versionSaberes: int.parse(json['versionSaberes'].toString()),
        versionSaberesTema: int.parse(json['versionSaberesTema'].toString()),
        versionSaberesGrado: int.parse(json['versionSaberesGrado'].toString()),
        versionSaberesNivel: int.parse(json['versionSaberesNivel'].toString()),
        versionTipoDiscapacidadSaberes: int.parse(json['versionTipoDiscapacidadSaberes'].toString()),
        versionTipoCampania: int.parse(json['versionTipoCampania'].toString()),
        versionCharlaInclusion: int.parse(json['versionCharlaInclusion'].toString()),
        versionCharlaGenero: int.parse(json['versionCharlaGenero'].toString()),
        versionInstancia: int.parse(json['versionInstancia'].toString()),
        versionMedicacionDiabetes: int.parse(json['versionMedicacionDiabetes'].toString()),
        versionTipoViolencia: int.parse(json['versionTipoViolencia'].toString()),
        versionCharlaDiscapacidad: int.parse(json['versionCharlaDiscapacidad'].toString()),
        versionCharlaSalud: int.parse(json['versionCharlaSalud'].toString()),
        versionOtrasEnfermedades: int.parse(json['versionOtrasEnfermedades'].toString()),
        versionUltimoControlSalud: int.parse(json['versionUltimoControlSalud'].toString()),
        versionProximaCitaSalud: int.parse(json['versionProximaCitaSalud'].toString()),
        versionPeriodoDiagnostico: int.parse(json['versionPeriodoDiagnostico'].toString()),
        versionMedicacionHipertension: int.parse(json['versionMedicacionHipertension'].toString()),
        versionMedicacionArtritis: int.parse(json['versionMedicacionArtritis'].toString()),
        versionDiagnosticoVisual: int.parse(json['versionDiagnosticoVisual'].toString()),
        versionDiagnosticoBucal: int.parse(json['versionDiagnosticoBucal'].toString()),
        versionAno: (json['versionAno'].toString()));
  }

  static List<versionesModel> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<versionesModel> items =
    bienvenidaList.map((e) => versionesModel.fromJson(e)).toList();
    return items ?? [];
  }
}