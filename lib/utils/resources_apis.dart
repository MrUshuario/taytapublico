
class apisResources {
  //SERVICIOS REST
   static final String REST_URL		 							= "http://m.pension65.gob.pe:8080/";
   static final String REST_USUARIOS_IMEI   					= REST_URL + "RSAyza/usuarios.json";
   static final String REST_VERSION 							= REST_URL + "RSAyza/version.json";
   static final String REST_TIPO_CONDICION 						= REST_URL + "RSAyza/tipoCondicion.json";
   static final String REST_GRABAR_VISITA 						= REST_URL + "RSAyza/grabarVisita.json";
   static final String REST_GRABAR_VISITA_V2					= REST_URL + "RSAyza/grabarVisitaV2.json";
   static final String REST_UBIGEO 								= REST_URL + "RSAyza/ubigeo.json";
   static final String REST_ASISTENCIA_TECNICA					= REST_URL + "RSAyza/asistenciaTecnica.json";
   static final String REST_CAMPANIA_SALUD						= REST_URL + "RSAyza/campaniaSalud.json";
   static final String REST_LOCAL_PAGO							= REST_URL + "RSAyza/localPago.json";
   static final String REST_MODALIDAD_PAGO						= REST_URL + "RSAyza/modalidadPago.json";
   static final String REST_CRONOGRAMA_PAGO						= REST_URL + "RSAyza/cronogramaPago.json";
   static final String REST_PUNTO_PAGO							= REST_URL + "RSAyza/puntoPago.json";
   static final String REST_TIPO_DISCAPACIDAD					= REST_URL + "RSAyza/tipoDiscapacidad.json";
   static final String REST_SABERES_TIPOLOGIA					= REST_URL + "RSAyza/saberesTipologia.json";
   static final String REST_GRABAR_SABERES						= REST_URL + "RSAyza/grabarSaberes.json";
   static final String REST_GRABAR_SABERES_PRODUCTIVOS			= REST_URL + "RSAyza/grabarSaberesProductivos.json";
   static final String REST_GRABAR_SABERES_PRODUCTIVOS_V2		= REST_URL + "RSAyza/grabarSaberesProductivosV2.json";
   static final String REST_GRABAR_REPORTE_SABERES_PRODUCTIVOS	= REST_URL + "RSAyza/grabarReporteSaberesProductivos.json";
   static final String REST_SABERES_TEMA						= REST_URL + "RSAyza/tema.json";
   static final String REST_SABERES_NIVEL						= REST_URL + "RSAyza/nivel.json";
   static final String REST_SABERES_GRADO						= REST_URL + "RSAyza/grado.json";
   static final String REST_TIPO_DISCAPACIDAD_SABERES			= REST_URL + "RSAyza/tipoDiscapacidadSaberes.json";
   static final String REST_SABERES_SUB_TEMA					= REST_URL + "RSAyza/subTema.json";
   static final String REST_SABERES_SUB_TIPOLOGIA				= REST_URL + "RSAyza/subTipologia.json";
   static final String REST_TIPO_CAMPANIA						= REST_URL + "RSAyza/tipoCampania.json";
   static final String REST_GRABAR_CAMPANIA_SALUD				= REST_URL + "RSAyza/grabarCampaniaSalud.json";
   static final String REST_TIPO_CONCEPTO						= REST_URL + "RSGeneral/concepto.json";
   static final String REST_GRABAR_HOGAR						= REST_URL + "RSGeneral/grabarHogar.json";

  /*****************************************RVILELA************************************************/

   static final String REST_GRABAR_VISITACOLECTIVA				= REST_URL + "RSAyza/grabarVisitaColectiva.json";
   static final String REST_GRABAR_VISITA_DETALLE				= REST_URL + "RSAyza/grabarVisitaDetalle.json";

  /**********************************************************************************************************/

   static final String REST_CHARLA_INCLUSION					= REST_URL + "RSAyza/charlaInclusion.json";
   static final String REST_CHARLA_GENERO						= REST_URL + "RSAyza/charlaGenero.json";
   static final String REST_INSTANCIA							= REST_URL + "RSAyza/instancias.json";
   static final String REST_TIPO_VICTIMA						= REST_URL + "RSAyza/tipoVictima.json";
   static final String REST_TIPO_VIOLENCIA						= REST_URL + "RSAyza/tipoViolencia.json";
   static final String REST_CHARLA_DISCAPACIDAD					= REST_URL + "RSAyza/charlaDiscapacidad.json";

  /*REPORTE CONSOLIDADO INDIVIDUAL*/
   static final String REST_RC_VERIFICACIONES					= REST_URL + "RSAyza/reporteConsolidadoVerificaciones.json";
   static final String REST_RC_CONSULTA_SISFOH					= REST_URL + "RSAyza/reporteConsultaSisfoh.json";
   static final String REST_RC_DDJJ								= REST_URL + "RSAyza/reporteConsolidadoDeclaracionesJuradas.json";
   static final String REST_RC_PAGADURIAS						= REST_URL + "RSAyza/reporteConsolidadoHistoricoPagaduria.json";
   static final String REST_RC_CAMBIO_CONDICION					= REST_URL + "RSAyza/reporteConsolidadoHistoricoCambioCondicion.json";
   static final String REST_RC_REFERENCIA_SISFOH				= REST_URL + "RSAyza/reporteConsolidadoReferenciaSisfoh.json";
   static final String REST_RC_COTEJO_MASIVOS					= REST_URL + "RSAyza/reporteConsolidadoCotejoMasivos.json";
   static final String REST_RC_REEVALUACION						= REST_URL + "RSAyza/reporteConsolidadoReevaluacion.json";
   static final String REST_RC_CUENTAS_VIGILADAS				= REST_URL + "RSAyza/reporteConsolidadoCuentasVigiladas.json";

   static final String REST_CHARLA_SALUD						= REST_URL + "RSAyza/charlaSalud.json";
   static final String REST_OTRAS_ENFERMEDADES					= REST_URL + "RSAyza/otrasEnfermedades.json";
   static final String REST_ULTIMO_CONTROL_SALUD				= REST_URL + "RSAyza/ultimoControlSalud.json";
   static final String REST_PROXIMA_CITA_SALUD					= REST_URL + "RSAyza/proximaCitaSalud.json";
   static final String REST_PERIODO_DIAGNOSTICO					= REST_URL + "RSAyza/periodoDiagnostico.json";
   static final String REST_MEDICACION_DIABETES					= REST_URL + "RSAyza/medicacionDiabetes.json";
   static final String REST_MEDICACION_HIPERTENSION				= REST_URL + "RSAyza/medicacionHipertension.json";
   static final String REST_MEDICACION_ARTRITIS					= REST_URL + "RSAyza/medicacionArtritis.json";
   static final String REST_DIAGNOSTICO_VISUAL					= REST_URL + "RSAyza/diagnosticoVisual.json";
   static final String REST_DIAGNOSTICO_BUCAL					= REST_URL + "RSAyza/diagnosticoBucal.json";

  /**********************************************RVILELA***************************************************************************/
   static final String REST_ACCIONES_VISITACOLECTIVA					= REST_URL + "RSAyza/AY_VCOL_ACCIONES.json";
/****************************************************************************************************************************/
}