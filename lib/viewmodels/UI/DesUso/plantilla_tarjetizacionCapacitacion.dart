import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infraestructure/dao/database/database.dart';
import '../../../infraestructure/dao/formdatamodeldao_visita.dart';
import '../../../infraestructure/repository/devicesinfoplusrepository.dart';
import '../../../infraestructure/repository/locationrepository.dart';
import '../../../main.dart';
import '../../../model/t_visita.dart';
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
  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formTelefonoCtrl = TextEditingController();
  TextEditingController formPersonaCtrl = TextEditingController();
  TextEditingController formIngresarObsCtrl = TextEditingController();

  MenuTarjetizacionCapacitacion(this.formData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuTarjetizacionCapacitacion();
  }
}


//PARTE GRAFICA
class _MenuTarjetizacionCapacitacion extends State<MenuTarjetizacionCapacitacion>{

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

  //SATELITE
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

  //COMIENZO BARRA ROJJA FLECHA, GUARDAR, SATELITE
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
                if (isEnableServiceLocation && isHasPermissionLocation && isHasPermissionDevice) {
                  if (isEnableServiceLocation && isHasPermissionLocation && isHasPermissionDevice && (GPSlongitude != "")) {
                    showDialogValidFields("Faltan llenar campos");
                  } else {

                    widget.formData?.codigoOperador = "PENSION";
                    widget.formData?.codigoRegistro = Resources.valor_Reporte_Consolidado_Individual;

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
                    HelpersViewCabecera.Guardar(context);
                  }
                } else {
                  showDialogValidFields(
                      "Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP");
                }
              },
            ),
            IconButton( //SATELITE COORDENADAS ROJO-VERDE
              icon: Image.asset(
                isSatelliteGreen ? Resources.sateliteverde : Resources.sateliterojo,
                // Usa la imagen verde si isSatelliteGreen es verdadero, de lo contrario, usa la imagen roja
              ),
              color: Colors.white,
              onPressed: () {


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
              },
            ),
          ],
        ),

        body:  Center (
          child: SingleChildScrollView(
            child: Container(
              width: 420,
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
                  )
              )
          );
        }
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


  //PARTE GRAFICA DE LA VENTANA

  Widget formUI() {
    return  Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [

          ],
        )
    );
  }
}