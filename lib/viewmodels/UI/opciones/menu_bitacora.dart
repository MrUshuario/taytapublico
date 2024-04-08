import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:floor/floor.dart';
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
import 'package:tayta/model/t_visita.dart';
import 'package:tayta/utils/helpersviewAlertFaltaMSG.dart';
import 'package:tayta/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:tayta/utils/helpersviewAlertProgressCircle.dart';
import 'package:tayta/utils/helpersviewBlancoDNI.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/helpersviewTextSize.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/model/t_visita.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';
import 'package:flutter/src/rendering/box.dart';
import '../../../utils/camera.dart';
import '../../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../../utils/viewdisplayfoto.dart';



class MenuBitacora extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;
  bool? isShowButtonCameraInitial = true;
  String imageSource = Resources.sateliterojo;
  Visitas? formData;
  List<XFile>? listMediaPath;
  String title = Resources.titulo_Bitacora;


  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController? formUsuarioCtrl = TextEditingController();
  TextEditingController formPlacaCtrl = TextEditingController();
  TextEditingController formKilometrajeCtrl = TextEditingController();
  TextEditingController formGalonesCtrl = TextEditingController();
  TextEditingController formMontoCtrl = TextEditingController();
  TextEditingController formGrifoCtrl = TextEditingController();
  TextEditingController formIngresarObsCtrl = TextEditingController();
  TextEditingController? formObservacionCtrl = TextEditingController();



  MenuBitacora(this.listMediaPath, this.formData, {super.key});


  @override
  State<StatefulWidget> createState() {
    return _MenuBitacora();
  }
}

///RADION BUTTON
enum Recorrido { Inicio, Fin }


class _MenuBitacora extends State<MenuBitacora> {

  late int PREFversionInstancia;
  late String PREFversionAplicacionVigente;
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

      //RADIO BUTTON DE BITACORA
      //PONER UN IF POR SI ESTA VACIO

      if (widget.formData!.recorrido! != 0) {
        setState(() {
          _Recorrido = widget.formData!.recorrido == 0
              ? Recorrido.Inicio
              : Recorrido.Fin;
        });
      }


      if (widget.formData!.observacion!.isNotEmpty) {
        setState(() {
          widget.formIngresarObsCtrl!.text = widget.formData!.observacion!;
        });
      }

      if (widget.formData!.placa!.isNotEmpty) {
        setState(() {
          widget.formPlacaCtrl!.text = widget.formData!.placa!;
        });
      }


      if (widget.formData!.kilometraje! != 0) {
        setState(() {
          widget.formKilometrajeCtrl!.text = widget.formData!.kilometraje!.toString();
        });
      }

      if (widget.formData!.grifo!.isNotEmpty) {
        setState(() {
          widget.formGrifoCtrl!.text = widget.formData!.grifo!;
        });
      }

      if (widget.formData!.monto!.isNotEmpty) {
        setState(() {
          widget.formMontoCtrl!.text = widget.formData!.monto!;
        });
      }

      if (widget.formData!.galones!.isNotEmpty) {
        setState(() {
          widget.formGalonesCtrl!.text = widget.formData!.galones!;
        });
      }

    }


/*
    widget.formIngresarObsCtrl ??= TextEditingController();
    widget.formPlacaCtrl ??= TextEditingController();
    widget.formKilometrajeCtrl ??= TextEditingController();
    widget.formGrifoCtrl ??= TextEditingController();
    widget.formMontoCtrl ??= TextEditingController();
    widget.formGalonesCtrl ??= TextEditingController();

*/
    super.initState();
    conseguirVersion();
  }



  //RADION BUTTOn
  Recorrido? _Recorrido = Recorrido.Inicio;
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
        Resources.valor_Bitacora;

    widget.formData?.recorrido =
        _Recorrido?.index;

    widget.formData?.placa =
    widget.formPlacaCtrl!.text!.isEmpty
        ? ""
        : widget.formPlacaCtrl!.text;

    widget.formData?.galones =
    widget.formGalonesCtrl!.text!.isEmpty
        ? ""
        : widget.formGalonesCtrl!.text;

    widget.formData?.kilometraje =
    widget.formKilometrajeCtrl!.text!.isEmpty
        ? 0
        : int.parse(widget.formKilometrajeCtrl!.text);

    widget.formData?.observacion =
    widget.formIngresarObsCtrl!.text!.isEmpty
        ? ""
        : widget.formIngresarObsCtrl!.text;

    widget.formData?.monto =
    widget.formMontoCtrl!.text!.isEmpty
        ? ""
        : widget.formMontoCtrl!.text;

    widget.formData?.grifo =
    widget.formGrifoCtrl!.text!.isEmpty
        ? ""
        : widget.formGrifoCtrl!.text;

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
    return
      Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          title:  Text(Resources.titulo_Bitacora, style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFFD60000),
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

                    widget.formData?.altitud =
                        GPSaltitude;
                    print("GPSaltitude:"+GPSaltitude);

                    widget.formData?.latitud =
                        GPSlatitude;
                    print("GPSlatitude:"+GPSlatitude);

                    widget.formData?.longitud =
                        GPSlongitude;
                    print("longitud:"+GPSlongitude);

                    widget.formData?.codigoOperador =
                    "PENSION";

                    widget.formData?.codigoRegistro =
                        Resources.valor_Bitacora;

                    widget.formData?.dni =
                    "55555555";


                    widget.formData?.fechaRegistro =
                        formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                    widget.formData?.fechaTablet =
                        formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                    widget.formData?.freeEspacioTablet =
                    "";
                    widget.formData?.imei =
                        PREFimei;
                    widget.formData?.tipoCondicion = 0;

                    await GuardarFormulario();

                    var totalEspacioTab = await devicesInfoPlusRepository.getSizeSystemTemp();
                    widget.formData?.totalEspacioTablet = totalEspacioTab[0];
                    widget.formData?.versionAplicacion = PREFversionAplicacionVigente;
                    widget.formData?.versionCondicion = PREFversionCondicion;
                    widget.formData?.versionOperador = PREFversionOperador;


                    await widget.formDataModelDao
                        .insertFormDataModel(widget.formData!);
                    cleanForm();

                    _mostrarLoadingStreamController.add(true);

                  }
                } else {

                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP", context);

                }
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
        ),
      );

  }



  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime).toString();
  }

  void cleanForm() {
    widget.formUsuarioCtrl!.clear();
    widget.formPlacaCtrl!.clear();
    widget.formKilometrajeCtrl!.clear();
    widget.formGalonesCtrl!.clear();
    widget.formMontoCtrl!.clear();
    widget.formGrifoCtrl!.clear();
    widget.formIngresarObsCtrl!.clear();
    widget.formObservacionCtrl!.clear();
    widget.listMediaPath!.clear();
    _Recorrido = Recorrido.Inicio;
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



//VENTANA GRAFICA


  Widget formUI() {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
        child: Column(
        children: <Widget>[
          //RADIO BUTTOn
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
            children: [
              const SizedBox(width: 0.0), // Create left padding

              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  "Recorrido",
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
                  Text('Inicio', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 00.0), // Add spacing between text and radio
                  Radio<Recorrido>(
                    value: Recorrido.Inicio,
                    groupValue: _Recorrido,
                    onChanged: (Recorrido? value) {
                      setState(() {
                        _Recorrido = value;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  Text('Fin', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 0.0), // Add spacing between text and radio
                  Radio<Recorrido>(
                    value: Recorrido.Fin,
                    groupValue: _Recorrido,
                    onChanged: (Recorrido? value) {
                      setState(() {
                        _Recorrido = value;
                      });
                    },
                  ),
                ],
              ),


            ],
          ),


          HelpersViewLetrasRojas.formItemsDesign( "Información Bítacora"),
          const SizedBox(height: 16.0),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.add_card,
              TextFormField(
                controller: widget.formPlacaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingresar Placa',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 7,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.social_distance,
              TextFormField(
                controller: widget.formKilometrajeCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingrese Kilometraje',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 30,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.garage_sharp,
              TextFormField(
                controller: widget.formGalonesCtrl,
                decoration: const InputDecoration(
                  labelText: 'Cantidad de Galones',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 30,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.monetization_on,
              TextFormField(
                controller: widget.formMontoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingrese Monto',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 30,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.car_crash,
              TextFormField(
                controller: widget.formGrifoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Grifo',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 30,
              ), context),

          HelpersViewTextSize.formItemsDesign(
              TextFormField(
                controller: widget.formIngresarObsCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingresar Observaciones',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 255,
                maxLines: 5,
              ), context),

          //Fucion de la camara

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

                                  /*
                                  widget.formData?.recorrido =
                                      _EstadoActividad!.index;
                                  widget.formData?.observacion =
                                  widget.formUsuarioCtrl!.text!.isEmpty
                                      ? ""
                                      : widget.formUsuarioCtrl!.text; */
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
    ));

  }

}
