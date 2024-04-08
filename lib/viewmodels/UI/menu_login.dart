import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:android_id/android_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/infraestructure/dao/database/database.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_version.dart';
import 'package:tayta/infraestructure/dao/model/JSON/versionesModel.dart';
import 'package:tayta/infraestructure/dao/model/VersionMapper.dart';
import 'package:tayta/model/t_ubigeo.dart';
import 'package:tayta/model/t_version.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpersviewAlertCargandoCircle.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewBlancoTexto.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';
import 'package:tayta/viewmodels/UI/menu_permisos.dart';
import 'package:tayta/viewmodels/UI/viewmodels/form_viewsmodel_reporteVersiones.dart';
import'../../infraestructure/dao/apis/apiprovider_menuOpciones.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_imei/device_imei.dart';
import 'package:permission_handler/permission_handler.dart';


import '../../main.dart';
import '../../utils/conexionComprobacion.dart';

class login extends StatefulWidget {

  //TABLA USUARIOS

  //MANEJAR VERSIONS BD
  final viewModel = FormDataModelViewModel();

  Version? versionObj;
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formUsuarioCtrl = TextEditingController();
  TextEditingController formClaveCtrl = TextEditingController();

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => login());

  @override
  State<StatefulWidget> createState() => _login();
}

class _login extends State<login> {

  static const _androidIdPlugin = AndroidId();
  var _androidId = 'Unknown';

  //late int PREFversionInstancia;
  late String PREFversionAplicacionVigente;
  late var PREF_androidId;

  late final _appDatabase;
  FormDataModelDaoVERSION get formDataModelDao => _appDatabase.formDataModelDaoVersion;

  //IMPRIMIR
  late String versionPrintAplicacion = "(Falta sincronizar)";

  //IMEI
  String _platformVersion = 'Unknown';
  String? deviceImei;
  String? type;
  DeviceInfo? deviceInfo;
  bool getPermission = false;
  bool isloading = false;
  final _deviceImeiPlugin = DeviceImei();

  apiprovider_menuOpciones apiVersion = apiprovider_menuOpciones();
  List<Version> ModelEntityVersion = List.empty();
  List<Ubigeo> ModelEntityUbigeo = List.empty();

  String? ConcatDepart;
  versionesModel Model = versionesModel();
  String? UTCONCAT = "DESCONOCIDO";


  @override
  void initState() {

    super.initState();
    initializeDatabase();
    initPlatformState();
    //setPlatformType();
    _initAndroidId();
    conseguirVersion();
    //checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar: AppBar(
          title: const Text(Constants.tituloMenuLogin, style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFD60000),
          //leading: Icon(Icons.menu),
          actions: [
            IconButton(
              icon: Image.asset(Resources.iconInfo),
              color: Colors.white,
              onPressed: () async {showModal(); },
            ),
            IconButton(
              icon: Image.asset(Resources.iconDownload),
              color: Colors.white,
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset(Resources.iconCandado),
              color: Colors.white,
              onPressed: () {                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MenuPermisos()),
              ); },
            ),
          ],
        ),
        //drawer: const MenuLateral(),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 420,
              margin: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Form(
                key: widget.keyForm,
                child: formUI(),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 50, // Altura de la barra
          color: Color(0xFFD60000),
          child: Center(
            child: Text(
              'U.T. ${UTCONCAT}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final _mostrarLoadingStreamController = StreamController<bool>.broadcast();
  void AlertCargando(){
    bool mostrarLOADING = false;
    showDialog(
      barrierDismissible: true,
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
                    HelpersViewAlertCargandoCircle(
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


/*
  setPlatformType() {
    if (Platform.isAndroid) {
      setState(() {
        type = 'Android';
      });
    } else if (Platform.isIOS) {
      setState(() {
        type = 'iOS';
      });
    } else {
      setState(() {
        type = 'other';
      });
    }
  }

 */

  Future<void> initializeDatabase() async {
    _appDatabase = await GetIt.I.get<AppDatabase>();
  }

  Future<void> initPlatformState() async {

    String platformVersion;
    try {
      platformVersion = await _deviceImeiPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    AlertCargando();

  }




  void  InicioGuardarUbigeon() async  {

  }

  Future<void> _initAndroidId() async {
    String androidId;
    try {
      androidId = await _androidIdPlugin.getId() ?? 'Unknown ID';
    } on PlatformException {
      androidId = 'Failed to get Android ID.';
    }
    if (!mounted)  return;

    setState(() => _androidId = androidId);
  }

  //REVISAR SI HAY INTERNET
  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Hay conexión a Internet
      }
    } on SocketException catch (_) {
      return false; // No hay conexión a Internet
    }
    return false; // No hay conexión a Internet
  }

  //MODAL
  Future<void> conseguirVersion() async {

    //QUIERO UN BOOL SI HAY O NO HAY INTERNET
    bool internet =  await checkInternetConnectivity();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //VERSION
    if(internet) {
        /////VERSION INTERNET
        Model = await apiVersion.get_VersionModel();

        await prefs.setString('versionAplicacionVigente',Model.versionAplicacionVigente!);
        await prefs.setInt('versionCondicion', Model.versionCondicion!);
        await prefs.setInt('versionOperador', Model.versionOperadores!);
        await prefs.setString('imei', _androidId);

        //CAMBIAR MODELO - ENTITY
        Version versionEntity = VersionMapper.instance.guardarVersion(Model);

        //SE OMITIRA SI ES LA PRIMERA VEZ
        int? contadorVersion = 0;
          contadorVersion = await _appDatabase.formDataModelDaoVersion.totalFormDataModels();
        if(contadorVersion!>0){
          ModelEntityVersion = await _appDatabase.formDataModelDaoVersion.SelectVersioNID(1);
          Version ModelEntityVersionSINGULAR = ModelEntityVersion[0];

          // GUARDAR EN BD SI versionAplicacionVigente ES MAYOR
          if( double.parse(Model.versionAplicacionVigente!) > double.parse(ModelEntityVersionSINGULAR.versionAplicacionVigente!)){
            //GUARDA LA VERSION ACTUAL MODELO QUE AHORA ES UNA ENTIDAD (SOBREESCRIBIRA PORQUE LE PUSE ID 1)
            _appDatabase.formDataModelDaoVersion.insertFormDataModel(versionEntity);
          } else {
            //NO TRABAJARA CON LA VERSION EN LA BD PORQUE AUNQUE SEA MAS ACTUAL ENGAÑARA CON QUE TIENE UNA VERSION MAS MODERNA AHORITA
            /*
            await prefs.setString('versionAplicacionVigente',ModelEntityVersionSINGULAR.versionAplicacionVigente!);
            await prefs.setInt('versionCondicion', int.parse(ModelEntityVersionSINGULAR.versionCondicion!));
            await prefs.setInt('versionOperador', int.parse(ModelEntityVersionSINGULAR.versionOperadores!));
             */
          }
        } else {
          //AL ESTAR LA BD VACIA GUARDA POR DEFAULT
          _appDatabase.formDataModelDaoVersion.insertFormDataModel(versionEntity);
        }



        ///////UBIGEO INTERNET
        ModelEntityUbigeo =  await apiVersion.post_Ubigeo(_androidId);

        //GUARDAR TODA LA LISTA
        if(ModelEntityUbigeo.length>0){

          //BORRAR TODA LA DATA EXISTENTE
          await _appDatabase.formDataModelDaoUbigeo.BorrarTodo();

          for (int i = 0; i < ModelEntityUbigeo.length; i++) {
            try {
              await _appDatabase.formDataModelDaoUbigeo.insertFormDataModel(ModelEntityUbigeo[i]);
            } catch (error) {
              print("Error saving Ubigeo: $error");
            }
          }


          int? cantidadA = await _appDatabase.formDataModelDaoUbigeo.totalFormDataModels();
          print(cantidadA);

          //PINTAR EL UT CONCATENADO
          List<String?> UTCONCATAUX;


            UTCONCATAUX = (await _appDatabase.formDataModelDaoUbigeo.TraerDepartamentos()) ?? [];
            print("TENGO LA LISTA");
            UTCONCAT = UTCONCATAUX.join(", ");


        } else {
          print("ALGO SALIO MAL");
        }




        /////SINCRONIZACIONES
        setState(() {
          versionPrintAplicacion = Model.versionAplicacionVigente!;
          PREFversionAplicacionVigente = prefs.getString('versionAplicacionVigente') ?? Model.versionAplicacionVigente!;
          PREF_androidId = prefs.getString('imei') ?? _androidId!;

          //CUANDO SALGA UBIGEO DESCOMENTAR
          //print("UTCONCAT: "+UTCONCAT!);
          //UTCONCAT = UTCONCATAUX;
          //print("UTCONCAT: "+UTCONCAT!);

        });


    } else {//NO HAY INTERNET
      //////VERSION NO INTERNET

      int? existeVersion = 0;
      existeVersion = await _appDatabase.formDataModelDaoVersion.totalFormDataModels();
      if(existeVersion! > 0){
        //CARGA LA BD YA HECHA SI EXISTE
         ModelEntityVersion = await _appDatabase.formDataModelDaoVersion.SelectVersioNID(1);
         Version ModelEntityVersionSINGULAR = ModelEntityVersion[0];
        await prefs.setString('versionAplicacionVigente',ModelEntityVersionSINGULAR.versionAplicacionVigente!);
        await prefs.setInt('versionCondicion', int.parse( ModelEntityVersionSINGULAR.versionCondicion!));
        await prefs.setInt('versionOperador',int.parse( ModelEntityVersionSINGULAR.versionOperadores!));
      } else {

      }

      //////UBIGEO NO INTERNET

      int? existeUbigeo= 0;
      existeUbigeo = await _appDatabase.formDataModelDaoUbigeo.totalFormDataModels();

      if(existeUbigeo! > 0){
        /*
        List<String?> UTCONCATAUX = await _appDatabase.formDataModelDaoUbigeo.TraerDepartamentos();
        setState(() {
          UTCONCAT = UTCONCATAUX.join(", ");
        });

         */

      } else {
        //DEBERIA MOSTRAR UN MENAJE DE ALER PERSONALIZADO
      }
      //////

      //IGUAL SINCRONIZA EL IMEI
      await prefs.setString('imei', _androidId);

      setState(() {
        versionPrintAplicacion = Model.versionAplicacionVigente!;
        PREFversionAplicacionVigente = prefs.getString('versionAplicacionVigente') ?? Model.versionAplicacionVigente!;
        PREF_androidId = prefs.getString('imei') ?? _androidId!;
      });


    }

    _mostrarLoadingStreamController.add(true);
  }



  Future<void> showModal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? counter = prefs.getInt('versionInstancia');
    print("PREFTIMEI es: " + _androidId);
    print("PREFversionAplicacionVigente: " + PREFversionAplicacionVigente);

    List ProductosLIST =  [
      ["IMEI del equipo", _androidId],
      ["Versión App Instalada", Model.versionInstancia],
      ["Versión App Vigente", Model.versionAplicacionVigente],
      ["Versión Operador", Model.versionOperadores],
      ["Versión Asistencia Tecnica", Model.versionAsistenciaTecnica],
      ["Versión Camapaña de Salud", Model.versionCampaniaSalud],
      ["Versión Ubigeo", Model.versionUbigeo],
      ["Versión Local Pago", Model.versionLocalPago],
      ["Versión Modalidad de Pago", Model.versionModalidadPago],
      ["Versión Punto de Pago", Model.versionPuntoPago],
      ["Versión Cronograma Punto de Pago", Model.versionCronogramaPago],
      ["Versión Cocina", Model.versionCocina],
      ["Versión Agua", Model.versionAgua],
      ["Versión Saneamiento", Model.versionSaneamiento],
      ["Versión Luz", Model.versionLuz],
      //["Versión Saberes Tipológia", Model.versionSab],
      ["Versión Saberes Tema", Model.versionSaberesTema],
      ["Versión Saberes Nivel", Model.versionSaberesNivel],
      ["Versión Saberes Grado", Model.versionSaberesGrado],
      ["Versión Tipo Discapacidad", Model.versionTipoDiscapacidad],
      ["Versión Tipo Discapacidad Saberes", Model.versionTipoDiscapacidadSaberes],
      ["Versión Tipo Campaña", Model.versionTipoCampania],
      ["Versión Charla Inclusión", Model.versionCharlaInclusion],
      ["Versión Charla Género", Model.versionCharlaGenero],
      ["Versión Instancia", Model.versionInstancia],
      ["Versión Tipo Victima", Model.versionTipoVictima],
      ["Versión Tipo Violencia ", Model.versionTipoViolencia],
      ["Versión Charla de Discapacidad", Model.versionCharlaDiscapacidad],
      ["Versión Charla de Salud", Model.versionCharlaSalud],
      ["Versión Otras Enfermedades", Model.versionOtrasEnfermedades],
      ["Versión Ultimo Control Salud", Model.versionUltimoControlSalud],
      ["Versión Próxima Cita Salud", Model.versionProximaCitaSalud],
      ["Versión Periodo Diagnóstico", Model.versionPeriodoDiagnostico],
      ["Versión Medicación Diabetes", Model.versionMedicacionDiabetes],
      ["Versión Medicación Hipertensión", Model.versionMedicacionHipertension],
      ["Versión Medicación Artritis", Model.versionMedicacionArtritis],
      ["Versión Diagnóstico Visual", Model.versionDiagnosticoVisual],
      ["Versión Diagnóstico Bucal", Model.versionDiagnosticoBucal]
    ];


    showDialog(
      context: context,
      builder: (BuildContext context) {
        //TALVEZ SIRVA TALVEZ NO
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title:
              Row(
                children: [
                  Image.asset(Resources.iconInfo, height: MediaQuery.of(context).size.height*0.04,),
                  SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                  const Text('Versiones :',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),

              content: SizedBox(
                width: 420,
                child: ListView.builder(
                    itemCount: ProductosLIST.length,
                    itemBuilder: (_, i) {
                      final String textValue = ProductosLIST[i][0] as String;
                      final String textValue2 = ProductosLIST[i][1].toString();
                      return  Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          child: Row(
                            children: [

                              Expanded(
                                child: Text(
                                  textValue+" : " + textValue2,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2, // Set the number of lines here
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),

            );
          },
        );
      },
    );

  }


  Widget formUI() {
    return Column(
      children: <Widget>[

        Align(
            alignment: Alignment.topCenter,
            child: Container(
              /*
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ), */
              margin: EdgeInsets.only(top: 10),
              child: Image.asset( Resources.loginlogo,
                width: 250,
                height: 60,),
            )),

        Align(
            alignment: Alignment.topCenter,
            child: Container(
              //margin: EdgeInsets.only(bottom: 20),
              child: Image.asset( Resources.tayta,
                width: 250,
                height: 100,),
            )),

        HelpersViewBlancoTexto.formItemsDesign(
          "Usuario",
          TextFormField(
            controller: widget.formUsuarioCtrl,
            //readOnly: true,
            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 20,
          ),
        ),

        HelpersViewBlancoTexto.formItemsDesign(
          "Clave",
          TextFormField(
            controller: widget.formClaveCtrl,
            //readOnly: true,
            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 20,
          ),
        ),

        GestureDetector(
            onTap: () {

              //PROCESO DE LOGEO

              /*
              if ( (widget.formUsuarioCtrl!.text.isEmpty) ||
              (widget.formClaveCtrl!.text.isEmpty) ) {
              showDialogValidFields("Faltan llenar campos");
              } else {

              }


              widget.formData?.placa =
              widget.formUsuarioCtrl!.text!.isEmpty
                  ? ""
                  : widget.formPlacaCtrl!.text;

              widget.formData?.galones =
              widget.formClaveCtrl!.text!.isEmpty
                  ? ""


               */
              //await save();
            },
            child: Container(
              margin: const EdgeInsets.all(30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Color(0xFFD60000),
                /*
                  gradient: const LinearGradient(colors: [
                      Color(0xFF0EDED2),
                    Color(0xFFD60000),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),

                   */
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: const Text("Ingresar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            )),

        Text("Versión ${versionPrintAplicacion}",
            style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold)),

        GestureDetector(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
              );

              //await save();
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Color(0xFFD60000),
                /*
                  gradient: const LinearGradient(colors: [
                      Color(0xFF0EDED2),
                    Color(0xFFD60000),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),

                   */
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: const Text("Ingreso Rápido",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ))


      ],
    );
  }


  displayDialog(String? title, String? msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: Text(msg!),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

