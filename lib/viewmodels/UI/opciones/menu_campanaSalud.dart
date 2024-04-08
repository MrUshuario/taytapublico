import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpers.dart';
import 'package:tayta/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:tayta/utils/helpersviewAlertProgressCircle.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewBlancoSmall.dart';
import 'package:tayta/utils/helpersviewCamera.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/helpersviewTextSize.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';

import '../../../infraestructure/dao/database/database.dart';
import '../../../infraestructure/dao/formdatamodeldao_visita.dart';
import '../../../infraestructure/repository/devicesinfoplusrepository.dart';
import '../../../infraestructure/repository/locationrepository.dart';
import '../../../main.dart';
import '../../../model/t_visita.dart';
import '../../../utils/camera.dart';
import '../../../utils/helpersviewAlertFaltaMSG.dart';
import '../../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../../utils/helpersviewBlancoSelect.dart';
import '../../../utils/remplazoCaracteres.dart';
import '../../../utils/viewdisplayfoto.dart';

class MenuCampanaSalud extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;

  bool? isShowButtonCameraInitial = true;
  List<XFile>? listMediaPath;
  String title = Resources.titulo_Bitacora;
  //CAMARA
  String? mediaPath;


  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formDepartamentoCtrl = TextEditingController();
  TextEditingController formProvinciaCtrl = TextEditingController();
  TextEditingController formDistritoCtrl = TextEditingController();
  TextEditingController formCentroPobladoCtrl = TextEditingController();
  TextEditingController formCampana = TextEditingController();
  TextEditingController formFechaAtencion = TextEditingController();
  TextEditingController formUsuariosAtendidos = TextEditingController();
  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formTelefonoCtrl = TextEditingController();
  TextEditingController formPersonaCtrl = TextEditingController();
  TextEditingController formObservacionCtrl = TextEditingController();

  String imageSource = Resources.sateliterojo;
  Visitas? formData;
  MenuCampanaSalud(this.listMediaPath, this.formData, {super.key});

  final ParamDepartamento = List.filled(3, "", growable: false);
  final ParamProvincia = List.filled(3, "", growable: false);
  final ParamDistrito = List.filled(3, "", growable: false);
  final ParamCentroPoblado = List.filled(3, "", growable: false);
  final ParamCampana = List.filled(3, "", growable: false);

  List<String> listDepart = ["Lima", "Cusco", "Junin"];
  List<String> listProvince = ["Lima", "Huaraz", "San Mateo"];
  List<String> listDistrict = ["Lima", "Chosica", "Vitarte"];
  List<String> listCentroPoblado = ["Lima", "Chosica", "Vitarte"];

  List<String> listSelectTipoCampana = [
    "Campania de Atencion Basica",
    "Campania de Atencion Especializada",
    "Campania de Orientacion e Informacion en Salud",
  ];

  @override
  State<StatefulWidget> createState() {
    return _MenuCampanaSalud();
  }
}

class _MenuCampanaSalud extends State<MenuCampanaSalud> {

  late int PREFversionInstancia;
  late String PREFversionAplicacionVigente;
  late String PREFversionAplicacion;
  late int PREFversionCondicion;
  late int PREFversionOperador;
  late String PREFimei;


  late String GPSlatitude = "";
  late String GPSlongitude = "";
  late String GPSaltitude = "";

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
      if (widget.formData!.observacion!.isNotEmpty) {
        /*
        _EstadoActividad = widget.formData!.recorrido == 0
            ? EstadoActividad.Inicio
            : EstadoActividad.Fin;

         */
        setState(() {
          widget.formObservacionCtrl!.text = widget.formData!.observacion!;
        });
      }
    }

    super.initState();
    conseguirVersion();

  }

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


  //CHECKBOX
  bool isChecked = false;
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
        Resources.valor_Campana_de_Salud;

    widget.formData?.observacion =
        widget.formData?.observacion = widget.formObservacionCtrl!.text!.isEmpty
        ? ""
        : widget.formObservacionCtrl!.text!;
        //: remplazoCaracteres.reemplazarCarateresEspeciales(widget.formObservacionCtrl!.text!);

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
            Resources.titulo_Campana_de_Salud,
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
                if (isEnableServiceLocation && isHasPermissionLocation && isHasPermissionDevice) {
                  if (
                    widget.formObservacionCtrl==null && widget.formObservacionCtrl!.text.isEmpty) {
                    HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                  } else {
                    CargaDialog(); //INICIALIZA DIALOGO

                    //RELLENADO DATOS RESTRICCION

                    widget.formData?.codigoOperador =
                      "PENSION";

                    widget.formData?.fechaRegistro =
                        formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());

                    widget.formData?.fechaTablet =
                        formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());

                    widget.formData?.freeEspacioTablet =
                    "";

                    widget.formData?.imei =
                        PREFimei;

                    var coordinates = await locationRepository.getCoordinates();

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

                    widget.formData?.totalEspacioTablet =
                      totalEspacioTab[0];

                    widget.formData?.versionAplicacion =
                        PREFversionAplicacionVigente;

                    widget.formData?.versionCondicion =
                        PREFversionCondicion;

                    widget.formData?.versionOperador =
                        PREFversionOperador;

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
        ),
      ),
    );

  }

  void showDialogValidFields(String? msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenudeOpciones()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: const BoxDecoration(),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    msg.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )),
                              const Icon(
                                Icons.save,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )));
        });
  }

  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime).toString();
  }

  void cleanForm() {
    widget.formObservacionCtrl!.clear();
    widget.formDNICtrl!.clear();
    widget.formData = Visitas();
    widget.isShowButtonCameraInitial = true;
    widget.listMediaPath!.clear();
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


  Widget formUI() {
    return  Column(
        children: <Widget>[

          HelpersViewLetrasRojas.formItemsDesign( "Datos de la ubicación"),
          const SizedBox(height: 16.0),

          //DEPARTAMENTO
          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                items: widget.listDepart.map((dep) {
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
                  //widget.listDepart = [""];
                  widget.formDepartamentoCtrl.text = value!.isEmpty || value == null ? "" : value!;
                  setState(() {
                    /*
                    if(listProv.isEmpty) {
                      listProv = [""];
                    } else {
                      widget.listProvince = listProv;
                    }
                    if(listDists.isEmpty) {
                      listDists = [""];
                    } else {
                      widget.listDistrict = listDists;
                    }
                  */
                  }
                  );
                },
                validator: (value) => HelpersViewBlancoIcon.validateField(
                    widget.formDepartamentoCtrl.text!,
                    widget.ParamDepartamento),
                isDense: true,
                isExpanded: true,
                hint: const Text("Departamento"),
                //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
              )
              ),

          //PROVINCIA
          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                items: widget.listProvince.map((dep) {
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
                  //widget.listDepart = [""];
                  widget.formProvinciaCtrl.text = value!.isEmpty || value == null ? "" : value!;
                  setState(() {
                    /*
                    if(listProv.isEmpty) {
                      listProv = [""];
                    } else {
                      widget.listProvince = listProv;
                    }
                    if(listDists.isEmpty) {
                      listDists = [""];
                    } else {
                      widget.listDistrict = listDists;
                    }
                  */
                  }
                  );
                },
                validator: (value) => HelpersViewBlancoIcon.validateField(
                    widget.formProvinciaCtrl.text!,
                    widget.ParamProvincia),
                isDense: true,
                isExpanded: true,
                hint: const Text("Provincia"),
                //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formProvinciaCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formProvinciaCtrl.text))
              )
              ),


          //DISTRITO
          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                items: widget.listDistrict.map((dep) {
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
                  //widget.listDepart = [""];
                  widget.formDistritoCtrl.text = value!.isEmpty || value == null ? "" : value!;
                  setState(() {
                    /*
                    if(listProv.isEmpty) {
                      listProv = [""];
                    } else {
                      widget.listProvince = listProv;
                    }
                    if(listDists.isEmpty) {
                      listDists = [""];
                    } else {
                      widget.listDistrict = listDists;
                    }
                  */
                  }
                  );
                },
                validator: (value) => HelpersViewBlancoIcon.validateField(
                    widget.formDistritoCtrl.text!,
                    widget.ParamDistrito),
                isDense: true,
                isExpanded: true,
                hint: const Text("Distrito"),
                //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDistritoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDistritoCtrl.text))
              )
              ),

          //CENTRO POBLADO
          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                items: widget.listCentroPoblado.map((dep) {
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
                  //widget.listDepart = [""];
                  widget.formCentroPobladoCtrl.text = value!.isEmpty || value == null ? "" : value!;
                  setState(() {
                    /*
                    if(listProv.isEmpty) {
                      listProv = [""];
                    } else {
                      widget.listProvince = listProv;
                    }
                    if(listDists.isEmpty) {
                      listDists = [""];
                    } else {
                      widget.listDistrict = listDists;
                    }
                  */
                  }
                  );
                },
                validator: (value) => HelpersViewBlancoIcon.validateField(
                    widget.formCentroPobladoCtrl.text!,
                    widget.ParamCentroPoblado),
                isDense: true,
                isExpanded: true,
                hint: const Text("Centro Poblado"),
                //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formApellidoPaternoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formApellidoPaternoCtrl.text))
              )
              ),

          const SizedBox(height: 16.0), // Add margin between text fields
          HelpersViewLetrasRojas.formItemsDesign( "Datos de la Campaña Salud"),
          const SizedBox(height: 16.0),

          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                items: widget.listSelectTipoCampana.map((dep) {
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
                  //widget.listDepart = [""];
                  widget.formCampana.text = value!.isEmpty || value == null ? "" : value!;
                  setState(() {
                    /*
                    if(listProv.isEmpty) {
                      listProv = [""];
                    } else {
                      widget.listProvince = listProv;
                    }
                    if(listDists.isEmpty) {
                      listDists = [""];
                    } else {
                      widget.listDistrict = listDists;
                    }
                  */
                  }
                  );
                },
                validator: (value) => HelpersViewBlancoIcon.validateField(
                    widget.formCampana.text!,
                    widget.ParamCampana),
                isDense: true,
                isExpanded: true,
                hint: const Text("Seleccione Tipo de Campaña Salud"),
                //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formCampana.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formCampana.text))
              )
              ),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.hourglass_empty,
              TextFormField(
                controller: widget.formFechaAtencion,
                decoration: const InputDecoration(
                  labelText: 'Fecha Atención',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023, 03, 01),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    widget.formFechaAtencion.text =
                        Helpers.formatDate('dd/MM/yyyy', pickedDate);
                  }
                },onSaved: (newValue) {
                widget.formFechaAtencion.text =
                    Helpers.formatDate('dd/MM/yyyy', new DateFormat("dd/MM/yyyy").parse(newValue!));
              },
              ), context),




          //USUARIOS ATENDIDOS
          Row(
            children: [

              const Text('Usuarios \n Atendidos', style: TextStyle(
                fontSize: 12.0,
                //color: Colors.white,
              ),),

              HelpersViewBlancoSmall.formItemsDesign(
                  TextFormField(
                    controller: widget.formUsuariosAtendidos,
                    decoration: const InputDecoration(
                      labelText: '',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 3,
                  ), context),

              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),

              const Text('En Tambo', style: TextStyle(
                fontSize: 12.0,
                //color: Colors.white,
              ),),

            ],
          ),

          HelpersViewTextSize.formItemsDesign(
              TextFormField(
                controller: widget.formObservacionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingresar Observaciones',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 255,
                maxLines: 5,
              ), context),


          const SizedBox(height: 16.0),


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
          ),

          const SizedBox(height: 16.0), // Add margin between text fields
          HelpersViewLetrasRojas.formItemsDesign( "Lista de servicios médicos"),
          const SizedBox(height: 16.0),

        ],
    );

  }

}