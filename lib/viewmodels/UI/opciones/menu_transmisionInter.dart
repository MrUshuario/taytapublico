import 'dart:async';

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
import 'package:tayta/utils/helpersviewBlancoSelect.dart';
import 'package:tayta/utils/helpersviewBlancoSmall.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';

import '../../../infraestructure/dao/database/database.dart';
import '../../../infraestructure/dao/formdatamodeldao_visita.dart';
import '../../../infraestructure/repository/devicesinfoplusrepository.dart';
import '../../../infraestructure/repository/locationrepository.dart';
import '../../../main.dart';
import '../../../model/t_visita.dart';
import '../../../utils/helpersviewAlertFaltaMSG.dart';

class MenuTransmisionInter extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formDepartamentoCtrl = TextEditingController();
  TextEditingController formProvinciaCtrl = TextEditingController();
  TextEditingController formDistritoCtrl = TextEditingController();
  TextEditingController formFallecimientoDateCtrl = TextEditingController();

  TextEditingController formTipoInstitucionCtrl = TextEditingController();
  TextEditingController formNombreInstitucionCtrl = TextEditingController();
  TextEditingController formNAsistenteCtrls = TextEditingController();

  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formTelefonoCtrl = TextEditingController();
  TextEditingController formPersonaCtrl = TextEditingController();
  TextEditingController formIngresarObsCtrl = TextEditingController();

  String imageSource = Resources.sateliterojo;
  Visitas? formData;
  MenuTransmisionInter(this.formData, {super.key});

  final ParamDepartamento = List.filled(3, "", growable: false);
  final ParamProvincia = List.filled(3, "", growable: false);
  final ParamDistrito = List.filled(3, "", growable: false);

  final ParamTipoInstitucion = List.filled(3, "", growable: false);

  List<String> listDepart = ["Lima", "Cusco", "Junin"];
  List<String> listProvince = ["Lima", "Huaraz", "San Mateo"];
  List<String> listDistrict = ["Lima", "Chosica", "Vitarte"];
  List<String> listTipoInstitucion = [
    "Instituciones Educativas",
    "Organizaciones Sociales de Base",
    "CETPROS", "Institutos de Educación Superior",
    "Universidades","Usuarios de Programas Sociales",
    "Organizaciones de la Sociedad Civil", "Otros"];

  @override
  State<StatefulWidget> createState() {
    return _MenuTransmisionInter();
  }
}

///RADION BUTTON
enum Dialogo { Dialogo_Presencial, Dialogo_Virtual }

class _MenuTransmisionInter extends State<MenuTransmisionInter> {

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

  //RADION BUTTOn
  Dialogo? _dialogo = null;
  bool isSatelliteGreen = false;

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

  //FALTA OPTIMIZAR

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            Resources.titulo_Transmision_Interegeneracional,
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
                  if (widget.formIngresarObsCtrl==null && widget.formIngresarObsCtrl!.text.isEmpty) {
                    HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                  } else {
                    CargaDialog(); //INICIALIZA DIALOGO
                    widget.formData?.codigoOperador = "PENSION";
                    widget.formData?.codigoRegistro = Resources.valor_Transmision_Interegeneracional;

                    widget.formData?.dni =

                    widget.formDNICtrl!.text!.isEmpty
                        ? ""
                        : widget.formDNICtrl!.text;
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

                    widget.formData?.observacion =
                    widget.formIngresarObsCtrl!.text!.isEmpty
                        ? ""
                        : widget.formIngresarObsCtrl!.text;

                    widget.formData?.tipoCondicion = 0;
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


  Widget formUI() {
    return  Column(
        children: <Widget>[


          //RADIO BUTTOn
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
            children: [
              const SizedBox(width: 0.0), // Create left padding


              Row(
                children: [
                  Text('ATI PRESENCIAL', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 00.0), // Add spacing between text and radio
                  Radio<Dialogo>(
                    value: Dialogo.Dialogo_Presencial,
                    groupValue: _dialogo,
                    onChanged: (Dialogo? value) {
                      setState(() {
                        _dialogo = value;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  Text('ATI Virtual', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 0.0), // Add spacing between text and radio
                  Radio<Dialogo>(
                    value: Dialogo.Dialogo_Virtual,
                    groupValue: _dialogo,
                    onChanged: (Dialogo? value) {
                      setState(() {
                        _dialogo = value;
                      });
                    },
                  ),
                ],
              ),


            ],
          ),

          HelpersViewLetrasRojas.formItemsDesign( "ingresar Ubicación, Fecha"),
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

          HelpersViewLetrasRojas.formItemsDesign( "Datos de la institución"),
          const SizedBox(height: 16.0),



          //TIPO INSTITUCION
          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                items: widget.listTipoInstitucion.map((dep) {
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
                  widget.formTipoInstitucionCtrl.text = value!.isEmpty || value == null ? "" : value!;
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
                    widget.formTipoInstitucionCtrl.text!,
                    widget.ParamTipoInstitucion),
                isDense: true,
                isExpanded: true,
                hint: const Text("Tipo institución"),
                //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDistritoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDistritoCtrl.text))
              )
              ),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.note,
              TextFormField(
                controller: widget.formNombreInstitucionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Institución',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 8,
              ), context),


          Row(
            children: [

              const Text('N. Asistentes', style: TextStyle(
                fontSize: 12.0,
                //color: Colors.white,
              ),),

              HelpersViewBlancoSmall.formItemsDesign(
                  TextFormField(
                    controller: widget.formNAsistenteCtrls,
                    decoration: const InputDecoration(
                      labelText: '',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 3,
                  ), context),

            ],
          ),



        ],
    );

  }

}