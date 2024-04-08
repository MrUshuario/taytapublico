import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/infraestructure/dao/apis/apiprovider_usuarioBuscar.dart';
import 'package:tayta/infraestructure/dao/model/JSON/ModernizacionCobroUser.dart';
import 'package:tayta/utils/helpersviewAlertProgressCircle.dart';
import 'package:tayta/utils/helpersviewBlancoDNI.dart';
import 'package:tayta/utils/helpersviewLetrasSubs.dart';
import '../../../infraestructure/dao/database/database.dart';
import '../../../infraestructure/dao/formdatamodeldao_visita.dart';
import '../../../infraestructure/dao/model/OBJ/Recorrido.dart';
import '../../../infraestructure/repository/devicesinfoplusrepository.dart';
import '../../../infraestructure/repository/locationrepository.dart';
import '../../../main.dart';
import '../../../model/t_visita.dart';
import '../../../utils/helpers.dart';
import '../../../utils/helpersviewAlertFaltaMSG.dart';
import '../../../utils/helpersviewAlertMensajeTitutlo.dart';
import '../../../utils/helpersviewBlancoDNI.dart';
import '../../../utils/helpersviewBlancoIcon.dart';
import '../../../utils/helpersviewBlancoSelect.dart';
import '../../../utils/helpersviewLetrasRojas.dart';
import '../../../utils/helperviewCabecera.dart';
import '../../../utils/resources.dart';
import '../menu_deOpciones.dart';

//PARTE DE PARAMETROS
class MenuTarjetizacionCapacitacion extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;
  String imageSource = Resources.sateliterojo;
  Visitas? formData;

  GlobalKey<FormState> keyForm = GlobalKey();

  //CAPACITACIÓN
  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formNombresCtrl = TextEditingController();
  TextEditingController formApellidosCtrl = TextEditingController();

  TextEditingController formDNITercerCapCtrl = TextEditingController();


  TextEditingController formDepartamentoCtrl = TextEditingController();
  TextEditingController formProvinciaCtrl = TextEditingController();
  TextEditingController formDistritoCtrl = TextEditingController();

  TextEditingController formNombresUsuarioCtrl = TextEditingController();
  TextEditingController formApellidosUsuariosCtrl = TextEditingController();
  TextEditingController formEDADCtrl = TextEditingController();
  TextEditingController formSexoCtrl = TextEditingController();

  TextEditingController? formObservacionCtrl = TextEditingController();
  TextEditingController formIngresarObsCtrl = TextEditingController();

    //TALLERES
    TextEditingController? formFechaTallerCtrl = TextEditingController();
    TextEditingController formAprobTallerCtrl = TextEditingController();

  //TARJETIZACION
  TextEditingController formDNITarjetizacionCtrl = TextEditingController();
  TextEditingController formNombresTarCtrl = TextEditingController();
  TextEditingController formApellidosTarCtrl = TextEditingController();

  TextEditingController formDNITercerTarCtrl = TextEditingController();

  TextEditingController formDepartamentoTarCtrl = TextEditingController();
  TextEditingController formProvinciaTarCtrl = TextEditingController();
  TextEditingController formDistritoTarCtrl = TextEditingController();

  TextEditingController formNombresUsuarioTarCtrl = TextEditingController();
  TextEditingController formApellidosUsuariosTarCtrl = TextEditingController();
  TextEditingController formEDADTarCtrl = TextEditingController();
  TextEditingController formSexoTarCtrl = TextEditingController();

  TextEditingController formNombreAgenciaCtrl = TextEditingController();
  TextEditingController formFechaEntregaCtrl = TextEditingController();

  TextEditingController? formObservacionTarCtrl = TextEditingController();




  MenuTarjetizacionCapacitacion(this.formData, {super.key});

  //LISTA CAPACITACIÓN
  final ParamSexo = List.filled(2, "", growable: false);

  var ProductosLIST = [
    [
      "20/02/2023", "Aprobado"
    ],
  ];

  List<String> listSexo = [
    "Hombre",
    "Mujer",
  ];

  final ParamAprobTaller = List.filled(2, "", growable: false);

  List<String> listAprobTaller = [
    "Aprobado",
    "Desaprobado",
  ];


  final Departamento = List.filled(3, "", growable: false);

  List<String> listDepartamento = [
    "Lima",
    "Cusco",
    "Junin",
  ];

  final Provincia = List.filled(3, "", growable: false);

  List<String> listProvincia = [
    "Lima",
    "Cusco",
    "Junin",
  ];

  final Distrito = List.filled(3, "", growable: false);

  List<String> listDistrito = [
    "Lima",
    "Cusco",
    "Junin",
  ];

  //LISTA TARJETIZACION

  final ParamSexoTar = List.filled(2, "", growable: false);

  List<String> listSexoTar = [
    "Hombre",
    "Mujer",
  ];

  final DepartamentoTar = List.filled(3, "", growable: false);

  List<String> listDepartamentoTar = [
    "Lima",
    "Cusco",
    "Junin",
  ];

  final ProvinciaTar = List.filled(3, "", growable: false);

  List<String> listProvinciaTar = [
    "Lima",
    "Cusco",
    "Junin",
  ];

  final DistritoTar = List.filled(3, "", growable: false);

  List<String> listDistritoTar = [
    "Lima",
    "Cusco",
    "Junin",
  ];

  @override
  State<StatefulWidget> createState() {
    return _MenuTarjetizacionCapacitacion();
  }
}

enum Recorrido { Capacitacion, Tarjetizacion }
bool Capacitacion = false;
bool Tarjetizacion = false;

//CAPACITACION
enum Derivacion { Usuario, TercerPa }
bool TercerPaDerivacion = false;


//TAJRETIZACION
enum DerivacionTarjetizacion { UsuarioTarjetizacion, TercerPaTarjetizacion }
bool TercerPaDerivacionTarjetizacion = false;

enum TipoOperativo {Regular, Dominical, Movil}
bool Regular = false;
bool Dominical = false;
bool Movil = false;

enum Capacitado {SiCa, NoCa}
bool SiCa = false;
bool NoCa = false;


enum TarjetiCobro {SiTar, NoTar}
bool SiTar = false;
bool NoTar = false;



//PARTE GRAFICA
class _MenuTarjetizacionCapacitacion extends State<MenuTarjetizacionCapacitacion>{
  apiprovider_usuarioBuscar apiBuscar = apiprovider_usuarioBuscar();

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
    _Recorrido = null;
    Capacitacion = false;
    Tarjetizacion = false;
    _Derivacion = null;
    _DerivacionTarjetizacion = null;
    _TipoOperativo = null;
    _Capacitado = null;
    _TarjetiCobro = null;
    super.initState();
    conseguirVersion();
  }

  //SATELITE
  Recorrido? _Recorrido = Recorrido.Capacitacion;
  Derivacion? _Derivacion = Derivacion.TercerPa;
  DerivacionTarjetizacion? _DerivacionTarjetizacion = DerivacionTarjetizacion.TercerPaTarjetizacion;
  TipoOperativo? _TipoOperativo = TipoOperativo.Regular;
  Capacitado? _Capacitado = Capacitado.SiCa;
  TarjetiCobro? _TarjetiCobro = TarjetiCobro.SiTar;

  bool isSatelliteGreen = false;

  //PARAMETROS PARA CONSEGUIR VERSION
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
  Future<void> GuardarFormularioTarjetizacion() async {

    widget.formData?.codigoRegistro =
        Resources.valor_Cobro_Tarjetizacion;

  }

  //GUARDAR FUNCTION
  Future<void> GuardarFormularioCapacitacion() async {

    widget.formData?.codigoRegistro =
        Resources.valor_Cobro_Capacitacion;

  }

  void BorrarLista(int index) {
    setState(() {
      widget.ProductosLIST.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          title:  Text(Resources.titulo_Tarjetizacion_Capacitacion, style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFFD60000),
          actions: [
            IconButton( //FLECHA AZUL CUADRO DE CONFIRMACIÓN
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
            //ICONO GUARDADO - PARAMETROS
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
    if (Capacitacion == true) {
    // Verificar campos específicos para capacitación
    if (widget.formObservacionCtrl == null || widget.formObservacionCtrl!.text.isEmpty
        || widget.formDNICtrl == null || widget.formDNICtrl!.text.isEmpty  ) {
    HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
    } else {
    CargaDialog(); //INICIALIZA DIALOGO
    widget.formData?.codigoOperador = "PENSION";
    widget.formData?.codigoRegistro = Resources.valor_Cobro_Capacitacion;
    await GuardarFormularioCapacitacion();
    _mostrarLoadingStreamController.add(true);


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
    widget.formObservacionCtrl!.text!.isEmpty
        ? ""
        : widget.formObservacionCtrl!.text;

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

    }}
    else if (Tarjetizacion == true) {
    // Verificar campos específicos para tarjetización
    if (widget.formObservacionTarCtrl == null || widget.formObservacionTarCtrl!.text.isEmpty
    || widget.formDNITarjetizacionCtrl == null || widget.formDNITarjetizacionCtrl!.text.isEmpty) {
    HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
    } else {
    CargaDialog(); //INICIALIZA DIALOGO
    widget.formData?.codigoOperador = "PENSION";
    widget.formData?.codigoRegistro = Resources.valor_Cobro_Tarjetizacion;
    await GuardarFormularioTarjetizacion();
    _mostrarLoadingStreamController.add(true);


    widget.formData?.dni =

    widget.formDNITarjetizacionCtrl!.text!.isEmpty
        ? ""
        : widget.formDNITarjetizacionCtrl!.text;
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
    widget.formObservacionTarCtrl!.text!.isEmpty
        ? ""
        : widget.formObservacionTarCtrl!.text;

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
                  }
                } else {
                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP", context);}
              },
            ),
            IconButton( //SATELITE COORDENADAS ROJO-VERDE
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



    //FIN BARRA ROJA

  //FECHA
  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime).toString();
  }

  void cleanForm() {
    widget.formIngresarObsCtrl!.clear();
    widget.formDNICtrl!.clear();
    widget.formData = Visitas();
    setState(() {});
  }

  void showModal(context){


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
                child: Column(
                  children: [
                    HelpersViewAlertMensajeTitulo.formItemsDesign("USUARIO ENCONTRADO"),
                    const SizedBox(height: 16.0),
                  ],
                )
            )
        );
      },
    );

  }

  Future<void> llenarAutomatico(String contexto) async {

    /*
    ModernizacionCobro? usuarioMC = await apiBuscar.obtener_usuario( int.parse(widget.formDNICtrl.text));
    print(usuarioMC);

    ModernizacionCobro? usuarioMC2 = await apiBuscar.obtener_usuario2( int.parse(widget.formDNICtrl.text));
    print(usuarioMC2);
     */

    ///CAPACITACION

    if (widget.formDNICtrl.text == '555555555') {
      if (contexto == 'capacitacion') {
        showModal(context);
        setState(() {
          widget.formNombresCtrl.text = 'Maria';
          widget.formApellidosCtrl.text = 'Gabriela';
          _Derivacion = Derivacion.Usuario;
          TercerPaDerivacion = false;
        });

      }
    }

    if (widget.formDNICtrl.text == '444444444') {

      if (contexto == 'capacitacion') {
        showModal(context);
        setState(() {
          widget.formNombresCtrl.text = 'Alan';
          widget.formApellidosCtrl.text = 'Zavala';
          _Derivacion = Derivacion.TercerPa;
          TercerPaDerivacion = true;
        });

      }
    }

    ///TARJERIZCION

    if (widget.formDNITarjetizacionCtrl.text == '555555555') {
      if (contexto == 'tarjetizacion') {
        showModal(context);
        setState(() {
        widget.formNombresTarCtrl.text = 'Maria';
        widget.formApellidosTarCtrl.text = 'Gabriela';
        _DerivacionTarjetizacion = DerivacionTarjetizacion.UsuarioTarjetizacion;
        TercerPaDerivacionTarjetizacion = false;
        });
      }
      // Otros campos si es necesario
    }

    if (widget.formDNITarjetizacionCtrl.text == '444444444') {
      if (contexto == 'tarjetizacion') {
        showModal(context);
        setState(() {
        widget.formNombresTarCtrl.text = 'Alan';
        widget.formApellidosTarCtrl.text = 'Zavala';
        _DerivacionTarjetizacion = DerivacionTarjetizacion.TercerPaTarjetizacion;
        TercerPaDerivacionTarjetizacion = true;
        });
      }
      // Otros campos si es necesario
    }
  }

  //PARTE GRAFICA DE LA VENTANA

  void TalleresDialog(String Enunciado){


    showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context, setState)
              {
                return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
                    content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft, // Align to top left corner
                              child: Container(
                                padding: const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Image.asset(Resources.iconInfo),
                                    Expanded(
                                      child: Text(
                                        Enunciado,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                    )
                );
              }
          );
        }
    );
  }

  Widget formUI() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          HelpersViewLetrasSubs.formItemsDesign("Seleccione la opción: "),
          const SizedBox(height: 16.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
            children: [
              const SizedBox(width: 0.0), // Create left padding

              Row(
                children: [
                  Text('Capacitacion', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 00.0), // Add spacing between text and radio
                  Radio<Recorrido>(
                    value: Recorrido.Capacitacion,
                    groupValue: _Recorrido,
                    onChanged: (Recorrido? value) {
                      setState(() {
                        _Recorrido = value;
                        Capacitacion = true;
                        Tarjetizacion = false;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  Text('Tarjetización', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 0.0), // Add spacing between text and radio
                  Radio<Recorrido>(
                    value: Recorrido.Tarjetizacion,
                    groupValue: _Recorrido,
                    onChanged: (Recorrido? value) {
                      setState(() {
                        _Recorrido = value;
                        Capacitacion = false;
                        Tarjetizacion = true;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),


          //COMIENZO DE CAPACITACIÓN


          Visibility(
              visible: (Capacitacion),
              child: Column(
                  children: <Widget>[
                    HelpersViewLetrasRojas.formItemsDesign( "Su información"),
                    const SizedBox(height: 16.0),

                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55, // Ajusta el ancho según tus necesidades
                          child: HelpersViewBlancoDNI.formItemsDesign(
                            TextFormField(
                              controller: widget.formDNICtrl,
                              decoration: const InputDecoration(
                                labelText: 'Ingrese DNI Capacitación',
                                isDense: true,
                                labelStyle: TextStyle(fontSize: 13.0),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              maxLength: 9,
                            ),
                            context,
                          ),
                        ),

                        IconButton(
                          icon: Image.asset(Resources.lupaDatos),
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          onPressed: () {
                            llenarAutomatico('capacitacion');

                          },
                        ),
                      ],
                    ),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.account_circle_sharp,
                        TextFormField(
                          controller: widget.formNombresCtrl,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Nombres',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 40,
                        ), context),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.account_circle_sharp,
                        TextFormField(
                          controller: widget.formApellidosCtrl,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Apellidos',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 40,
                        ), context),


                    HelpersViewLetrasSubs.formItemsDesign("Seleccione la opción: "),
                    const SizedBox(height: 16.0),

                    Row(
                      children: [


                        const Text(
                          'Usuario',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(width: 00.0),
                        Radio<Derivacion>(
                          value: Derivacion.Usuario,
                          groupValue: _Derivacion,
                          onChanged: (Derivacion? value) {
                            setState(() {
                              _Derivacion = value;
                              TercerPaDerivacion = false;
                            });
                          },
                        ),

                        const Text(
                          'Tercero Autorizado',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Radio<Derivacion>(
                          value: Derivacion.TercerPa,
                          groupValue: _Derivacion,
                          onChanged: (Derivacion? value) {
                            setState(() {
                              _Derivacion = value;
                              TercerPaDerivacion = true;
                            });
                          },
                        ),
                      ],
                    ),

                    Visibility(
                      visible: (TercerPaDerivacion),
                      child: Column(
                          children: <Widget>[

                          Container(
                            width: MediaQuery.of(context).size.width * 0.55, // Ajusta el ancho según tus necesidades
                            child: HelpersViewBlancoDNI.formItemsDesign(
                              TextFormField(
                                controller: widget.formDNITercerCapCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Ingrese DNI',
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                maxLength: 9,
                              ),
                              context,
                            ),
                          ),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.60, // Ajusta el ancho según tus necesidades
                              child: HelpersViewBlancoSelect.formItemsDesign(
                                  DropdownButtonFormField(
                                    items: widget.listDepartamento.map((dep) {
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
                                      //widget.listMotivo = [""];
                                      widget.formDepartamentoCtrl.text = value!.isEmpty || value == null ? "" : value!;
                                      setState(() {
                                      }
                                      );
                                    },
                                    validator: (value) => HelpersViewBlancoIcon.validateField(
                                        widget.formDepartamentoCtrl.text!,
                                        widget.Departamento),
                                    isDense: true,
                                    isExpanded: true,
                                    hint: const Text("Departamento"),
                                    //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                                  )
                                  ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.60, // Ajusta el ancho según tus necesidades
                              child: HelpersViewBlancoSelect.formItemsDesign(
                                  DropdownButtonFormField(
                                    items: widget.listProvincia.map((dep) {
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
                                      //widget.listMotivo = [""];
                                      widget.formDepartamentoCtrl.text = value!.isEmpty || value == null ? "" : value!;
                                      setState(() {
                                      }
                                      );
                                    },
                                    validator: (value) => HelpersViewBlancoIcon.validateField(
                                        widget.formProvinciaCtrl.text!,
                                        widget.Provincia),
                                    isDense: true,
                                    isExpanded: true,
                                    hint: const Text("Provincia"),
                                    //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                                  )
                                  ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.60, // Ajusta el ancho según tus necesidades
                              child: HelpersViewBlancoSelect.formItemsDesign(
                                  DropdownButtonFormField(
                                    items: widget.listDistrito.map((dep) {
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
                                      //widget.listMotivo = [""];
                                      widget.formDistritoCtrl.text = value!.isEmpty || value == null ? "" : value!;
                                      setState(() {
                                      }
                                      );
                                    },
                                    validator: (value) => HelpersViewBlancoIcon.validateField(
                                        widget.formDistritoCtrl.text!,
                                        widget.Distrito),
                                    isDense: true,
                                    isExpanded: true,
                                    hint: const Text("Distrito"),
                                    //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                                  )
                                  ),
                            ),


                            HelpersViewBlancoIcon.formItemsDesign(
                                Icons.account_circle_sharp,
                                TextFormField(
                                  controller: widget.formNombresUsuarioCtrl,
                                  decoration: const InputDecoration(
                                    labelText: 'Nombres del Usuario',
                                  ),
                                  //readOnly: true,
                                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  maxLength: 40,
                                ), context),

                            HelpersViewBlancoIcon.formItemsDesign(
                                Icons.account_circle_sharp,
                                TextFormField(
                                  controller: widget.formApellidosUsuariosCtrl,
                                  decoration: const InputDecoration(
                                    labelText: 'Apellidos del Usuario',
                                  ),
                                  //readOnly: true,
                                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  maxLength: 40,
                                ), context),

                            Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.24, // Ajusta el ancho según tus necesidades
                                    child: HelpersViewBlancoDNI.formItemsDesign(
                                      TextFormField(
                                        controller: widget.formEDADCtrl,
                                        decoration: const InputDecoration(
                                          labelText: 'EDAD',
                                          isDense: true,
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        maxLength: 2,
                                      ),
                                      context,
                                    ),
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.45, // Ajusta el ancho según tus necesidades
                                    child: HelpersViewBlancoSelect.formItemsDesign(
                                        DropdownButtonFormField(
                                          items: widget.listSexo.map((dep) {
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
                                            //widget.listMotivo = [""];
                                            widget.formSexoCtrl.text = value!.isEmpty || value == null ? "" : value!;
                                            setState(() {
                                            }
                                            );
                                          },
                                          validator: (value) => HelpersViewBlancoIcon.validateField(
                                              widget.formSexoCtrl.text!,
                                              widget.ParamSexo),
                                          isDense: true,
                                          isExpanded: true,
                                          hint: const Text("SEXO"),
                                          //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                                        )
                                        ),
                                  ),
                                ]
                            ),


                          ],),
                    ),




                    HelpersViewLetrasRojas.formItemsDesign( "Talleres"),
                    const SizedBox(height: 16.0),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.65, // Ajusta el ancho según tus necesidades
                      child: HelpersViewBlancoSelect.formItemsDesign(
                          DropdownButtonFormField(
                            items: widget.listAprobTaller.map((dep) {
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
                              //widget.listMotivo = [""];
                              widget.formAprobTallerCtrl.text = value!.isEmpty || value == null ? "" : value!;
                              setState(() {
                              }
                              );
                            },
                            validator: (value) => HelpersViewBlancoIcon.validateField(
                                widget.formAprobTallerCtrl.text!,
                                widget.ParamAprobTaller),
                            isDense: true,
                            isExpanded: true,
                            hint: const Text("Aprobo?"),
                            //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                          )
                          ),
                    ),

                    Row(
                        children: [

                          Container(
                            width: MediaQuery.of(context).size.width * 0.50, // Ajusta el ancho según tus necesidades
                            child: HelpersViewBlancoDNI.formItemsDesign(
                              TextFormField(
                                controller: widget.formFechaTallerCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Fecha del encuentro',
                                ),
                                onTap: () async {
                                  // Calcular la fecha hace un año desde hoy
                                  DateTime initialDate = DateTime.now().subtract(Duration(days: 365));

                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: initialDate,
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    widget.formFechaTallerCtrl?.text =
                                        Helpers.formatDate('dd/MM/yyyy', pickedDate);
                                  }
                                },onSaved: (newValue) {
                                widget.formFechaTallerCtrl?.text =
                                    Helpers.formatDate('dd/MM/yyyy', new DateFormat("dd/MM/yyyy").parse(newValue!));
                              },
                                keyboardType: TextInputType.none,
                              ),
                              context,
                            ),
                          ),
                          IconButton(
                            icon: Image.asset(Resources.procesar),
                            alignment: Alignment.centerLeft,
                            color: Colors.white,
                            onPressed: () {
                              if(widget.ProductosLIST.length < 21){
                                setState(() {
                                  widget.ProductosLIST.add([ widget.formFechaTallerCtrl!.text, widget.formAprobTallerCtrl!.text]);
                                });
                                TalleresDialog("Agregado Taller");
                              } else {
                                TalleresDialog("Demasiado Talleres");
                              }

                            },
                          ),
                        ]
                    ),

                    SizedBox(
                      child: ListView.builder( // Use ListView.builder for efficient list rendering
                        shrinkWrap: true, // Prevent excessive padding
                        itemCount: widget.ProductosLIST.length,
                        itemBuilder: (context, index) {
                          final fecha = widget.ProductosLIST[index][0]; // Access date from list
                          final estado = widget.ProductosLIST[index][1]; // Access status from list
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red, // Change this to your desired color
                                width: 1.0, // Adjust border width here
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "Taller ${index+1}",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.fade,
                                    maxLines: 2, // Set the number of lines here
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ),
                                //Icon(iconValue, color: Colors.red,),

                                Text(
                                  fecha, // Display date from list
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2, // Set the number of lines here
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    estado, // Display status from list
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: estado == "Aprobado" ? Colors.green : Colors.red),
                                  ),
                                ),

                          Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child:
                          IconButton(

                            icon:  Image.asset(
                              Resources.fotoX,
                              width: 15, // Desired width in pixels
                              height: 15, // Desired height in pixels
                            ),
                            onPressed: () {
                              BorrarLista(index);
                            },


                          ),
                          ),


                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Observaciones"),
                    const SizedBox(height: 16.0),

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

                  ]
              )
          ),

          //FIN DE CAPACITACIÓN
          //COMIENZO DE TARJETIZACIÓN

          Visibility(
              visible: (Tarjetizacion),
              child: Column(
                  children: <Widget>[
                    HelpersViewLetrasRojas.formItemsDesign("Su información"),
                    const SizedBox(height: 16.00),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55, // Ajusta el ancho según tus necesidades
                          child: HelpersViewBlancoDNI.formItemsDesign(
                            TextFormField(
                              controller: widget.formDNITarjetizacionCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Ingrese DNI Tarjetizado',
                                isDense: true,
                                labelStyle: TextStyle(fontSize: 14.0),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              maxLength: 9,
                            ),
                            context,
                          ),
                        ),

                        IconButton(
                          icon: Image.asset(Resources.lupaDatos),
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          onPressed: () {
                            llenarAutomatico('tarjetizacion');

                          },
                        ),
                      ],
                    ),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.account_circle_sharp,
                        TextFormField(
                          controller: widget.formNombresTarCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Nombres del Tarjetizado',
                            labelStyle: TextStyle(fontSize: 15.0),
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 40,
                        ), context),

                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.account_circle_sharp,
                        TextFormField(
                          controller: widget.formApellidosTarCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Apellidos del Tarjetizado',
                            labelStyle: TextStyle(fontSize: 15.0),
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 40,
                        ), context),


                    HelpersViewLetrasSubs.formItemsDesign("Seleccione la opción: "),
                    const SizedBox(height: 16.0),

                    Row(
                      children: [


                        const Text(
                          'Usuario',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(width: 00.0),
                        Radio<DerivacionTarjetizacion>(
                          value: DerivacionTarjetizacion.UsuarioTarjetizacion,
                          groupValue: _DerivacionTarjetizacion,
                          onChanged: (DerivacionTarjetizacion? value) {
                            setState(() {
                              _DerivacionTarjetizacion = value;
                              TercerPaDerivacionTarjetizacion = false;
                            });
                          },
                        ),

                        const Text(
                          'Tercer Autorizado',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Radio<DerivacionTarjetizacion>(
                          value: DerivacionTarjetizacion.TercerPaTarjetizacion,
                          groupValue: _DerivacionTarjetizacion,
                          onChanged: (DerivacionTarjetizacion? value) {
                            setState(() {
                              _DerivacionTarjetizacion = value;
                              TercerPaDerivacionTarjetizacion = true;
                            });
                          },
                        ),
                      ],
                    ),

                    Visibility(
                      visible: (TercerPaDerivacionTarjetizacion),
                      child: Column(
                          children: <Widget>[

                      Container(
                        width: MediaQuery.of(context).size.width * 0.55, // Ajusta el ancho según tus necesidades
                        child: HelpersViewBlancoDNI.formItemsDesign(
                          TextFormField(
                            controller: widget.formDNITercerTarCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Ingrese DNI',
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            maxLength: 9,
                          ),
                          context,
                        ),
                      ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.60, // Ajusta el ancho según tus necesidades
                              child: HelpersViewBlancoSelect.formItemsDesign(
                                  DropdownButtonFormField(
                                    items: widget.listDepartamentoTar.map((dep) {
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
                                      //widget.listMotivo = [""];
                                      widget.formDepartamentoTarCtrl.text = value!.isEmpty || value == null ? "" : value!;
                                      setState(() {
                                      }
                                      );
                                    },
                                    validator: (value) => HelpersViewBlancoIcon.validateField(
                                        widget.formDepartamentoTarCtrl.text!,
                                        widget.DepartamentoTar),
                                    isDense: true,
                                    isExpanded: true,
                                    hint: const Text("Departamento"),
                                    //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                                  )
                                  ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.60, // Ajusta el ancho según tus necesidades
                              child: HelpersViewBlancoSelect.formItemsDesign(
                                  DropdownButtonFormField(
                                    items: widget.listProvinciaTar.map((dep) {
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
                                      //widget.listMotivo = [""];
                                      widget.formDepartamentoTarCtrl.text = value!.isEmpty || value == null ? "" : value!;
                                      setState(() {
                                      }
                                      );
                                    },
                                    validator: (value) => HelpersViewBlancoIcon.validateField(
                                        widget.formProvinciaTarCtrl.text!,
                                        widget.ProvinciaTar),
                                    isDense: true,
                                    isExpanded: true,
                                    hint: const Text("Provincia"),
                                    //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                                  )
                                  ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.60, // Ajusta el ancho según tus necesidades
                              child: HelpersViewBlancoSelect.formItemsDesign(
                                  DropdownButtonFormField(
                                    items: widget.listDistritoTar.map((dep) {
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
                                      //widget.listMotivo = [""];
                                      widget.formDistritoTarCtrl.text = value!.isEmpty || value == null ? "" : value!;
                                      setState(() {
                                      }
                                      );
                                    },
                                    validator: (value) => HelpersViewBlancoIcon.validateField(
                                        widget.formDistritoTarCtrl.text!,
                                        widget.DistritoTar),
                                    isDense: true,
                                    isExpanded: true,
                                    hint: const Text("Distrito"),
                                    //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                                  )
                                  ),
                            ),


                            HelpersViewBlancoIcon.formItemsDesign(
                                Icons.account_circle_sharp,
                                TextFormField(
                                  controller: widget.formNombresUsuarioTarCtrl,
                                  decoration: const InputDecoration(
                                    labelText: 'Nombres del Usuario',
                                  ),
                                  //readOnly: true,
                                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  maxLength: 40,
                                ), context),

                            HelpersViewBlancoIcon.formItemsDesign(
                                Icons.account_circle_sharp,
                                TextFormField(
                                  controller: widget.formApellidosUsuariosTarCtrl,
                                  decoration: const InputDecoration(
                                    labelText: 'Apellidos del Usuario',
                                  ),
                                  //readOnly: true,
                                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  maxLength: 40,
                                ), context),

                            Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.24, // Ajusta el ancho según tus necesidades
                                    child: HelpersViewBlancoDNI.formItemsDesign(
                                      TextFormField(
                                        controller: widget.formEDADTarCtrl,
                                        decoration: const InputDecoration(
                                          labelText: 'EDAD',
                                          isDense: true,
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        maxLength: 2,
                                      ),
                                      context,
                                    ),
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.45, // Ajusta el ancho según tus necesidades
                                    child: HelpersViewBlancoSelect.formItemsDesign(
                                        DropdownButtonFormField(
                                          items: widget.listSexoTar.map((dep) {
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
                                            //widget.listMotivo = [""];
                                            widget.formSexoTarCtrl.text = value!.isEmpty || value == null ? "" : value!;
                                            setState(() {
                                            }
                                            );
                                          },
                                          validator: (value) => HelpersViewBlancoIcon.validateField(
                                              widget.formSexoTarCtrl.text!,
                                              widget.ParamSexoTar),
                                          isDense: true,
                                          isExpanded: true,
                                          hint: const Text("SEXO"),
                                          //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formDepartamentoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formDepartamentoCtrl.text))
                                        )
                                        ),
                                  ),
                                ]
                            ),
                      ],),
                    ),



                    HelpersViewLetrasSubs.formItemsDesign("Tipo operativo: "),
                    const SizedBox(height: 16.0),

              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // Align content to the left
                  children: [
                    const SizedBox(width: 0.0), // Create left padding

                    Row(
                      children: [
                        const Text(
                          'Regular',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(width: 00.0),
                        Radio<TipoOperativo>(
                          value: TipoOperativo.Regular,
                          groupValue: _TipoOperativo,
                          onChanged: (TipoOperativo? value) {
                            setState(() {
                              _TipoOperativo = value;
                              Movil = false;
                            });
                          },
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        const Text(
                          'Dominical',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(width: 00.0),
                        Radio<TipoOperativo>(
                          value: TipoOperativo.Dominical,
                          groupValue: _TipoOperativo,
                          onChanged: (TipoOperativo? value) {
                            setState(() {
                              _TipoOperativo = value;
                              Movil = false;
                            });
                          },
                        ),
                      ],
                    ),


                    Row(
                      children: [
                        const Text(
                          'Movil',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(width: 00.0),
                        Radio<TipoOperativo>(
                          value: TipoOperativo.Movil,
                          groupValue: _TipoOperativo,
                          onChanged: (TipoOperativo? value) {
                            setState(() {
                              _TipoOperativo = value;
                              Movil = true;
                            });
                          },
                        ),
                      ],
                    ),
                    ]
              ),
              Visibility(
                visible: (Movil),
                child:
                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.account_circle_sharp,
                        TextFormField(
                          controller: widget.formNombreAgenciaCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Nombre de la agencia',
                          ),
                          //readOnly: true,
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 50,
                        ), context),
          ),
                    HelpersViewBlancoIcon.formItemsDesign(
                        Icons.hourglass_empty,
                        TextFormField(
                          controller: widget.formFechaEntregaCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Fecha del encuentro',
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            );
                            if (pickedDate != null) {
                              widget.formFechaEntregaCtrl.text =
                                  Helpers.formatDate('dd/MM/yyyy', pickedDate);
                            }
                          },onSaved: (newValue) {
                          widget.formFechaEntregaCtrl.text =
                              Helpers.formatDate('dd/MM/yyyy', new DateFormat("dd/MM/yyyy").parse(newValue!));
                        },
                          keyboardType: TextInputType.none,
                        ), context),

                    HelpersViewLetrasSubs.formItemsDesign("Capacitado: "),
                    const SizedBox(height: 16.0),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Align content to the left
                        children: [
                          const SizedBox(width: 0.0), // Create left padding

                          Row(
                            children: [
                              const Text(
                                'Si',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(width: 00.0),
                              Radio<Capacitado>(
                                value: Capacitado.SiCa,
                                groupValue: _Capacitado,
                                onChanged: (Capacitado? value) {
                                  setState(() {
                                    _Capacitado = value;
                                  });
                                },
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(width: 00.0),
                              Radio<Capacitado>(
                                value: Capacitado.NoCa,
                                groupValue: _Capacitado,
                                onChanged: (Capacitado? value) {
                                  setState(() {
                                    _Capacitado = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ]
                    ),




                    HelpersViewLetrasSubs.formItemsDesign("Tarjetiz Cobro: "),
                    const SizedBox(height: 16.0),


                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Align content to the left
                        children: [
                          const SizedBox(width: 0.0), // Create left padding

                          Row(
                            children: [
                              const Text(
                                'Si',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(width: 00.0),
                              Radio<TarjetiCobro>(
                                value: TarjetiCobro.SiTar,
                                groupValue: _TarjetiCobro,
                                onChanged: (TarjetiCobro? value) {
                                  setState(() {
                                    _TarjetiCobro = value;
                                  });
                                },
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(width: 00.0),
                              Radio<TarjetiCobro>(
                                value: TarjetiCobro.NoTar,
                                groupValue: _TarjetiCobro,
                                onChanged: (TarjetiCobro? value) {
                                  setState(() {
                                    _TarjetiCobro = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ]
                    ),


                    HelpersViewLetrasRojas.formItemsDesign( "Observaciones"),
                    const SizedBox(height: 16.0),

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
                            controller: widget.formObservacionTarCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Ingresar Observaciones',
                            ),
                            maxLength: 255,
                            maxLines: 5,
                          ),
                        )),

                  ]
              )
          )

          //FINAL CAPACITACIÓN
        ]
      )

    );
  }
}