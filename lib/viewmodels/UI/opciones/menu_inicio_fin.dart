import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_visita.dart';
import 'package:tayta/main.dart';
import 'package:tayta/utils/helpersviewAlertMensaje.dart';
import 'package:tayta/utils/helpersviewAlertMensajeFOTO.dart';
import 'package:tayta/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:tayta/utils/helpersviewAlertProgressCircle.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';

import '../../../infraestructure/dao/database/database.dart';
import '../../../infraestructure/repository/devicesinfoplusrepository.dart';
import '../../../infraestructure/repository/locationrepository.dart';
import '../../../model/t_visita.dart';
import '../../../utils/camera.dart';
import '../../../utils/helpersviewAlertFaltaMSG.dart';
import '../../../utils/viewdisplayfoto.dart';
import '../menu_deOpciones.dart';

class MenuInicioFin extends StatefulWidget {
  final _appDatabase = GetIt.I.get<AppDatabase>();
  bool? isShowButtonCameraInitial = true;
  bool mostrarLOAD = false;

  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController? formObservacionCtrl = TextEditingController();
  List<XFile>? listMediaPath;
  Visitas? formData;
  String imageSource = Resources.sateliterojo;
  String title = Resources.titulo_Inicio_Fin_de_Actividades;



  MenuInicioFin(this.listMediaPath, this.formData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuInicioFin();
  }
}

///RADION BUTTON
enum EstadoActividad { Inicio, Fin }

class _MenuInicioFin extends State<MenuInicioFin> {

  late int PREFversionInstancia;
  late String PREFversionAplicacionVigente;
  late String PREFversionAplicacion;
  late int PREFversionCondicion;
  late int PREFversionOperador;
  late String PREFimei;

  late String GPSlatitude = "";
  late String GPSlongitude = "";
  late String GPSaltitude = "";

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

  EstadoActividad? _EstadoActividad = EstadoActividad.Inicio;

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
      if (widget.formData!.observacion!.isNotEmpty) {
        _EstadoActividad = widget.formData!.recorrido == 0
            ? EstadoActividad.Inicio
            : EstadoActividad.Fin;
        setState(() {
          widget.formObservacionCtrl!.text = widget.formData!.observacion!;
        });
      }
    }

    widget.formObservacionCtrl ??= TextEditingController();
    // TODO: implement initState
    super.initState();
    conseguirVersion();
  }

  bool isSatelliteGreen = false;

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
      Resources.valor_Inicio_Fin_de_Actividades;

    widget.formData?.observacion =
    widget.formObservacionCtrl!.text!.isEmpty
        ? ""
        : widget.formObservacionCtrl!.text;

    widget.formData?.recorrido =
        _EstadoActividad?.index;

    /*
    if (widget.formData!.observacion!.isNotEmpty) {
      setState(() {
        widget.formObservacionCtrl!.text = widget.formData!.observacion!;
      });
    }
    */

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
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
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
                  if ((
                      widget.formObservacionCtrl==null && widget.formObservacionCtrl!.text.isEmpty) ||

                      widget.listMediaPath!.isEmpty) {
                    HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                  } else {
                    CargaDialog(); //INICIALIZA DIALOGO

                    //RELLENADO DATOS RESTRICCION
                    widget.formData?.codigoRegistro =
                        Resources.valor_Inicio_Fin_de_Actividades;

                    var totalEspacioTab = await devicesInfoPlusRepository.getSizeSystemTemp();

                    widget.formData?.totalEspacioTablet =
                    totalEspacioTab[0];

                    widget.formData?.versionAplicacion =
                        PREFversionAplicacionVigente;

                    widget.formData?.versionCondicion =
                        PREFversionCondicion;

                    widget.formData?.versionOperador =
                        PREFversionOperador;


                    widget.formData?.codigoOperador =
                    "PENSION";

                    widget.formData?.fechaRegistro =
                        formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());

                    widget.formData?.fechaTablet =
                        formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());

                    await setFechasFotosAndBytesFotos();

                    widget.formData?.freeEspacioTablet =
                    "";

                    widget.formData?.imei =
                        PREFimei;

                    widget.formData?.altitud =
                        GPSaltitude;
                    print("GPSaltitude:"+GPSaltitude);

                    widget.formData?.latitud =
                        GPSlatitude;
                    print("GPSlatitude:"+GPSlatitude);

                    widget.formData?.longitud =
                        GPSlongitude;
                    print("longitud:"+GPSlongitude);


                    widget.formData?.tipoCondicion =
                    0;

                    //DATOS FORMULARIO

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
        //drawer: const MenuLateral(),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(41.0),
            child: Form(
              //key: widget.keyForm,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  void cleanForm() {
    widget.listMediaPath!.clear();
    _EstadoActividad = EstadoActividad.Inicio;
    widget.formObservacionCtrl!.clear();
    widget.isShowButtonCameraInitial = true;
    widget.formData = Visitas();
    setState(() {});
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



  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime).toString();
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // Align content to the left
          children: [
            const SizedBox(width: 0.0), // Create left padding

            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                "Seleccione:",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12.0,
                ),
                maxLines: 2, // Set this to 2 for two lines
              ),
            ),

            Row(
              children: [
                const Text(
                  'Inicio',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(width: 00.0),
                Radio<EstadoActividad>(
                  value: EstadoActividad.Inicio,
                  groupValue: _EstadoActividad,
                  onChanged: (EstadoActividad? value) {
                    setState(() {
                      _EstadoActividad = value;
                    });
                  },
                ),
              ],
            ),

            Row(
              children: [
                const Text(
                  'Fin',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                Radio<EstadoActividad>(
                  value: EstadoActividad.Fin,
                  groupValue: _EstadoActividad,
                  onChanged: (EstadoActividad? value) {
                    setState(() {
                      _EstadoActividad = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),

        Card(
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: widget.formObservacionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingresar Observaciones',
                ),
                maxLength: 255,
                maxLines: 5,
              ),
            )),

        Visibility(
          visible: widget.isShowButtonCameraInitial!,
          child: GestureDetector(
            onTap: () async {

              /*
              widget.formData?.recorrido = _EstadoActividad!.index;
              widget.formData?.observacion =
              widget.formObservacionCtrl!.text!.isEmpty
                  ? ""
                  : widget.formObservacionCtrl!.text;
                  */

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

        Expanded(
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
      ],
    );
  }
}
