import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_ubigeo.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_usuariosLogin.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_version.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_visita.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_padron.dart';
import 'package:tayta/model/t_visita.dart';
import 'package:tayta/model/t_agua.dart';
import 'package:tayta/model/t_asistenciaTecnica.dart';
import 'package:tayta/model/t_campaniaSalud.dart';
import 'package:tayta/model/t_charlaDiscapacidad.dart';
import 'package:tayta/model/t_charlaGenero.dart';
import 'package:tayta/model/t_charlaInclusion.dart';
import 'package:tayta/model/t_charlaSalud.dart';
import 'package:tayta/model/t_cocina.dart';
import 'package:tayta/model/t_cronogramaConocimiento.dart';
import 'package:tayta/model/t_cronogramaPuntoPago.dart';
import 'package:tayta/model/t_diagnosticoBucal.dart';
import 'package:tayta/model/t_diagnosticoVisual.dart';
import 'package:tayta/model/t_instancia.dart';
import 'package:tayta/model/t_localPago.dart';
import 'package:tayta/model/t_luz.dart';
import 'package:tayta/model/t_medicacionArtritis.dart';
import 'package:tayta/model/t_medicacionDiabetes.dart';
import 'package:tayta/model/t_medicacionHipertension.dart';
import 'package:tayta/model/t_miembrosHogar.dart';
import 'package:tayta/model/t_modalidadPago.dart';
import 'package:tayta/model/t_otrasEnfermedades.dart';
import 'package:tayta/model/t_padron.dart';
import 'package:tayta/model/t_pared.dart';
import 'package:tayta/model/t_periodoDiagnostico.dart';
import 'package:tayta/model/t_proximaCitaSalud.dart';
import 'package:tayta/model/t_puntoPago.dart';
import 'package:tayta/model/t_recorrido.dart';
import 'package:tayta/model/t_saberesDetalle.dart';
import 'package:tayta/model/t_saberesProductivos.dart';
import 'package:tayta/model/t_saberesProductivosDetalle.dart';
import 'package:tayta/model/t_saberesProductivosGrado.dart';
import 'package:tayta/model/t_saberesProductivosNivel.dart';
import 'package:tayta/model/t_saberesProductivosSubTema.dart';
import 'package:tayta/model/t_saberesProductivosSubTipologia.dart';
import 'package:tayta/model/t_saberesProductivosTema.dart';
import 'package:tayta/model/t_saberesTipologia.dart';
import 'package:tayta/model/t_saneamiento.dart';
import 'package:tayta/model/t_techo.dart';
import 'package:tayta/model/t_temporalBeneficiario.dart';
import 'package:tayta/model/t_tipoCampania.dart';
import 'package:tayta/model/t_tipoCondicion.dart';
import 'package:tayta/model/t_tipoDiscapacidad.dart';
import 'package:tayta/model/t_tipoVictima.dart';
import 'package:tayta/model/t_tipoViolencia.dart';
import 'package:tayta/model/t_ubigeo.dart';
import 'package:tayta/model/t_ultimoControlSalud.dart';
import 'package:tayta/model/t_usuarios.dart';
import 'package:tayta/model/t_vColAcciones.dart';
import 'package:tayta/model/t_version.dart';
import 'package:tayta/model/t_visitaColectiva.dart';

import '../../../model/t_foto.dart';


part 'database.g.dart';
//FALTA TVISITA y VISITA PROBLEM

/*
, Agua, AsistenciaTecnica,
  CampaniaSalud, CharlaDiscapacidad, CharlaGenero,
  CharlaInclusion, CharlaSalud, Cocina, CronogramaConocimiento,
  CronogramaPuntoPago, DiagnosticoBucal, DiagnosticoVisual,
  Instancia, LocalPago, Luz, MedicacionArtritis,
  MedicacionDiabetes, MedicacionHipertension, Miembros,
  ModalidadPago, OtrasEnfermedad, Padron, Pared,
  PeriodoDiagnostico, ProximaCitaSalud, PuntoPago,
  Recorrido, SaberesDetalle, SaberesProductivos,
  SaberesProductivosDetalle, SaberesProductivoGrado,
  SaberesProductivosNivel, SaberesProductivosSubTema,
  SaberesProductivosSubTipologia, SaberesProductivosTema,
  SaberesTipologia, Saneamiento, Techo, TemporalBeneficiario,
  TipoCampania, TipoCondicion, TipoDiscapacidad, TipoVictima,
  TipoViolencia, Ubigeo, UltimoControlSalud, usuarios,
  VcolAcciones, Version, VisitaColectiva
 */

@Database(version: 1, entities:
[ Visitas, Agua, AsistenciaTecnica,
  CampaniaSalud, CharlaDiscapacidad, CharlaGenero,
  CharlaInclusion, CharlaSalud, Cocina, CronogramaConocimiento,
  CronogramaPuntoPago, DiagnosticoBucal, DiagnosticoVisual,
  Instancia, LocalPago, Luz, MedicacionArtritis,
  MedicacionDiabetes,MedicacionHipertension, Miembros,
  ModalidadPago, OtrasEnfermedad, Padron, Pared,
  PeriodoDiagnostico, ProximaCitaSalud, PuntoPago,
  Recorrido, SaberesDetalle, SaberesProductivos,
  SaberesProductivosDetalle, SaberesProductivoGrado,
  SaberesProductivosNivel, SaberesProductivosSubTema,
  SaberesProductivosSubTipologia, SaberesProductivosTema,
  SaberesTipologia, Saneamiento, Techo, TemporalBeneficiario,
  TipoCampania, TipoCondicion, TipoDiscapacidad, TipoVictima,
  TipoViolencia, Ubigeo, UltimoControlSalud, usuarios,
  VcolAcciones, Version, VisitaColectiva, Foto])

abstract class AppDatabase extends FloorDatabase {
  FormDataModelDaoVISITA get formDataModelDaoVisita;
  FormDataModelDaoPADRON get formDataModelDaoPadron;
  FormDataModelDaoVERSION get formDataModelDaoVersion;
  FormDataModelDaoUSUARIOS get formDataModelDaoUsuarios;
  FormDataModelDaoUBIGEO get formDataModelDaoUbigeo;
}