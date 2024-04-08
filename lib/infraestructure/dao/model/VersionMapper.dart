import 'package:tayta/infraestructure/dao/model/JSON/versionesModel.dart';
import 'package:tayta/model/t_version.dart';

class VersionMapper {
  // Atributo privado para la versión actual
  static String _versionActual = "";

  // Constructor privado para evitar la instanciación directa
  VersionMapper._();

  // Método statico para obtener la instancia única
  static VersionMapper get instance => VersionMapper._();

  // Función para obtener la versión actual
  String get versionActual => _versionActual;

  Version guardarVersion(versionesModel versionesGuardar){

    Version versionEntity = Version();
    versionEntity.id = 1;
    versionEntity.versionCondicion = versionesGuardar.versionCondicion.toString();
    versionEntity.versionOperadores = versionesGuardar.versionOperadores.toString();
    versionEntity.versionAplicacionVigente = versionesGuardar.versionAplicacionVigente.toString();
    versionEntity.versionUbigeo = versionesGuardar.versionUbigeo.toString();
    versionEntity.versionAsistenciaTecnica = versionesGuardar.versionAsistenciaTecnica.toString();
    versionEntity.versionCampaniaSalud = versionesGuardar.versionCampaniaSalud.toString();
    versionEntity.versionCronogramaPago =  versionesGuardar.versionCronogramaPago.toString();
    versionEntity.versionLocalPago = versionesGuardar.versionLocalPago.toString();
    versionEntity.versionModalidadPago = versionesGuardar.versionModalidadPago.toString();
    versionEntity.versionPuntoPago = versionesGuardar.versionPuntoPago.toString();
    versionEntity.versionTipoDiscapacidad = versionesGuardar.versionTipoDiscapacidad.toString();
    versionEntity.versionTecho = versionesGuardar.versionTecho.toString();
    versionEntity.versionPared = versionesGuardar.versionPared.toString();
    versionEntity.versionCocina = versionesGuardar.versionCocina.toString();
    versionEntity.versionAgua = versionesGuardar.versionAgua.toString();
    versionEntity.versionSaneamiento = versionesGuardar.versionSaneamiento.toString();
    versionEntity.versionLuz = versionesGuardar.versionLuz.toString();
    versionEntity.versionSaberes = versionesGuardar.versionSaberes.toString();
    versionEntity.versionSaberesTema = versionesGuardar.versionSaberesTema.toString();
    versionEntity.versionSaberesGrado = versionesGuardar.versionSaberesGrado.toString();
    versionEntity.versionSaberesNivel = versionesGuardar.versionSaberesNivel.toString();
    versionEntity.versionTipoDiscapacidadSaberes = versionesGuardar.versionTipoDiscapacidadSaberes.toString();
    versionEntity.versionTipoCampania = versionesGuardar.versionTipoCampania.toString();
    versionEntity.versionCharlaInclusion = versionesGuardar.versionCharlaInclusion.toString();
    versionEntity.versionCharlaGenero = versionesGuardar.versionCharlaGenero.toString();
    versionEntity.versionInstancia =  versionesGuardar.versionInstancia.toString();
    versionEntity.versionTipoVictima = versionesGuardar.versionTipoVictima.toString();
    versionEntity.versionTipoViolencia =  versionesGuardar.versionTipoViolencia.toString();
    versionEntity.versionCharlaDiscapacidad =  versionesGuardar.versionCharlaDiscapacidad.toString();
    versionEntity.versionCharlaSalud = versionesGuardar.versionCharlaSalud.toString();
    versionEntity.versionOtrasEnfermedades = versionesGuardar.versionOtrasEnfermedades.toString();
    versionEntity.versionUltimoControlSalud = versionesGuardar.versionUltimoControlSalud.toString();
    versionEntity.versionProximaCitaSalud = versionesGuardar.versionProximaCitaSalud.toString();
    versionEntity.versionPeriodoDiagnostico = versionesGuardar.versionPeriodoDiagnostico.toString();
    versionEntity.versionMedicacionDiabetes = versionesGuardar.versionMedicacionDiabetes.toString();
    versionEntity.versionMedicacionHipertension = versionesGuardar.versionMedicacionHipertension.toString();
    versionEntity.versionMedicacionArtritis = versionesGuardar.versionMedicacionArtritis.toString();
    versionEntity.versionDiagnosticoVisual = versionesGuardar.versionDiagnosticoVisual.toString();
    versionEntity.versionDiagnosticoBucal = versionesGuardar.versionDiagnosticoBucal.toString();
    versionEntity.versionAno = versionesGuardar.versionAno.toString();

    return versionEntity;
  }


}
