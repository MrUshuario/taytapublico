import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/infraestructure/dao/database/database.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_visita.dart';
import 'package:tayta/model/t_visita.dart';
import 'package:tayta/utils/helpers.dart';
import 'package:tayta/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:tayta/utils/helpersviewAlertProgressCircle.dart';
import 'package:tayta/utils/helpersviewBlancoDNI.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/helpersviewLetrasSubs.dart';
import 'package:tayta/utils/helpersviewTextSize.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';

import '../../../infraestructure/repository/devicesinfoplusrepository.dart';
import '../../../infraestructure/repository/locationrepository.dart';
import '../../../main.dart';
import '../../../utils/helpersviewAlertFaltaMSG.dart';
import '../../../utils/helpersviewBlancoSelect.dart';

class MenuSituacionesRiesgo extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formApePaternoCtrl = TextEditingController();
  TextEditingController formApeMaternoCtrl = TextEditingController();
  TextEditingController formNombresBeneficiarioCtrl = TextEditingController();
  TextEditingController formFechaHechoCtrl = TextEditingController(); //LAS FECHAS LAS DEJAMOS DE LADO DE MOMENTO
  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formInfoCasoCtrl = TextEditingController();
  TextEditingController formIngresarObsCtrl = TextEditingController();
  TextEditingController formCasoVilenciaCtrl = TextEditingController();
  TextEditingController formVinculoVictimaCtrl = TextEditingController();
  TextEditingController formVinculoAgresorCtrl = TextEditingController();
  TextEditingController formInstanciaDeribatrl = TextEditingController();

  TextEditingController? formObservacionCtrl = TextEditingController();


  /*ESTAS TABLAS HACER PARA LISTAR
         listaViolenciaDetectada = sqlcon.listaTipoViolencia();
        listaVictima = sqlcon.listaTipoVictima();
        listaPersonaAgresora = sqlcon.listaTipoVictima();
        listaInstancia = sqlcon.listaInstancia();
   */

  Visitas? formData;
  String imageSource = Resources.sateliterojo;


  final ParamDCasoVilencia = List.filled(3, "", growable: false);
  final ParamDTipoVinculo = List.filled(3, "", growable: false);
  final ParamDVinculoAgresor = List.filled(3, "", growable: false);
  final ParamInstanciaDeriba = List.filled(3, "", growable: false);

  List<String> listCasoVilencia = [
    "Negligencia Y/O Abandono",
    "Violencia Psigologica",
    "Violencia Fisica",
    "Violencia Familiar Y/O Sexual",
    "Violencia Economica Y/O Patrimonial"];

  List<String> listTipoVinculo = [
    "Esposa(O)",
    "Conviviente",
    "Hermana(O)",
    "Hija(O)",
    "Nieta(O)",
    "Cuñado",
    "Yerno/Nuera",
    "Sobrina(O) u otro familiar",
    "Vecina(O) Y/O desconocido",
  ];

  List<String> listInstancia = [
    "Violencia Fisica",
    "Fiscalia",
    "CEM",
    "Juzgados de Paz",
    "Gobernación",
    "Gobierno Local",
    "Comisaria PNP",
    "Demuna",
  ];

  MenuSituacionesRiesgo(this.formData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuSituacionesRiesgo();
  }
}

enum EstadoActividad { Inicio, Fin }


///RADION BUTTON
enum PosibleVictima { Usuario, Familiar, Otro }
enum Derivacion { No, Si }

bool RadioFamiliar = false;
bool siDerivacion = false;

class _MenuSituacionesRiesgo extends State<MenuSituacionesRiesgo> {


  CameraController? controller;
  PosibleVictima? _PosibleVictima = PosibleVictima.Usuario;
  Derivacion? _Derivacion = Derivacion.No;

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

    if (widget.formData != null && widget.formData!.observacion != null) {
      if (widget.formData!.observacion!.isNotEmpty) {

        //RADIO EL TIPO DE VICTIMA
        if (widget.formData!.codigoVictima == 1) {
          _PosibleVictima  = PosibleVictima.Usuario;
        } else if(widget.formData!.codigoVictima == 2) {
          _PosibleVictima  = PosibleVictima.Familiar;
        } else if(widget.formData!.codigoVictima == 3) {
          _PosibleVictima  = PosibleVictima.Otro;
        } else {
          _PosibleVictima  = null;
        }

        //RADIO DERIVACION
        if (widget.formData!.codigoVictima == 1) {
          _Derivacion  = Derivacion.Si;
        } else {
          _Derivacion  = Derivacion.No;
        }


        if (widget.formData!.dni!.isNotEmpty) {
          setState(() {
            widget.formDNICtrl!.text = widget.formData!.dni!;
          });
        }

        if (widget.formData!.observacion!.isNotEmpty) {
          setState(() {
            widget.formIngresarObsCtrl!.text = widget.formData!.observacion!;
          });
        }

        if (widget.formData!.apepat!.isNotEmpty) {
          setState(() {
            widget.formApePaternoCtrl!.text = widget.formData!.apepat!;
          });
        }

        if (widget.formData!.apemat!.isNotEmpty) {
          setState(() {
            widget.formApeMaternoCtrl!.text = widget.formData!.apemat!;
          });
        }

        if (widget.formData!.nombres!.isNotEmpty) {
          setState(() {
            widget.formNombresBeneficiarioCtrl!.text = widget.formData!.nombres!;
          });
        }

        if (widget.formData!.fechaEncuentro!.isNotEmpty) {
          setState(() {
            widget.formFechaHechoCtrl!.text = widget.formData!.fechaEncuentro!;
          });
        }

        if (widget.formData!.observacionSaberes!.isNotEmpty) {
          setState(() {
            widget.formInfoCasoCtrl!.text = widget.formData!.observacionSaberes!;
          });
        }

          //PIDE QUE TRAIGA EL INDICE DEBE SER POR INDICE (0) usa un sql pero por ahora pondre algo fijo
          // widget.formCasoVilenciaCtrl.text = widget.formData!.codigoViolenciaDetectada!;
          // widget.formVinculoVictimaCtrl.text  = widget.formData!.codigoVictima!;
          //widget.formVinculoAgresorCtrl.text  = widget.formData!.codigoVinculoPersonaAgresora!;
          //widget.formInstanciaDeribatrl.text  = widget.formData!.codigoInstancia!;

      }
    }

    conseguirVersion();
    super.initState();
  }

  bool isSatelliteGreen = false;


  @override
  void dispose() {
    controller?.dispose();
    // TODO: implement dispose
    super.dispose();
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

    widget.formData?.apepat =
    widget.formApePaternoCtrl!.text!.isEmpty
        ? ""
        : widget.formApePaternoCtrl!.text;

    widget.formData?.apemat =
    widget.formApeMaternoCtrl!.text!.isEmpty
        ? ""
        : widget.formApeMaternoCtrl!.text;

    widget.formData?.nombres =
    widget.formNombresBeneficiarioCtrl!.text!.isEmpty
        ? ""
        : widget.formNombresBeneficiarioCtrl!.text;

    widget.formData?.fechaEncuentro =
    widget.formFechaHechoCtrl!.text!.isEmpty
        ? ""
        : widget.formFechaHechoCtrl!.text;

    widget.formData?.observacionSaberes =
    widget.formInfoCasoCtrl!.text!.isEmpty
        ? ""
        : widget.formInfoCasoCtrl!.text;

    //USUARIO 1, FAMILIAR 2, OTRO 3
    widget.formData?.flagVictimaUsuario =
        (_PosibleVictima!.index+1)!;


    //SI 1, No 0
    widget.formData?.flagInstanciaSi =
        (_Derivacion!.index+1)!;



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
            Resources.titulo_Casos_de_Violencia,
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
                if (isEnableServiceLocation && isHasPermissionLocation && isHasPermissionDevice) {
                  if (widget.formIngresarObsCtrl==null && widget.formIngresarObsCtrl!.text.isEmpty) {
                    HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                  } else {
                    CargaDialog(); //INICIALIZA DIALOGO

                    widget.formData?.codigoOperador = "PENSION";
                    widget.formData?.codigoRegistro = Resources.valor_Situaciones_de_Riesgo;

                    widget.formData?.fechaRegistro =
                        formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                    widget.formData?.fechaTablet =
                        formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                    widget.formData?.freeEspacioTablet = "";
                    widget.formData?.imei = "0001";//await devicesInfoPlusRepository.getImei();

                    widget.formData?.altitud =
                        GPSaltitude;
                    print("GPSaltitude:"+GPSaltitude);

                    widget.formData?.latitud =
                        GPSlatitude;
                    print("GPSlatitude:"+GPSlatitude);

                    widget.formData?.longitud =
                        GPSlongitude;
                    print("longitud:"+GPSlongitude);

                    widget.formData?.tipoCondicion = 0;
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
                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP", context); }
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
    widget.formApePaternoCtrl!.clear();
    widget.formApeMaternoCtrl!.clear();
    widget.formNombresBeneficiarioCtrl!.clear();
    widget.formFechaHechoCtrl!.clear();
    widget.formDNICtrl!.clear();
    widget.formInfoCasoCtrl!.clear();
    widget.formIngresarObsCtrl!.clear();
    widget.formCasoVilenciaCtrl!.clear();
    widget.formVinculoVictimaCtrl!.clear();
    widget.formVinculoAgresorCtrl!.clear();
    widget.formInstanciaDeribatrl!.clear();
    widget.formObservacionCtrl!.clear();
    _PosibleVictima = PosibleVictima.Usuario;
    _Derivacion = Derivacion.No;
    widget.formData = Visitas();
    setState(() {});
  }

  Widget formUI() {
    return  Column(
        children: <Widget>[

          HelpersViewLetrasRojas.formItemsDesign( "Información del Beneficiario"),
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
                controller: widget.formApePaternoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Apellido Paterno',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 30,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.person,
              TextFormField(
                controller: widget.formApeMaternoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Apellido Materno',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 30,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.person,
              TextFormField(
                controller: widget.formNombresBeneficiarioCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombres del Beneficiario',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 30,
              ), context),

          HelpersViewLetrasRojas.formItemsDesign( "Información del hecho"),
          const SizedBox(height: 16.0),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.hourglass_empty,
              TextFormField(
                controller: widget.formFechaHechoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Fecha del Hecho',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023, 03, 01),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    widget.formFechaHechoCtrl.text =
                        Helpers.formatDate('dd/MM/yyyy', pickedDate);
                  }
                },onSaved: (newValue) {
                widget.formFechaHechoCtrl.text =
                    Helpers.formatDate('dd/MM/yyyy', new DateFormat("dd/MM/yyyy").parse(newValue!));
              },
              ), context),

          HelpersViewLetrasSubs.formItemsDesign( "Posible Caso de Violencia Detectado"),


          //SELECT
          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                items: widget.listCasoVilencia.map((dep) {
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
                  widget.formCasoVilenciaCtrl.text = value!.isEmpty || value == null ? "" : value!;
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
                    widget.formCasoVilenciaCtrl.text!,
                    widget.ParamDCasoVilencia),
                isDense: true,
                isExpanded: true,
                hint: const Text("Seleccione Caso de Violencia"),
                //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
              )
              ),

          const SizedBox(height: 16.0),

          HelpersViewLetrasSubs.formItemsDesign( "Posible Victima"),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // Align content to the left
            children: [
              const SizedBox(width: 0.0), // Create left padding

              Row(
                children: [
                  const Text(
                    'Usuario',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(width: 00.0),
                  Radio<PosibleVictima>(
                    value: PosibleVictima.Usuario,
                    groupValue: _PosibleVictima,
                    onChanged: (PosibleVictima? value) {
                      setState(() {
                        _PosibleVictima = value;
                        RadioFamiliar = false;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  const Text(
                    'Familiar',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  Radio<PosibleVictima>(
                    value: PosibleVictima.Familiar,
                    groupValue: _PosibleVictima,
                    onChanged: (PosibleVictima? value) {
                      setState(() {
                        _PosibleVictima = value;
                        RadioFamiliar = true;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  const Text(
                    'Otro',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  Radio<PosibleVictima>(
                    value: PosibleVictima.Otro,
                    groupValue: _PosibleVictima,
                    onChanged: (PosibleVictima? value) {
                      setState(() {
                        _PosibleVictima = value;
                        RadioFamiliar = false;
                      });
                    },
                  ),
                ],
              ),

            ],
          ),

          Visibility(
              visible: (RadioFamiliar),
              child :  HelpersViewLetrasSubs.formItemsDesign( "Seleccione un Tipo de Vinculo con la victima"),
          ),


      Visibility(
      visible: (RadioFamiliar),
      child: //SELECT
      HelpersViewBlancoSelect.formItemsDesign(
          DropdownButtonFormField(
            items: widget.listTipoVinculo.map((dep) {
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
              widget.formVinculoVictimaCtrl.text = value!.isEmpty || value == null ? "" : value!;
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
                widget.formVinculoVictimaCtrl.text!,
                widget.ParamDTipoVinculo),
            isDense: true,
            isExpanded: true,
            hint: const Text("Seleccione Tipo Vínculo"),
            //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
          )
          ),
      ),


          HelpersViewLetrasSubs.formItemsDesign( "Seleccione un Tipo de Vinculo con la posible persona agresora"),

          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                items: widget.listTipoVinculo.map((dep) {
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
                  widget.formVinculoAgresorCtrl.text = value!.isEmpty || value == null ? "" : value!;
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
                    widget.formVinculoAgresorCtrl.text!,
                    widget.ParamDVinculoAgresor),
                isDense: true,
                isExpanded: true,
                hint: const Text("Seleccione Tipo Vínculo con el posible agresor"),
                //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
              )
              ),

          const SizedBox(height: 16.0),



              HelpersViewTextSize.formItemsDesign(
                  TextFormField(
                    controller: widget.formInfoCasoCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Información del Caso',
                    ),
                    //readOnly: true,
                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 255,
                    maxLines: 5,
                  ), context),


          const SizedBox(height: 16.0),
          HelpersViewLetrasSubs.formItemsDesign( "Se procederá a la derivación?"),

              Row(
                children: [


                  const Text(
                    'Sí',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(width: 00.0),
                  Radio<Derivacion>(
                    value: Derivacion.Si,
                    groupValue: _Derivacion,
                    onChanged: (Derivacion? value) {
                      setState(() {
                        _Derivacion = value;
                        siDerivacion = true;
                      });
                    },
                  ),

                      const Text(
                        'No',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      Radio<Derivacion>(
                        value: Derivacion.No,
                        groupValue: _Derivacion,
                        onChanged: (Derivacion? value) {
                          setState(() {
                            _Derivacion = value;
                            siDerivacion = false;
                          });
                        },
                      ),



                ],
              ),

          //
          Visibility(
            visible: (siDerivacion),
            child :  HelpersViewLetrasSubs.formItemsDesign( "Seleccione instancia derivada"),
          ),

          Visibility(
            visible: (siDerivacion),
            child: //SELECT
            HelpersViewBlancoSelect.formItemsDesign(
                DropdownButtonFormField(
                  items: widget.listInstancia.map((dep) {
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
                    widget.formInstanciaDeribatrl.text = value!.isEmpty || value == null ? "" : value!;
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
                      widget.formInstanciaDeribatrl.text!,
                      widget.ParamInstanciaDeriba),
                  isDense: true,
                  isExpanded: true,
                  hint: const Text("Seleccione Instancia"),
                  //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                )
                ),
          ),



          const SizedBox(height: 16.0),

          HelpersViewTextSize.formItemsDesign(
              TextFormField(
                controller: widget.formIngresarObsCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingresar Observación',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 255,
                maxLines: 5,
              ), context),



        ],
    );
  }

}