import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/infraestructure/dao/database/database.dart';
import 'package:tayta/main.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpers.dart';
import 'package:tayta/utils/helpersviewAlertMensaje.dart';
import 'package:tayta/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:tayta/utils/helpersviewAlertProgressCircle.dart';
import 'package:tayta/utils/helpersviewBlancoDNI.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewCamera.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/helpersviewLetrasSubs.dart';
import 'package:tayta/utils/helpersviewTextSize.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';

import '../../../infraestructure/dao/formdatamodeldao_visita.dart';
import '../../../infraestructure/repository/devicesinfoplusrepository.dart';
import '../../../infraestructure/repository/locationrepository.dart';
import '../../../model/t_visita.dart';
import '../../../utils/camera.dart';
import '../../../utils/helpersviewAlertFaltaMSG.dart';
import '../../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../../utils/helpersviewBlancoSelect.dart';
import '../../../utils/viewdisplayfoto.dart';


///RADION BUTTON


class MenuVerificacionRemota extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;
  bool? isShowButtonCameraInitial = true;
  List<XFile>? listMediaPath;
  String title = Resources.titulo_Bitacora;


  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formSelectVerificacionRemotactrl = TextEditingController();
  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formPaternoCtrl = TextEditingController();
  TextEditingController formMaternoCtrl = TextEditingController();
  TextEditingController formNombresCtrl = TextEditingController();
  TextEditingController formObservacionesCtrl = TextEditingController();
  TextEditingController formDistritoCtrl = TextEditingController();
  TextEditingController formDireccionCtrl = TextEditingController();
  TextEditingController formCentroPobladoCtrl = TextEditingController();
  TextEditingController formTelefonoContactoCtrl = TextEditingController();
  TextEditingController formPersonaContactoCtrl = TextEditingController();
  TextEditingController formBeneficiarioCondicionCtrl = TextEditingController();
  TextEditingController formDetallarDenunciaCtrl = TextEditingController();
  TextEditingController formSelectMotivoRevoctrl = TextEditingController();
  TextEditingController formCharlactrl = TextEditingController();


  TextEditingController formFallecimientoDateCtrl = TextEditingController();
  TextEditingController formDNICtrlFALLECIDO = TextEditingController();
  TextEditingController formPaternoCtrlFALLECIDO = TextEditingController();
  TextEditingController formMaternoCtrlFALLECIDO = TextEditingController();
  TextEditingController formNombresCtrlFALLECIDO = TextEditingController();
  TextEditingController formObservacionesCtrlFALLECIDO = TextEditingController();



  final ParamBeneficiarioCondicion = List.filled(3, "", growable: false);
  final ParamSelectVerificacionRemota = List.filled(3, "", growable: false);
  final ParamSelectMotivoRevo = List.filled(3, "", growable: false);
  final ParamCharla = List.filled(3, "", growable: false);

  String? mediaPath;
  String imageSource = Resources.sateliterojo;
  Visitas? formData;
  MenuVerificacionRemota(this.listMediaPath,this.formData, {super.key});

  List<String> listCondicion = [
    "Fallecimiento con acta de defunción",
    "Fallecimiento sin acta de defunción",
  ];

  List<String> listSelectVerificacionRemota = [
    "Seleccionar motivo de Verificación",
    "Verificación Remota-Usuario regular",
    "Verificación Remota-Usuario con tercero autorizado",
  ];

  List<String> listSelectMotivoRevo = [
    "Seleccionar motivo de Revocatoria",
    "No conformidad en la entrega",
    "Decisión voluntaria del usuarioo",
  ];

  List<String> listSelectCharla = [
    "Seleccionar motivo de Revocatoria",
    "No conformidad en la entrega",
    "Decisión voluntaria del usuarioo",
  ];


  @override
  State<StatefulWidget> createState() {
    return _MenuVerificacionRemota();
  }
}

///RADION BUTTON
enum EstadoFallecido { Si, No }
enum EstadoCondicion { Ocurrencias, Visitas }
enum EstadoCondicionFALLECIDO { Ocurrencias, Visitas }

enum RequiereRev {Si, No}
enum SubencionTotalidad { Si, No }
enum PresentoDenuncia { Si, No }
enum SubencionCobro { Si, No }
enum VictimaViolencia {Si, No}
enum EducacionFinanciera {Si, No}

class _MenuVerificacionRemota extends State<MenuVerificacionRemota> {

  late int PREFversionInstancia;
  late String PREFversionAplicacionVigente;
  late String PREFversionAplicacion;
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

    super.initState();
    conseguirVersion();
  }

  bool isSatelliteGreen = false;

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

  CameraController? controller;

  //RADION BUTTOn
  EstadoFallecido? _EstadoFallecido = null;
  EstadoCondicion? _EstadoCondicion = EstadoCondicion.Ocurrencias;
  EstadoCondicionFALLECIDO? _EstadoCondicionFALLECIDO = EstadoCondicionFALLECIDO.Ocurrencias;

  VictimaViolencia? _VictimaViolencia = null;
  PresentoDenuncia? _PresentoDenuncia=  null;
  SubencionCobro? _SubencionCobro = null;
  SubencionTotalidad? _SubencionTotalidad = null;
  RequiereRev? _RequiereRev = null;
  EducacionFinanciera? _EducacionFinanciera = null;



  bool siFallecido = false;
  bool noFallecido = false;

  bool SiDetalleDenuncia = false;
  bool SiRevocatoria = false;

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
        Resources.valor_Verificacion_Remota;

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
      //POR EL MOMENTO
      widget.formData?.tipoCondicion = 0;

    } else {
      // LO DE NO FALLECIDO

      widget.formData?.observacion =
      widget.formObservacionesCtrl!.text!.isEmpty
          ? ""
          : widget.formObservacionesCtrl!.text;

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

      //formCentroPobladoCtrl

      widget.formData?.telefonoContacto =
      widget.formTelefonoContactoCtrl!.text!.isEmpty
          ? ""
          : widget.formTelefonoContactoCtrl!.text;

      widget.formData?.personaContacto =
      widget.formPersonaContactoCtrl!.text!.isEmpty
          ? ""
          : widget.formPersonaContactoCtrl!.text;

      widget.formData?.tipoCondicion = 0;


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
            Resources.titulo_Verificacion_Remota,
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
                if (isEnableServiceLocation && isHasPermissionLocation && isHasPermissionDevice && (GPSlongitude != "")) {
                  if (widget.formObservacionesCtrl==null && widget.formObservacionesCtrl!.text.isEmpty) {
                    HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                  } else {
                    CargaDialog(); //INICIALIZA DIALOGO
                    widget.formData?.codigoOperador = "PENSION";

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

                    await GuardarFormulario();

                    await widget.formDataModelDao
                        .insertFormDataModel(widget.formData!);
                    cleanForm();
                    _mostrarLoadingStreamController.add(true);
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
    widget.isShowButtonCameraInitial = true;
    widget.formObservacionesCtrl!.clear();
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
      children: <Widget>[

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
                    });
                  },
                ),
              ],
            ),


          ],
        ),),

        ///MOSTRAR SI FALLECIDO
        Visibility(
        visible: siFallecido,
        child: Column(
          children: <Widget>[

        Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
        children: [

          const SizedBox(width: 0.0), // Create left padding


          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              "Condición \n Beneficiario",
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
                  items: widget.listCondicion.map((dep) {
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

            const SizedBox(height: 16.0), 
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


          ]
        )
        ),

    ///MOSTRAR SI NO FALLECIO
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

              //LISTA MOTIVOS
              HelpersViewBlancoSelect.formItemsDesign(
                  DropdownButtonFormField(
                    items: widget.listSelectVerificacionRemota.map((dep) {
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
                      //widget.listSelectVerificacionRemota = [""];
                      widget.formSelectVerificacionRemotactrl.text = value!.isEmpty || value == null ? "" : value!;
                      setState(() {
                      }
                      );
                    },
                    validator: (value) => HelpersViewBlancoIcon.validateField(
                        widget.formSelectVerificacionRemotactrl.text!,
                        widget.ParamSelectVerificacionRemota),
                    isDense: true,
                    isExpanded: true,
                    hint: const Text("Seleccione motivo de Verificación Remota"),
                    //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                  )
                  ),

              const SizedBox(height: 16.0),
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
                      labelText: 'Direccion',
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

              HelpersViewBlancoIcon.formItemsDesign(
                  Icons.person,
                  TextFormField(
                    controller: widget.formCentroPobladoCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Centro Poblado',
                    ),
                    //readOnly: true,
                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 8,
                  ), context),

              const SizedBox(height: 16.0), 
              HelpersViewLetrasRojas.formItemsDesign( "Contacto de Referencia"),
              const SizedBox(height: 16.0),

              HelpersViewBlancoIcon.formItemsDesign(
                  Icons.person,
                  TextFormField(
                    controller: widget.formTelefonoContactoCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Teléfono de contacto',
                    ),
                    //readOnly: true,
                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 8,
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
                    maxLength: 8,
                  ), context),

              const SizedBox(height: 16.0), 
              HelpersViewLetrasRojas.formItemsDesign( "Victima de Violencia"),
              const SizedBox(height: 16.0),

              const SizedBox(height: 16.0),
              HelpersViewLetrasSubs.formItemsDesign( "¿Usuario es victima de violencia?"),
              const SizedBox(height: 16.0),

              //SI NO
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
                      Radio<VictimaViolencia>(
                        value: VictimaViolencia.Si,
                        groupValue: _VictimaViolencia,
                        onChanged: (VictimaViolencia? value) {
                          setState(() {
                            _VictimaViolencia = value;
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
                      Radio<VictimaViolencia>(
                        value: VictimaViolencia.No,
                        groupValue: _VictimaViolencia,
                        onChanged: (VictimaViolencia? value) {
                          setState(() {
                            _VictimaViolencia = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16.0),
              HelpersViewLetrasSubs.formItemsDesign( "¿Presento Denuncia?"),
              const SizedBox(height: 16.0),

              //SI NO
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
                      Radio<PresentoDenuncia>(
                        value: PresentoDenuncia.Si,
                        groupValue: _PresentoDenuncia,
                        onChanged: (PresentoDenuncia? value) {
                          setState(() {
                            _PresentoDenuncia = value;
                            SiDetalleDenuncia = true;
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
                      Radio<PresentoDenuncia>(
                        value: PresentoDenuncia.No,
                        groupValue: _PresentoDenuncia,
                        onChanged: (PresentoDenuncia? value) {
                          setState(() {
                            _PresentoDenuncia = value;
                            SiDetalleDenuncia = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              //DETALLAR DENUNCIA (ponerle un VIEW)
        Visibility(
            visible: SiDetalleDenuncia,
            child:

            HelpersViewTextSize.formItemsDesign(
                  TextFormField(
                    controller: widget.formDetallarDenunciaCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Detallar Denuncia',
                    ),
                    maxLength: 255,
                    maxLines: 5,
                  ), context),),

              const SizedBox(height: 16.0), 
              HelpersViewLetrasRojas.formItemsDesign( "Datos Sobre Tercero Autorizado"),
              const SizedBox(height: 16.0),

              HelpersViewLetrasSubs.formItemsDesign( "¿Está conforme con la entrega de la subvención por cobro de tercero autorizado?"),
              const SizedBox(height: 16.0),
              //SI NO
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
                      Radio<SubencionCobro>(
                        value: SubencionCobro.Si,
                        groupValue: _SubencionCobro,
                        onChanged: (SubencionCobro? value) {
                          setState(() {
                            _SubencionCobro = value;
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
                      Radio<SubencionCobro>(
                        value: SubencionCobro.No,
                        groupValue: _SubencionCobro,
                        onChanged: (SubencionCobro? value) {
                          setState(() {
                            _SubencionCobro = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16.0),
              HelpersViewLetrasSubs.formItemsDesign( "¿Recibio la totalidad de la subvención?"),
              const SizedBox(height: 16.0),

              //SI NO
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
                      Radio<SubencionTotalidad>(
                        value: SubencionTotalidad.Si,
                        groupValue: _SubencionTotalidad,
                        onChanged: (SubencionTotalidad? value) {
                          setState(() {
                            _SubencionTotalidad = value;
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
                      Radio<SubencionTotalidad>(
                        value: SubencionTotalidad.No,
                        groupValue: _SubencionTotalidad,
                        onChanged: (SubencionTotalidad? value) {
                          setState(() {
                            _SubencionTotalidad = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16.0),
              HelpersViewLetrasSubs.formItemsDesign( "¿Requiere revocatoria?"),
              const SizedBox(height: 16.0),

              //SI NO
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
                      Radio<RequiereRev>(
                        value: RequiereRev.Si,
                        groupValue: _RequiereRev,
                        onChanged: (RequiereRev? value) {
                          setState(() {
                            _RequiereRev = value;
                            SiRevocatoria = true;
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
                      Radio<RequiereRev>(
                        value: RequiereRev.No,
                        groupValue: _RequiereRev,
                        onChanged: (RequiereRev? value) {
                          setState(() {
                            _RequiereRev = value;
                            SiRevocatoria = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              Visibility(
                visible: SiDetalleDenuncia,
                child:

                //LISTA MOTIVOS REVOCATORIA
                HelpersViewBlancoSelect.formItemsDesign(
                    DropdownButtonFormField(
                      items: widget.listSelectMotivoRevo.map((dep) {
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
                        //widget.listSelectMotivoRevo = [""];
                        widget.formSelectMotivoRevoctrl.text = value!.isEmpty || value == null ? "" : value!;
                        setState(() {
                        }
                        );
                      },
                      validator: (value) => HelpersViewBlancoIcon.validateField(
                          widget.formSelectMotivoRevoctrl.text!,
                          widget.ParamSelectMotivoRevo),
                      isDense: true,
                      isExpanded: true,
                      hint: const Text("Seleccione motivo de Revocatoria"),
                      //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                    )
                ),

              ),


              const SizedBox(height: 16.0), 
              HelpersViewLetrasRojas.formItemsDesign( "Orientación"),

              const SizedBox(height: 16.0),
              HelpersViewLetrasSubs.formItemsDesign( "Charlas:"),
              const SizedBox(height: 16.0),

              //LISTA MOTIVOS REVOCATORIA
              HelpersViewBlancoSelect.formItemsDesign(
                  DropdownButtonFormField(
                    items: widget.listSelectCharla.map((dep) {
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
                      //widget.listSelectMotivoRevo = [""];
                      widget.formCharlactrl.text = value!.isEmpty || value == null ? "" : value!;
                      setState(() {
                      }
                      );
                    },
                    validator: (value) => HelpersViewBlancoIcon.validateField(
                        widget.formCharlactrl.text!,
                        widget.ParamCharla),
                    isDense: true,
                    isExpanded: true,
                    hint: const Text("TRAER MEDIANTE API"),
                    //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                  )
              ),

              const SizedBox(height: 16.0),
              HelpersViewLetrasRojas.formItemsDesign( "Educación Financiera"),
              const SizedBox(height: 16.0),

              HelpersViewLetrasSubs.formItemsDesign( "¿Se brindó orientación en Educación Financiera?:"),
              const SizedBox(height: 16.0),

              //SI NO
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
                      Radio<EducacionFinanciera>(
                        value: EducacionFinanciera.Si,
                        groupValue: _EducacionFinanciera,
                        onChanged: (EducacionFinanciera? value) {
                          setState(() {
                            _EducacionFinanciera = value;
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
                      Radio<EducacionFinanciera>(
                        value: EducacionFinanciera.No,
                        groupValue: _EducacionFinanciera,
                        onChanged: (EducacionFinanciera? value) {
                          setState(() {
                            _EducacionFinanciera = value;
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


            ]
        )),


    Visibility(
      visible: !(noFallecido || siFallecido),
      child: GestureDetector(
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