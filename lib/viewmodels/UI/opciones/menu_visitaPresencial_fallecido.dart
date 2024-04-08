import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/infraestructure/dao/database/database.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_visita.dart';
import 'package:tayta/infraestructure/repository/devicesinfoplusrepository.dart';
import 'package:tayta/infraestructure/repository/locationrepository.dart';
import 'package:tayta/main.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpers.dart';
import 'package:tayta/utils/helpersviewAlertMensaje.dart';
import 'package:tayta/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:tayta/utils/helpersviewAlertProgressCircle.dart';
import 'package:tayta/utils/helpersviewBlancoDNI.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewBlancoSelect.dart';
import 'package:tayta/utils/helpersviewCamera.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/helpersviewLetrasSubs.dart';
import 'package:tayta/utils/helpersviewTextSize.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_contactoReferencia.dart';

import '../../../model/t_visita.dart';
import '../../../utils/camera.dart';
import '../../../utils/helpersviewAlertFaltaMSG.dart';
import '../../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../../utils/viewdisplayfoto.dart';

class MenuVisitaPresencialFallecido extends StatefulWidget {
  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;
  bool? isShowButtonCameraInitial = true;
  List<XFile>? listMediaPath;



  GlobalKey<FormState> keyForm = GlobalKey();

  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formPaternoCtrl = TextEditingController();
  TextEditingController formMaternoCtrl = TextEditingController();
  TextEditingController formNombresCtrl = TextEditingController();
  TextEditingController formObservacionesCtrl = TextEditingController();

  TextEditingController formFallecimientoDateCtrl = TextEditingController();
  TextEditingController formDNICtrlFALLECIDO = TextEditingController();
  TextEditingController formPaternoCtrlFALLECIDO = TextEditingController();
  TextEditingController formMaternoCtrlFALLECIDO = TextEditingController();
  TextEditingController formNombresCtrlFALLECIDO = TextEditingController();
  TextEditingController formObservacionesCtrlFALLECIDO = TextEditingController();

  TextEditingController formTelefonoCtrl = TextEditingController();
  TextEditingController formPersonaCtrl = TextEditingController();
  TextEditingController formIngresarObsCtrl = TextEditingController();
  TextEditingController formBeneficiarioCondicionCtrl = TextEditingController();
  TextEditingController formDireccionCtrl = TextEditingController();
  TextEditingController formDistritoCtrl = TextEditingController();
  TextEditingController formTelefonoContactoCtrl = TextEditingController();
  TextEditingController formPersonaContactoCtrl = TextEditingController();
  TextEditingController formDetallarSubensionCtrl = TextEditingController();
  TextEditingController formCondicionVisitaCtrl = TextEditingController();
  TextEditingController formVulnerabilidadAdicionalCtrl = TextEditingController();
  TextEditingController formDetallarVulnerabilidadCtrl = TextEditingController();
  TextEditingController formCharlaCtrl = TextEditingController();


  final ParamBeneficiarioCondicion = List.filled(3, "", growable: false);
  final ParamCondicionVisita= List.filled(3, "", growable: false);
  final ParamVulnerabilidadAdicional= List.filled(3, "", growable: false);
  final ParamCharla= List.filled(3, "", growable: false);

  String? mediaPath;
  String imageSource = Resources.sateliterojo;
  Visitas? formData;
  MenuVisitaPresencialFallecido(this.listMediaPath, this.formData, {super.key});


  List<String> listCondicioSiFallecido = [
    "Fallecimiento con acta de defunción",
    "Fallecimiento sin acta de defunción",
  ];

  List<String> listCondicionNoFallecido = [
    "Visita Domiciliaria",
    "Visita Domiciliaria con tercero autorizado",
    "Potencial Usuario",
  ];

  //SI ELIJE VISITA DOMICILIARIA
  List<String> listCondicionVisita = [
    "Visita Regular",
    "Visita Por Alerta CTVC",
    "Reclamo",
    "Requerimiento de sede",
    "Alerta de Violencia",
    "Solicitud de Cobro Tercero",
  ];

  List<String> ListVulnerabilidadADicional = [
    "En Abandono",
    "Situacion de Calle",
    "Enfermedad Terminal",
    "Carga Familiar",
    "Otro",
  ];

  List<String> ListCharla = [
    "Envejecimiento Saludable",
    "Autocuidado del aparato locomotor",
    "Alimentación Saludable",
    "Importancia de una vivienda",
    "Primeros auxilios",
  ];

  
  @override
  State<StatefulWidget> createState() {
    return _MenuVisitaPresencial();
  }
}

///RADION BUTTON
enum EstadoFallecido { Si, No } //SOLO SIRVE PARA MOSTRAR NO SE GUARDA
enum EstadoCondicion { Ocurrencias, Visitas }
enum EstadoCondicionFALLECIDO { Ocurrencias, Visitas }

enum EstadoVulnerabilidad {Si, No}
enum EstadoCobroModalidad { Agencia, ETV, PAD, Tarjeta, Carta_Poder }
enum EstadoDeclaracionJurada { Si, No }
enum EstadoCobroSubencion { Si, No }
enum EstadoEducacion { Si, No }

//TERCERO AUTORIZADO
enum TerceroConforme {Si, No}
enum TerceroTotalidad {Si, No}
enum TerceroRevocatoria {Si, No}

class _MenuVisitaPresencial extends State<MenuVisitaPresencialFallecido> {

  late int PREFversionInstancia;
  late String PREFversionAplicacionVigente;
  late int PREFversionCondicion;
  late int PREFversionOperador;
  late String PREFimei;

  late String GPSlatitude = "";
  late String GPSlongitude = "";
  late String GPSaltitude = "";

  @override
  void initState() {


    if (widget.listMediaPath!.isNotEmpty) {
      setState(() {
        widget.isShowButtonCameraInitial = false;
      });
    } else {
      setState(() {
        widget.isShowButtonCameraInitial = true;
      });
    }

    if (widget.formData != null && widget.formData!.observacion != null) {

    //SI FECHA DE FALLECIMIENTO TRUE/FALSE ( MUERTO) ESTA VACIO IRA POR UNO U EL OTRO
        //CAMBIAR FECHA //
    if( !(widget.formData?.fechaFallecimiento?.isNotEmpty ?? true)) {
      //NO FALLECIDO
      _EstadoFallecido = EstadoFallecido.No;
      noFallecido = true;

      _EstadoCondicion = widget.formData!.tipoCondicion == 0
          ? EstadoCondicion.Ocurrencias
          : EstadoCondicion.Visitas;

      //POR ALGUN MOTIVO ESTO LO TRATAN COMO TRATAMIENTO DIABETES
      _EstadoCobroSubencion = widget.formData!.recibeTratamientoDiabetes == 1
          ? EstadoCobroSubencion.Si
          : EstadoCobroSubencion.No;

      if (widget.formData!.codigoMedicacionDiabetes == 1) {
        _EstadoCobroModalidad = EstadoCobroModalidad.Agencia;
      } else if (widget.formData!.codigoMedicacionDiabetes == 2) {
        _EstadoCobroModalidad = EstadoCobroModalidad.ETV;
      } else if (widget.formData!.codigoMedicacionDiabetes == 3) {
        _EstadoCobroModalidad = EstadoCobroModalidad.PAD;
      } else if (widget.formData!.codigoMedicacionDiabetes == 4) {
        _EstadoCobroModalidad = EstadoCobroModalidad.Tarjeta;
      } else if (widget.formData!.codigoMedicacionDiabetes == 5) {
        _EstadoCobroModalidad = EstadoCobroModalidad.Carta_Poder;
      }

      //LO TOMA COMO cumpleTratamientoHipertension
      _EstadoDeclaracionJurada = widget.formData!.cumpleTratamientoHipertension == 1
          ? EstadoDeclaracionJurada.Si
          : EstadoDeclaracionJurada.No;

      //DEL LISTADO SACA 2  setDescripcionMedicacionOtraEnfermedad (lo que dice) setRecibeTratamientoOtraEnfermedad (el indice numero) NO TIENE API
      if (widget.formData!.recibeTratamientoOtraEnfermedad == 0) {
        _EstadoVulnerabilidad = EstadoVulnerabilidad.No;
        widget.formVulnerabilidadAdicionalCtrl!.text = "Seleccionar Vulnerabilidad Adicional";
      } else if (widget.formData!.recibeTratamientoOtraEnfermedad == 1) {
        HayVulnerabilidadAdicional = true;
        _EstadoVulnerabilidad = EstadoVulnerabilidad.Si;
        widget.formVulnerabilidadAdicionalCtrl!.text = "En abandono"; //ListVulnerabilidadADicional(posicion 0)
      } else if (widget.formData!.recibeTratamientoOtraEnfermedad == 2) {
        HayVulnerabilidadAdicional = true;
        _EstadoVulnerabilidad = EstadoVulnerabilidad.Si;
        widget.formVulnerabilidadAdicionalCtrl!.text = "Situación de calle"; //ListVulnerabilidadADicional(posicion 1)
      } else if (widget.formData!.recibeTratamientoOtraEnfermedad == 3) {
        HayVulnerabilidadAdicional = true;
        _EstadoVulnerabilidad = EstadoVulnerabilidad.Si;
        widget.formVulnerabilidadAdicionalCtrl!.text = "Enfermedad terminal"; //ListVulnerabilidadADicional(posicion 2)
      } else if (widget.formData!.recibeTratamientoOtraEnfermedad == 4) {
        HayVulnerabilidadAdicional = true;
        _EstadoVulnerabilidad = EstadoVulnerabilidad.Si;
        widget.formVulnerabilidadAdicionalCtrl!.text = "Carga familiar";
      } else if (widget.formData!.recibeTratamientoOtraEnfermedad == 5) { //ListVulnerabilidadADicional(posicion 3)
        HayVulnerabilidadAdicional = true;
        _EstadoVulnerabilidad = EstadoVulnerabilidad.Si;

        //AHORA SI SE ACTIVA EL FORM DETALLAR
        setState(() {
          widget.formVulnerabilidadAdicionalCtrl!.text = "Otro";
          widget.formDetallarVulnerabilidadCtrl!.text = widget.formData!.descripcionMedicacionOtraEnfermedad!;
        });

      }

      //RECIBIO EDUCACION FINANCIERA (SE GUARDA EN TIENE LENTES) Si = 1 No = 0
      _EstadoEducacion = widget.formData!.tieneLentes == 1
          ? EstadoEducacion.Si
          : EstadoEducacion.No; //2 u otro

      setState(() {

        widget.formDNICtrl!.text = widget.formData!.dni!;
        widget.formPaternoCtrl!.text = widget.formData!.apepat!;
        widget.formMaternoCtrl!.text = widget.formData!.apemat!;
        widget.formNombresCtrl!.text = widget.formData!.nombres!;
        widget.formIngresarObsCtrl!.text = widget.formData!.observacion!;
        widget.formDistritoCtrl!.text = widget.formData!.distrito!;
        widget.formDireccionCtrl!.text = widget.formData!.direccion!;
        widget.formTelefonoContactoCtrl!.text = widget.formData!.telefonoContacto!;
        widget.formPersonaContactoCtrl!.text = widget.formData!.personaContacto!;
        widget.formDetallarSubensionCtrl!.text = widget.formData!.otrosDiabetes!;

        //ESTE ESTA COMPLICADO PARA QUE NO SIRVE PAR//ESTE ESTA COMPLICADO PARA QUE NO SIRVE PARA NADA PERO EN REALIDAD SE RELACIONA CON UN SQL DE "NO NECESITA INFORMACION"
        //formCondicionVisitaCtrl


        //CHARLA SELECT PERO EL INDEX TRAER
        //widget.formCharlaCtrl!.text = widget.formData!.codigoSaberesTema!;

      });

    } else {
      //FALLECIDO
      _EstadoFallecido = EstadoFallecido.Si;
      siFallecido = true;

      //EXTRAER EL POSICIONAMIENTO USANDO API SE USA PARA CREAR LA TABLA VISITA
      //widget.formBeneficiarioCondicionCtrl!.text = widget.formData!.descripcionCondicion!;
      //widget.formBeneficiarioCondicionCtrl!.text = widget.formData!.codigoCondicion!;

      _EstadoCondicionFALLECIDO = widget.formData!.tipoCondicion == 0
          ? EstadoCondicionFALLECIDO.Ocurrencias
          : EstadoCondicionFALLECIDO.Visitas;

      setState(() {

        widget.formDNICtrlFALLECIDO!.text = widget.formData!.dni!;
        widget.formPaternoCtrlFALLECIDO!.text = widget.formData!.apepat!;
        widget.formMaternoCtrlFALLECIDO!.text = widget.formData!.apemat!;
        widget.formNombresCtrlFALLECIDO!.text = widget.formData!.nombres!;
        widget.formObservacionesCtrlFALLECIDO!.text = widget.formData!.observacion!;
        widget.formFallecimientoDateCtrl!.text = widget.formData!.fechaFallecimiento!;


      });

    }
    }

    super.initState();
    conseguirVersion();
  }

  bool isSatelliteGreen = false;
  CameraController? controller;

  Future<void> conseguirVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      PREFversionAplicacionVigente = prefs.getString('versionAplicacionVigente') ?? "aa";
      PREFversionCondicion = prefs.getInt('versionCondicion') ?? 2000;
      PREFversionOperador = prefs.getInt('versionOperador') ?? 3000;
      PREFimei = prefs.getString('imei') ?? "cc";

      GPSlatitude = prefs.getString('latitude') ?? "";
      GPSlongitude = prefs.getString('longitude') ?? "";
      GPSaltitude = prefs.getString('altitude') ?? "";

      if(GPSlatitude == ""){
        print("NO COORDENADAS");

      } else {
        print("HAY COORDENADAS");
        isSatelliteGreen = true;
        print("GPSlatitude: "+GPSlatitude);
        print("GPSlongitude: "+GPSlongitude);
        print("GPSaltitude: "+GPSaltitude);
      }


    });
  }


  //RADION BUTTOn
  EstadoFallecido? _EstadoFallecido = null;
  EstadoCondicion? _EstadoCondicion = null;
  EstadoCondicionFALLECIDO? _EstadoCondicionFALLECIDO = null;



  EstadoCobroModalidad? _EstadoCobroModalidad = null;
  EstadoCobroSubencion? _EstadoCobroSubencion=  null;
  EstadoEducacion? _EstadoEducacion = null;
  EstadoDeclaracionJurada? _EstadoDeclaracionJurada = null;
  EstadoVulnerabilidad? _EstadoVulnerabilidad = null;
  TerceroConforme? _TerceroConforme = null;
  TerceroTotalidad? _TerceroTotalidad = null;
  TerceroRevocatoria? _TerceroRevocatoria = null;

  bool siFallecido = false;
  bool noFallecido = false;
  //VULERNABILDIAD ADICIONAL
  bool HayVulnerabilidadAdicional = false;


  @override
  void dispose() {
    controller?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> setFechasFotosAndBytesFotos() async {
    if (widget.listMediaPath!.isNotEmpty && widget.listMediaPath!.isNotEmpty) {
      for (var i = 0; i < widget.listMediaPath!.length; i++) {
        if (i == 0) {
          widget.formData!.fotoUno =
              base64Encode(await widget.listMediaPath![i].readAsBytes());
          var date = await widget.listMediaPath![i].lastModified();
          widget.formData!.fechaTabletFotoUno = formatDate(
              "dd/MM/yyyy hh:mm:ss", date);
        } else if (i == 1) {
          widget.formData!.fotoDos =
              base64Encode(await widget.listMediaPath![i].readAsBytes());
          var date = await widget.listMediaPath![i].lastModified();
          widget.formData!.fechaTabletFotoDos = formatDate(
              "dd/MM/yyyy hh:mm:ss", date);
        } else if (i == 2) {
          widget.formData!.fotoTres =
              base64Encode(await widget.listMediaPath![i].readAsBytes());
          var date = await widget.listMediaPath![i].lastModified();
          widget.formData!.fechaTabletFotoTres = formatDate(
              "dd/MM/yyyy hh:mm:ss", date);
        } else {
          break;
        }
      }
      return Future(() => null);
    }
    return Future(() => null);
  }

  Future<void> capturarCoordenadas() async{
    HelpersViewCabecera.CoordenadasGPS(context).then((value) async {
      // Luego de recopilar la ubicación y la fecha, actualiza el estado del icono
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isSatelliteGreen = true;
        GPSlatitude = prefs.getString('latitude') ?? "";
        GPSlongitude = prefs.getString('longitude') ?? "";
        GPSaltitude = prefs.getString('altitude') ?? "";
      });
    });
  }

  void PedirPermiso(){

    showDialog(
        context: context,
        builder: (context){
          //AGREGAR ESTO POR SI QUIERO QUE EL DIALOG SE REFRESQUE
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [

                      HelpersViewAlertMensajeTitulo.formItemsDesign("Se recogerá sus coordenadas actuales"),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // Align row to the end
                        children: [
                          Spacer(), // Push remaining space to the left

                          InkWell(
                            onTap: () async {

                              await capturarCoordenadas();

                              Navigator.pop(context);
                            },

                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Aceptar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {

                              Navigator.of(context).pop();

                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Cancelar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ],
                  )
              )
          );

        }
    );

  }

  //GUARDAR FUNCTION
  Future<void> GuardarFormulario() async {

    widget.formData?.codigoRegistro =
        Resources.valor_Visita_Presencial;

    if(siFallecido) {
      // LO DE Sí FALLECIDO

      widget.formData?.dni =
      widget.formDNICtrlFALLECIDO!.text!.isEmpty
          ? ""
          : widget.formDNICtrlFALLECIDO!.text;

      widget.formData?.apepat =
      widget.formPaternoCtrlFALLECIDO!.text!.isEmpty
          ? ""
          : widget.formPaternoCtrlFALLECIDO!.text;

      widget.formData?.apemat =
      widget.formMaternoCtrlFALLECIDO!.text!.isEmpty
          ? ""
          : widget.formMaternoCtrlFALLECIDO!.text;

      widget.formData?.nombres =
      widget.formNombresCtrlFALLECIDO!.text!.isEmpty
          ? ""
          : widget.formNombresCtrlFALLECIDO!.text;

      widget.formData?.observacion =
      widget.formObservacionesCtrlFALLECIDO!.text!.isEmpty
          ? ""
          : widget.formObservacionesCtrlFALLECIDO!.text;

      widget.formData?.fechaFallecimiento =
      widget.formFallecimientoDateCtrl!.text!.isEmpty
          ? ""
          : widget.formFallecimientoDateCtrl!.text;


      //widget.formBeneficiarioCondicionCtrl!.text = widget.formData!.descripcionCondicion!;
      //widget.formBeneficiarioCondicionCtrl!.text = widget.formData!.codigoCondicion!;

      /*
      widget.formData?.descripcionCondicion =
      widget.formBeneficiarioCondicionCtrl!.text!.isEmpty
          ? ""
          : widget.formBeneficiarioCondicionCtrl!.text;

      widget.formData?.codigoCondicion = 0;
       */
      widget.formData?.tipoCondicion = 0;

    } else {
      // LO DE NO FALLECIDO

      widget.formData?.observacion =
      widget.formIngresarObsCtrl!.text!.isEmpty
          ? ""
          : widget.formIngresarObsCtrl!.text;

      widget.formData?.dni =
      widget.formDNICtrl!.text!.isEmpty
          ? ""
          : widget.formDNICtrl!.text;

      widget.formData?.apepat =
      widget.formPaternoCtrl!.text!.isEmpty
          ? ""
          : widget.formPaternoCtrl!.text;

      widget.formData?.apemat =
      widget.formMaternoCtrl!.text!.isEmpty
          ? ""
          : widget.formMaternoCtrl!.text;

      widget.formData?.nombres =
      widget.formNombresCtrl!.text!.isEmpty
          ? ""
          : widget.formNombresCtrl!.text;

      widget.formData?.distrito =
      widget.formDistritoCtrl!.text!.isEmpty
          ? ""
          : widget.formDistritoCtrl!.text;

      widget.formData?.direccion =
      widget.formDireccionCtrl!.text!.isEmpty
          ? ""
          : widget.formDireccionCtrl!.text;

      widget.formData?.telefonoContacto =
      widget.formTelefonoContactoCtrl!.text!.isEmpty
          ? ""
          : widget.formTelefonoContactoCtrl!.text;

      widget.formData?.personaContacto =
      widget.formPersonaContactoCtrl!.text!.isEmpty
          ? ""
          : widget.formPersonaContactoCtrl!.text;

      widget.formData?.otrosDiabetes =
      widget.formDetallarSubensionCtrl!.text!.isEmpty
          ? ""
          : widget.formDetallarSubensionCtrl!.text;

      //widget.formBeneficiarioCondicionCtrl!.text = widget.formData!.descripcionCondicion!;
      //widget.formBeneficiarioCondicionCtrl!.text = widget.formData!.codigoCondicion!;

      /*
      widget.formData?.descripcionCondicion =
      widget.formCondicionVisitaCtrl!.text!.isEmpty
          ? ""
          : widget.formCondicionVisitaCtrl!.text;

       */
      widget.formData?.tipoCondicion = _EstadoCondicion?.index;

    }





  }


  final _mostrarLoadingStreamController = StreamController<bool>.broadcast();
  void CargaDialog() {
    bool mostrarLOADING = false;
    showDialog(
      barrierDismissible: mostrarLOADING,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {

            _mostrarLoadingStreamController.stream.listen((value) {
              setState(() {
                mostrarLOADING = value;
              });
            });

            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    HelpersViewAlertProgressCircle(
                      mostrar: mostrarLOADING,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            Resources.titulo_Visita_Presencial,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFD60000),
          actions: [
            IconButton(
              icon: Image.asset(Resources.flechaazul),
              color: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Image.asset(Resources.iconInfo),
                          SizedBox(width: 4), // Espacio entre el icono y el texto
                          Expanded(
                            child: Text(
                              '¿Seguro que quieres salir?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20, // Tamaño de fuente deseado
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        ButtonBar(
                          alignment: MainAxisAlignment.start, // Alinea los botones a la izquierda
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Cierra el diálogo
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MenudeOpciones()),
                                );
                              },
                              child: Text('Sí',
                                style: TextStyle(
                                  fontSize: 18, // Tamaño de fuente deseado
                                ),),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Cierra el diálogo
                              },
                              child: Text('No',
                                style: TextStyle(
                                  fontSize: 18, // Tamaño de fuente deseado
                                ),),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            IconButton(
              icon: Image.asset(Resources.guardar),
              color: Colors.white,
              onPressed: () async {
                var locationRepository =
                await getIt.getAsync<LocationRepository>();
                var isEnableServiceLocation =
                await locationRepository.isEnableServiceLocation();
                var isHasPermissionLocation =
                await locationRepository.isHasPermission();
                await locationRepository.isHasPermission();
                var devicesInfoPlusRepository =
                await getIt.getAsync<DevicesInfoPlusRepository>();
                var isHasPermissionDevice = await devicesInfoPlusRepository.isHasPermission();


                //PONER DATOS RESTRICCION
                if (isEnableServiceLocation && isHasPermissionLocation && isHasPermissionDevice && (GPSlongitude != "")) {

                  //OBLIGATORIO EN ALMENOS UNO PARA QUE GUARDE


                  //FECHA Y OBSERVACION EN NO VIVO SON OBLIGATORIO
                  if ( (widget.formFallecimientoDateCtrl==null && widget.formFallecimientoDateCtrl!.text.isEmpty
                      && widget.formObservacionesCtrlFALLECIDO==null && widget.formObservacionesCtrlFALLECIDO!.text.isEmpty
                      )

                  //OBSERVACION EN VIVO SON OBLOGATORIO
                      &&
                      (widget.formObservacionesCtrl==null && widget.formObservacionesCtrl!.text.isEmpty)
                  ) {
                    HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                  } else {
                    //GUARDADO
                    if (widget.listMediaPath!.isEmpty) {
                      HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                    } else {
                      CargaDialog(); //INICIALIZA DIALOGO

                      widget.formData?.codigoOperador = "PENSION";

                      widget.formData?.codigoRegistro = Resources.valor_Visita_Presencial;

                      widget.formData?.fechaRegistro =
                          formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                      widget.formData?.fechaTablet =
                          formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                      widget.formData?.freeEspacioTablet = "";

                      widget.formData?.imei = PREFimei;

                      widget.formData?.altitud =
                          GPSaltitude;
                      print("GPSaltitude:"+GPSaltitude);

                      widget.formData?.latitud =
                          GPSlatitude;
                      print("GPSlatitude:"+GPSlatitude);

                      widget.formData?.longitud =
                          GPSlongitude;
                      print("longitud:"+GPSlongitude);

                      var totalEspacioTab = await devicesInfoPlusRepository.getSizeSystemTemp();
                      widget.formData?.totalEspacioTablet = totalEspacioTab[0];
                      widget.formData?.versionAplicacion = PREFversionAplicacionVigente;
                      widget.formData?.versionCondicion = PREFversionCondicion;
                      widget.formData?.versionOperador = PREFversionOperador;
                      await widget.formDataModelDao
                          .insertFormDataModel(widget.formData!);

                      await GuardarFormulario();

                      cleanForm();

                      _mostrarLoadingStreamController.add(true);
                    }

                  }



                } else {
                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP", context);}
              },
            ),
            IconButton(
              icon: Image.asset(
                isSatelliteGreen ? Resources.sateliteverde : Resources.sateliterojo,
                // Usa la imagen verde si isSatelliteGreen es verdadero, de lo contrario, usa la imagen roja
              ),
              color: Colors.white,
              onPressed: () {

                if(!isSatelliteGreen) {

                  PedirPermiso();

                } else {
                  HelpersViewCabecera.CoordenadasGPS(context).then((value) async {
                    // Luego de recopilar la ubicación y la fecha, actualiza el estado del icono
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    setState(() {
                      isSatelliteGreen = true;
                      GPSlatitude = prefs.getString('latitude') ?? "";
                      GPSlongitude = prefs.getString('longitude') ?? "";
                      GPSaltitude = prefs.getString('altitude') ?? "";
                    });
                  });
                }
              },
            ),
          ],
        ),

        body:  Center (
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 400.0, // Set your minimum width here
                maxWidth: double.infinity, // Set your maximum width here
              ),
              child: Container(
                margin: const EdgeInsets.all(41.0),
                child: Form(
                  key: widget.keyForm,
                  child: formUI(),
                ),
              ),
            ),
          ),
        ),),
    );
  }



  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime).toString();
  }

  void cleanForm() {
    widget.formIngresarObsCtrl!.clear();
    widget.formDNICtrl!.clear();
    widget.formData = Visitas();
    setState(() {});
  }


  void noSelect(context){

    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensaje.formItemsDesign("My text",context),
                    ],
                  )
              )
          );
        }
    );
  }

  Future<void> BorrarFoto(int index) async {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeFOTO.formItemsDesign("¿En verdad desea borrar esta foto?","Borrar Foto"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Align row to the end
                        children: [
                          Spacer(), // Push remaining space to the left
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Cancelar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: ()   {

                              setState(() {
                                if (widget.listMediaPath!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "No hay fotos para eliminar")));
                                } else {
                                  widget.listMediaPath!.removeAt(index);
                                  if (widget.listMediaPath!.isEmpty) {
                                    setState(() {
                                      widget.isShowButtonCameraInitial = true;
                                    });
                                  }


                                  Navigator.of(context).pop();
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Aceptar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              )
          );
        }
    );
  }



  Widget formUI() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Visibility(
          visible: !(noFallecido || siFallecido),
          child:HelpersViewLetrasRojas.formItemsDesign( "Verificación de Supervivencia"),
          ),


          //RADIO BUTTOn
          Visibility(
          visible: !(noFallecido || siFallecido),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
            children: [
              const SizedBox(width: 0.0), // Create left padding

              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  "¿La persona \n visistada ha fallecido?",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),
                  maxLines: 2, // Set this to 2 for two lines
                ),
              ),

              Row(
                children: [
                  Text('Sí', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 00.0), // Add spacing between text and radio
                  Radio<EstadoFallecido>(
                    value: EstadoFallecido.Si,
                    groupValue: _EstadoFallecido,
                    onChanged: (EstadoFallecido? value) {
                      setState(() {
                        _EstadoFallecido = value;
                        _EstadoCondicionFALLECIDO = EstadoCondicionFALLECIDO.Ocurrencias;
                        //
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  Text('No', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 0.0), // Add spacing between text and radio
                  Radio<EstadoFallecido>(
                    value: EstadoFallecido.No,
                    groupValue: _EstadoFallecido,
                    onChanged: (siFallecido && noFallecido) ? null : (EstadoFallecido? value) {
                      setState(() {
                        _EstadoFallecido = value;
                        _EstadoCondicion = EstadoCondicion.Ocurrencias;
                      });
                    },
                  ),
                ],
              ),


            ],
          ),),

          const SizedBox(height: 16.0),

          ///NO FALLECIDO
          Visibility(
              visible: noFallecido,
              child: Column(
                  children: <Widget>[

                    //RADIO BUTTOn 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding

                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            "Condición \n Beneficiario",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),
                            maxLines: 2, // Set this to 2 for two lines
                          ),
                        ),

                        Row(
                          children: [
                            const Text('Ocurrencias', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoCondicion>(
                              value: EstadoCondicion.Ocurrencias,
                              groupValue: _EstadoCondicion,
                              onChanged: (EstadoCondicion? value) {
                                setState(() {
                                  _EstadoCondicion = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('Visitas', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 0.0), // Add spacing between text and radio
                            Radio<EstadoCondicion>(
                              value: EstadoCondicion.Visitas,
                              groupValue: _EstadoCondicion,
                              onChanged: (EstadoCondicion? value) {
                                setState(() {
                                  _EstadoCondicion = value;
                                });
                              },
                            ),
                          ],
                        ),


                      ],
                    ),


                    HelpersViewLetrasRojas.formItemsDesign( "Condición del Beneficiario6"),
                    const SizedBox(height: 16.0),

                    //LISTA MOTIVOS
                    HelpersViewBlancoSelect.formItemsDesign(
                        DropdownButtonFormField(
                          items: widget.listCondicionNoFallecido
                              .map((dep) {
                            return DropdownMenuItem(
                              value: dep,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Text(
                                  dep,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) async {
                            //widget.listCondicionNoFallecido = [""];
                            widget.formCondicionVisitaCtrl.text = value!.isEmpty || value == null ? "" : value!;
                            setState(() {
                            }
                            );
                          },
                          validator: (value) => HelpersViewBlancoIcon.validateField(
                              widget.formCondicionVisitaCtrl.text!,
                              widget.ParamBeneficiarioCondicion),
                          isDense: true,
                          isExpanded: true,
                          hint: const Text("Condición Beneficiario"),
                          //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                        )
                        ),

                    //CONDICION DE VISITA
                    HelpersViewBlancoSelect.formItemsDesign(
                        DropdownButtonFormField(
                          items: widget.listCondicionVisita
                              .map((dep) {
                            return DropdownMenuItem(
                              value: dep,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  dep,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) async {
                            //widget.listCondicionNoFallecido = [""];
                            widget.formCondicionVisitaCtrl.text = value!.isEmpty || value == null ? "" : value!;
                            setState(() {
                            }
                            );
                          },
                          validator: (value) => HelpersViewBlancoIcon.validateField(
                              widget.formCondicionVisitaCtrl.text!,
                              widget.ParamCondicionVisita),
                          isDense: true,
                          isExpanded: true,
                          hint: const Text("Condición De Visita"),
                          //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                        )
                        ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Datos del Beneficiario"),
                    const SizedBox(height: 16.0),


                    //DNI & BUSCAR
                    Row(
                      children: [

                        const Text('DNI:', style: TextStyle(
                          fontSize: 12.0,
                          //color: Colors.white,
                        ),),

                        HelpersViewBlancoDNI.formItemsDesign(
                            TextFormField(
                              controller: widget.formDNICtrl,
                              decoration: const InputDecoration(
                                labelText: 'Ingrese DNI',
                                isDense: true,
                                labelStyle: const TextStyle(fontSize: 14.0),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              maxLength: 9,
                            ), context),

                        IconButton(
                          icon: Image.asset(Resources.lupa),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                            );
                          },
                        ),

                      ],
                    ),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formPaternoCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Apellido Paterno',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 8,
                        ), context),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formMaternoCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Apellido Materno',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 8,
                        ), context),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formNombresCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Nombres',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 8,
                        ), context),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formDireccionCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Dirreción',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 8,
                        ), context),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formDistritoCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Distrito',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 8,
                        ), context),

                    const SizedBox(height: 16.0), // Add margin between text fields
                    HelpersViewLetrasRojas.formItemsDesign( "Contacto de Referencia"),
                    const SizedBox(height: 16.0),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formTelefonoContactoCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Teléfono de Contacto',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 9,
                        ), context),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formPersonaContactoCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Persona de Contacto',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 50,
                        ), context),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Cobro de la última subvención"),
                    const SizedBox(height: 16.0),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding

                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            "¿Cobró\nsuvensión?",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),
                            maxLines: 2, // Set this to 2 for two lines
                          ),
                        ),

                        Row(
                          children: [
                            const Text('Sí', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoCobroSubencion>(
                              value: EstadoCobroSubencion.Si,
                              groupValue: _EstadoCobroSubencion,
                              onChanged: (EstadoCobroSubencion? value) {
                                setState(() {
                                  _EstadoCobroSubencion = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('No', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 0.0), // Add spacing between text and radio
                            Radio<EstadoCobroSubencion>(
                              value: EstadoCobroSubencion.No,
                              groupValue: _EstadoCobroSubencion,
                              onChanged: (EstadoCobroSubencion? value) {
                                setState(() {
                                  _EstadoCobroSubencion = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    HelpersViewLetrasSubs.formItemsDesign("Detallar por qué e incentivar el cobro"),
                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formDetallarSubensionCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Detallar',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 150,
                        ), context),


                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Modalidad de Cobro"),
                    const SizedBox(height: 16.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding


                        Row(
                          children: [
                            const Text('Agencia', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoCobroModalidad>(
                              value: EstadoCobroModalidad.Agencia,
                              groupValue: _EstadoCobroModalidad,
                              onChanged: (EstadoCobroModalidad? value) {
                                setState(() {
                                  _EstadoCobroModalidad = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('ETV', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoCobroModalidad>(
                              value: EstadoCobroModalidad.ETV,
                              groupValue: _EstadoCobroModalidad,
                              onChanged: (EstadoCobroModalidad? value) {
                                setState(() {
                                  _EstadoCobroModalidad = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('PAD', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoCobroModalidad>(
                              value: EstadoCobroModalidad.PAD,
                              groupValue: _EstadoCobroModalidad,
                              onChanged: (EstadoCobroModalidad? value) {
                                setState(() {
                                  _EstadoCobroModalidad = value;
                                });
                              },
                            ),
                          ],
                        ),

                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding


                        Row(
                          children: [
                            const Text('Tarjeta', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoCobroModalidad>(
                              value: EstadoCobroModalidad.Tarjeta,
                              groupValue: _EstadoCobroModalidad,
                              onChanged: (EstadoCobroModalidad? value) {
                                setState(() {
                                  _EstadoCobroModalidad = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('Carta Poder', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoCobroModalidad>(
                              value: EstadoCobroModalidad.Carta_Poder,
                              groupValue: _EstadoCobroModalidad,
                              onChanged: (EstadoCobroModalidad? value) {
                                setState(() {
                                  _EstadoCobroModalidad = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Declaración Jurada"),
                    const SizedBox(height: 16.0),

                    //DECLARACION JURADA
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding

                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            "¿Tiene declaración \njurada?",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),
                            maxLines: 2, // Set this to 2 for two lines
                          ),
                        ),

                        Row(
                          children: [
                            const Text('Sí', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoDeclaracionJurada>(
                              value: EstadoDeclaracionJurada.Si,
                              groupValue: _EstadoDeclaracionJurada,
                              onChanged: (EstadoDeclaracionJurada? value) {
                                setState(() {
                                  _EstadoDeclaracionJurada = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('No', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 0.0), // Add spacing between text and radio
                            Radio<EstadoDeclaracionJurada>(
                              value: EstadoDeclaracionJurada.No,
                              groupValue: _EstadoDeclaracionJurada,
                              onChanged: (EstadoDeclaracionJurada? value) {
                                setState(() {
                                  _EstadoDeclaracionJurada = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Vulnerabilidad adicional"),
                    const SizedBox(height: 16.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding

                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            "¿Tiene vulnerabilidad\n adicional?",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),
                            maxLines: 2, // Set this to 2 for two lines
                          ),
                        ),

                        Row(
                          children: [
                            const Text('Sí', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoVulnerabilidad>(
                              value: EstadoVulnerabilidad.Si,
                              groupValue: _EstadoVulnerabilidad,
                              onChanged: (EstadoVulnerabilidad? value) {
                                setState(() {
                                  _EstadoVulnerabilidad = value;
                                  HayVulnerabilidadAdicional = true;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('No', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 0.0), // Add spacing between text and radio
                            Radio<EstadoVulnerabilidad>(
                              value: EstadoVulnerabilidad.No,
                              groupValue: _EstadoVulnerabilidad,
                              onChanged: (EstadoVulnerabilidad? value) {
                                setState(() {
                                  _EstadoVulnerabilidad = value;
                                  HayVulnerabilidadAdicional = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

              Visibility(
              visible: (HayVulnerabilidadAdicional),
              child: Column(
              children: <Widget>[

                //SELECCIONAR VULNERABILDIAD ADICIONAL
                HelpersViewBlancoSelect.formItemsDesign(
                    DropdownButtonFormField(
                      items: widget.ListVulnerabilidadADicional.map((dep) {
                        return DropdownMenuItem(
                          value: dep,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              dep,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) async {
                        //widget.listCondicion = [""];
                        widget.formVulnerabilidadAdicionalCtrl.text = value!.isEmpty || value == null ? "" : value!;
                        setState(() {
                        }
                        );
                      },
                      validator: (value) => HelpersViewBlancoIcon.validateField(
                          widget.formVulnerabilidadAdicionalCtrl.text!,
                          widget.ParamVulnerabilidadAdicional),
                      isDense: true,
                      isExpanded: true,
                      hint: const Text("Seleccione Vulnerabilidad Adicional"),
                      //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                    )
                ),

                //ESTE SE DEBE ACTIVAR SI SE SELECCIONA "OTRO" EN EL SELECT ANTERIOR
                HelpersViewBlancoIcon.formItemsDesign(
                    Icons.person,
                    TextFormField(
                      controller: widget.formDetallarVulnerabilidadCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Detallar Vulnerabilidad adicional',
                      ),
                      //readOnly: true,
                      //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 50,
                    ), context),

              ]),),



                    //ESTO ESTA EN OTRA VERSION (LA NEGRA)
                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Datos Sobre Tercero Autorizado"),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesign("¿Esta conforme con la entrega de subvención por cobro de tercero autorizado?"),

                    //RADIO SI NO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding

                        Row(
                          children: [
                            const Text('Sí', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<TerceroConforme>(
                              value: TerceroConforme.Si,
                              groupValue: _TerceroConforme,
                              onChanged: (TerceroConforme? value) {
                                setState(() {
                                  _TerceroConforme = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('No', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 0.0), // Add spacing between text and radio
                            Radio<TerceroConforme>(
                              value: TerceroConforme.No,
                              groupValue: _TerceroConforme,
                              onChanged: (TerceroConforme? value) {
                                setState(() {
                                  _TerceroConforme = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesign("¿Recibio la totalidad de la subvención?"),

                    //RADIO SI NO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding

                        Row(
                          children: [
                            const Text('Sí', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<TerceroTotalidad>(
                              value: TerceroTotalidad.Si,
                              groupValue: _TerceroTotalidad,
                              onChanged: (TerceroTotalidad? value) {
                                setState(() {
                                  _TerceroTotalidad = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('No', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 0.0), // Add spacing between text and radio
                            Radio<TerceroTotalidad>(
                              value: TerceroTotalidad.No,
                              groupValue: _TerceroTotalidad,
                              onChanged: (TerceroTotalidad? value) {
                                setState(() {
                                  _TerceroTotalidad = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesign("¿Requiere Revocatoria?"),

                    //RADIO SI NO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding

                        Row(
                          children: [
                            const Text('Sí', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<TerceroRevocatoria>(
                              value: TerceroRevocatoria.Si,
                              groupValue: _TerceroRevocatoria,
                              onChanged: (TerceroRevocatoria? value) {
                                setState(() {
                                  _TerceroRevocatoria = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('No', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 0.0), // Add spacing between text and radio
                            Radio<TerceroRevocatoria>(
                              value: TerceroRevocatoria.No,
                              groupValue: _TerceroRevocatoria,
                              onChanged: (TerceroRevocatoria? value) {
                                setState(() {
                                  _TerceroRevocatoria = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Orientación"),
                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesign("Charlas:"),

                    //SELECCIONAR CHARLA
                    HelpersViewBlancoSelect.formItemsDesign(
                        DropdownButtonFormField(
                          items: widget.ListCharla.map((dep) {
                            return DropdownMenuItem(
                              value: dep,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  dep,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) async {
                            //widget.listCondicion = [""];
                            widget.formCharlaCtrl.text = value!.isEmpty || value == null ? "" : value!;
                            setState(() {
                            }
                            );
                          },
                          validator: (value) => HelpersViewBlancoIcon.validateField(
                              widget.formCharlaCtrl.text!,
                              widget.ParamCharla),
                          isDense: true,
                          isExpanded: true,
                          hint: const Text("Seleccione Vulnerabilidad Adicional"),
                          //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                        )
                        ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Educación Financiera"),
                    const SizedBox(height: 16.0),

                    //RADIO BUTTON EDICACION FINANCIERA A
                    HelpersViewLetrasSubs.formItemsDesign("Se brindó orientación en Educación Financiera?"),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [

                        Row(
                          children: [
                            const Text('Sí', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoEducacion>(
                              value: EstadoEducacion.Si,
                              groupValue: _EstadoEducacion,
                              onChanged: (EstadoEducacion? value) {
                                setState(() {
                                  _EstadoEducacion = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('No', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 0.0), // Add spacing between text and radio
                            Radio<EstadoEducacion>(
                              value: EstadoEducacion.No,
                              groupValue: _EstadoEducacion,
                              onChanged: (EstadoEducacion? value) {
                                setState(() {
                                  _EstadoEducacion = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),


                    HelpersViewTextSize.formItemsDesign(
                        TextFormField(
                          controller: widget.formObservacionesCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Detallar Observaciones',
                          ),
                          maxLength: 255,
                          maxLines: 5,
                        ), context),

                    Visibility(
                      visible: widget.isShowButtonCameraInitial!,
                      child: GestureDetector(
                        onTap: () async {

                          await GuardarFormulario();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CameraApp(widget.listMediaPath, widget.formData)));
                        },
                        child: Image.asset(Resources.fotoImg, width: 48, height: 48),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    SizedBox(
                      width: double.infinity, // Fills available space horizontally
                      height: 250, // Set your desired height
                      child: Center(
                        child: SizedBox(
                          child: ListView.builder(
                            itemCount: widget.listMediaPath!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  leading: Text("Foto$index"),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // Center horizontally
                                    children: [
                                      GestureDetector(
                                        onTap: () async {

                                          await GuardarFormulario();

                                          int lengthListMediaPath =
                                          widget.listMediaPath!.isNotEmpty
                                              ? widget.listMediaPath!.length
                                              : 0;

                                          if (lengthListMediaPath < 3) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => CameraApp(
                                                        widget.listMediaPath,
                                                        widget.formData)));
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        "Solo está permitido 3 fotos como máximo")));
                                          }
                                        },
                                        child: Image.asset(Resources.fotoImg,
                                            width: 48, height: 48),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.02),
                                      GestureDetector(
                                        onTap: () async {
                                          if (widget.listMediaPath!.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    content:
                                                    Text("No hay fotos para mostrar")));
                                          } else {
                                            await GuardarFormulario();

                                            String pathParam =
                                            widget.listMediaPath!.isNotEmpty &&
                                                widget.listMediaPath![index].path
                                                    .isNotEmpty
                                                ? widget.listMediaPath![index].path
                                                : "";


                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => DisplayPhoto(
                                                        widget.listMediaPath,
                                                        widget.formData,
                                                        pathParam)));
                                          }
                                        },
                                        child: Image.asset(Resources.fotoCam,
                                            width: 48, height: 48),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.02),
                                      GestureDetector(
                                        onTap: () async {

                                          await BorrarFoto(index);
                                        },
                                        child: Image.asset(Resources.fotoX,
                                            width: 48, height: 48),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )


                  ]
              )
          ),

          /////////////////////////////

          ///SI FALLECIDO
          Visibility(
              visible: siFallecido,
              child: Column(
                  children: <Widget>[


                    //RADIO BUTTON BLOQUEADO
                    //RADIO BUTTOn 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
                      children: [
                        const SizedBox(width: 0.0), // Create left padding

                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            "Condición \n Beneficiario",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),
                            maxLines: 2, // Set this to 2 for two lines
                          ),
                        ),

                        Row(
                          children: [
                            const Text('Ocurrencias', style: TextStyle(
                              fontSize: 12.0,
                              //color: Colors.white,
                            ),),
                            const SizedBox(width: 00.0), // Add spacing between text and radio
                            Radio<EstadoCondicionFALLECIDO>(
                              value: EstadoCondicionFALLECIDO.Ocurrencias,
                              groupValue: _EstadoCondicionFALLECIDO,
                              onChanged: (EstadoCondicionFALLECIDO? value) {
                                setState(() {
                                  _EstadoCondicionFALLECIDO = value;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text('Visitas', style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),),
                            const SizedBox(width: 0.0), // Add spacing between text and radio
                            Radio<EstadoCondicionFALLECIDO>(
                              value: EstadoCondicionFALLECIDO.Visitas,
                              groupValue: _EstadoCondicionFALLECIDO,
                              onChanged: (EstadoCondicionFALLECIDO? value) {
                                setState(() {
                                  //_EstadoCondicionFALLECIDO = value;
                                }
                                );
                              },
                            ),
                          ],
                        ),


                      ],
                    ),


                    HelpersViewLetrasRojas.formItemsDesign( "Condición del Beneficiario"),
                    const SizedBox(height: 16.0),

                    //LISTA MOTIVOS
                    HelpersViewBlancoSelect.formItemsDesign(
                        DropdownButtonFormField(
                          items: widget.listCondicioSiFallecido.map((dep) {
                            return DropdownMenuItem(
                              value: dep,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  dep,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) async {
                            //widget.listCondicion = [""];
                            widget.formBeneficiarioCondicionCtrl.text = value!.isEmpty || value == null ? "" : value!;
                            setState(() {
                            }
                            );
                          },
                          validator: (value) => HelpersViewBlancoIcon.validateField(
                              widget.formBeneficiarioCondicionCtrl.text!,
                              widget.ParamBeneficiarioCondicion),
                          isDense: true,
                          isExpanded: true,
                          hint: const Text("Condición Beneficiario"),
                          //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                        )
                        ),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.hourglass_empty,
                        TextFormField(
                          controller: widget.formFallecimientoDateCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Fecha de Fallecimiento',
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023, 03, 01),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              widget.formFallecimientoDateCtrl.text =
                                  Helpers.formatDate('dd/MM/yyyy', pickedDate);
                            }
                          },onSaved: (newValue) {
                          widget.formFallecimientoDateCtrl.text =
                              Helpers.formatDate('dd/MM/yyyy', new DateFormat("dd/MM/yyyy").parse(newValue!));
                        },
                        ), context),


                    const SizedBox(height: 16.0), // Add margin between text fields
                    HelpersViewLetrasRojas.formItemsDesign( "Datos del beneficiario"),
                    const SizedBox(height: 16.0),

                    //DNI & BUSCAR
                    Row(
                      children: [

                        const Text('DNI:', style: TextStyle(
                          fontSize: 12.0,
                          //color: Colors.white,
                        ),),

                        HelpersViewBlancoDNI.formItemsDesign(
                            TextFormField(
                              controller: widget.formDNICtrlFALLECIDO,
                              decoration: const InputDecoration(
                                labelText: 'Ingrese DNI',
                                isDense: true,
                                labelStyle: const TextStyle(fontSize: 14.0),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              maxLength: 9,
                            ), context),

                        IconButton(
                          icon: Image.asset(Resources.lupa),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                            );
                          },
                        ),

                      ],
                    ),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formPaternoCtrlFALLECIDO,
                          decoration: const InputDecoration(
                            labelText: 'Apellido Paterno',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 8,
                        ), context),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formMaternoCtrlFALLECIDO,
                          decoration: const InputDecoration(
                            labelText: 'Apellido Materno',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 8,
                        ), context),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.person,
                        TextFormField(
                          controller: widget.formNombresCtrlFALLECIDO,
                          decoration: const InputDecoration(
                            labelText: 'Nombres',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 8,
                        ), context),

                    HelpersViewTextSize.formItemsDesign(
                        TextFormField(
                          controller: widget.formObservacionesCtrlFALLECIDO,
                          decoration: const InputDecoration(
                            labelText: 'Detallar Observaciones',
                          ),
                          maxLength: 255,
                          maxLines: 5,
                        ), context),


                    Visibility(
                      visible: widget.isShowButtonCameraInitial!,
                      child: GestureDetector(
                        onTap: () async {


                          await GuardarFormulario();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CameraApp(widget.listMediaPath, widget.formData)));
                        },
                        child: Image.asset(Resources.fotoImg, width: 48, height: 48),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    SizedBox(
                      width: double.infinity, // Fills available space horizontally
                      height: 250, // Set your desired height
                      child: Center(
                        child: SizedBox(
                          child: ListView.builder(
                            itemCount: widget.listMediaPath!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  leading: Text("Foto$index"),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // Center horizontally
                                    children: [
                                      GestureDetector(
                                        onTap: () async {

                                          await GuardarFormulario();


                                          int lengthListMediaPath =
                                          widget.listMediaPath!.isNotEmpty
                                              ? widget.listMediaPath!.length
                                              : 0;

                                          if (lengthListMediaPath < 3) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => CameraApp(
                                                        widget.listMediaPath,
                                                        widget.formData)));
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        "Solo está permitido 3 fotos como máximo")));
                                          }
                                        },
                                        child: Image.asset(Resources.fotoImg,
                                            width: 48, height: 48),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.02),
                                      GestureDetector(
                                        onTap: () async {
                                          if (widget.listMediaPath!.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    content:
                                                    Text("No hay fotos para mostrar")));
                                          } else {
                                            await GuardarFormulario();

                                            String pathParam =
                                            widget.listMediaPath!.isNotEmpty &&
                                                widget.listMediaPath![index].path
                                                    .isNotEmpty
                                                ? widget.listMediaPath![index].path
                                                : "";


                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => DisplayPhoto(
                                                        widget.listMediaPath,
                                                        widget.formData,
                                                        pathParam)));
                                          }
                                        },
                                        child: Image.asset(Resources.fotoCam,
                                            width: 48, height: 48),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.02),
                                      GestureDetector(
                                        onTap: () async {

                                          await BorrarFoto(index);
                                        },
                                        child: Image.asset(Resources.fotoX,
                                            width: 48, height: 48),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )


                  ]
              )
          ),



          Visibility(
            visible: !(noFallecido || siFallecido),
          child:  GestureDetector(
              onTap: ()  {
                setState(() { // Call setState() to trigger a rebuild
                  if(_EstadoFallecido == null) {
                    noSelect(context);
                  } else{

                    if(_EstadoFallecido == EstadoFallecido.Si) {
                      siFallecido = true;
                      noFallecido = false;
                    }

                    if(_EstadoFallecido == EstadoFallecido.No) {
                      noFallecido = true;
                      siFallecido = false;
                    }

                  }
                });

              },
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Color(0xFFD60000),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text("Continuar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),),



          
        ],
    );

  }

}