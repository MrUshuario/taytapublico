import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:tayta/utils/helpersviewAlertProgressCircle.dart';
import 'package:tayta/utils/helpersviewBlancoDNI.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/helpersviewLetrasSubs.dart';
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
import '../../../utils/helpersviewBlancoSelect.dart';


class MenuReporteConsolidado extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formTipoConsulta = TextEditingController();

  final ParamTipoConsulta = List.filled(3, "", growable: false);

  List<String> listTipoConsulta = [
    "Verificaciones",
    "Consulta SISFOH",
    "Consulta de Declaraciones Juradas",
    "histórico de Pagadurias"];


  String imageSource = Resources.sateliterojo;
  Visitas? formData;
  MenuReporteConsolidado(this.formData, {super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _MenuReporteConsolidado();
  }
}
//TIENE UNA CABECERA DISTINTA
class _MenuReporteConsolidado extends State<MenuReporteConsolidado> {


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

    //widget.formObservacionCtrl ??= TextEditingController();
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

  //
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
  //FALTA OPTIMIZAR REPORTE CONSOLIDADO


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            Resources.titulo_Reporte_Consolidado_Individual,
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
                var isHasPermissionDevice = await devicesInfoPlusRepository
                    .isHasPermission();
                if (isEnableServiceLocation && isHasPermissionLocation &&
                    isHasPermissionDevice && (GPSlongitude != "")) {
                  if (widget.formDNICtrl!.text.isEmpty) {
                    HelpersViewAlertMensajeFaltaMSG.formItemsDesign(
                        "Faltan llenar campos", context);
                  }
                  else {
                    CargaDialog(); //INICIALIZA DIALOGO

                    widget.formData?.codigoOperador = "PENSION";
                    widget.formData?.codigoRegistro =
                        Resources.valor_Reporte_Consolidado_Individual;

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
                    print("GPSaltitude:" + GPSaltitude);

                    widget.formData?.latitud =
                        GPSlatitude;
                    print("GPSlatitude:" + GPSlatitude);

                    widget.formData?.longitud =
                        GPSlongitude;
                    print("longitud:" + GPSlongitude);


                    widget.formData?.tipoCondicion = 0;
                    var totalEspacioTab = await devicesInfoPlusRepository
                        .getSizeSystemTemp();
                    widget.formData?.totalEspacioTablet = totalEspacioTab[0];
                    widget.formData?.versionAplicacion =
                        PREFversionAplicacionVigente;
                    widget.formData?.versionCondicion = PREFversionCondicion;
                    widget.formData?.versionOperador = PREFversionOperador;


                    await widget.formDataModelDao
                        .insertFormDataModel(widget.formData!);
                    cleanForm();
                    _mostrarLoadingStreamController.add(true);
                  }
                } else {
                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign(
                      "Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP",
                      context);
                }
              }
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
    widget.formTipoConsulta!.clear();
    widget.formDNICtrl!.clear();
    widget.formData = Visitas();
    setState(() {});
  }

  Widget formUI() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
          children: <Widget>[

            HelpersViewLetrasSubs.formItemsDesign( "Tipo de Consulta"),
            const SizedBox(height: 16.0),

            //SELECT
            HelpersViewBlancoSelect.formItemsDesign(
                DropdownButtonFormField(
                  items: widget.listTipoConsulta.map((dep) {
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
                    widget.formTipoConsulta.text = value!.isEmpty || value == null ? "" : value!;
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
                      widget.formTipoConsulta.text!,
                      widget.ParamTipoConsulta),
                  isDense: true,
                  isExpanded: true,
                  hint: const Text("Seleccione Caso de Violencia"),
                  //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                )
                ),

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
                  icon: Image.asset(Resources.lupaDatos),
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


        ]
      ),
    );
  }
}