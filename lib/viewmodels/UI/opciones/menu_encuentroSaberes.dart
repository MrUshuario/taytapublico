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
import '../../../utils/helpersviewBlancoSelect.dart';
import '../../../utils/helpersviewLetrasSubs.dart';

class MenuEncuentroSaberes extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formDepartamentoCtrl = TextEditingController();
  TextEditingController formProvinciaCtrl = TextEditingController();
  TextEditingController formDistritoCtrl = TextEditingController();
  TextEditingController formFechaCtrl = TextEditingController();
  TextEditingController formURLReunionCtrl = TextEditingController();

  TextEditingController formNombreEncuentroCtrl = TextEditingController();
  TextEditingController formSaberesEncuentroCtrl = TextEditingController();
  TextEditingController formAutoridadesEncuentroCtrl = TextEditingController();
  TextEditingController formDistritosEncuentroCtrl = TextEditingController();
  TextEditingController formEntidadesEncuentroCtrl = TextEditingController();
  TextEditingController formUsuariosEncuentroCtrl = TextEditingController();
  TextEditingController formUsuariasEncuentroCtrl = TextEditingController();
  TextEditingController formUsuariosProductosCtrl = TextEditingController();
  TextEditingController formUsuariasProductosCtrl = TextEditingController();
  TextEditingController formProductosVentasCtrl = TextEditingController();


  String imageSource = Resources.sateliterojo;
  Visitas? formData;
  MenuEncuentroSaberes(this.formData, {super.key});



  final ParamDepartamento = List.filled(3, "", growable: false);
  final ParamProvincia = List.filled(3, "", growable: false);
  final ParamDistrito = List.filled(3, "", growable: false);

  List<String> listDepart = ["Lima", "Cusco", "Junin"];
  List<String> listProvince = ["Lima", "Huaraz", "San Mateo"];
  List<String> listDistrict = ["Lima", "Chosica", "Vitarte"];



  @override
  State<StatefulWidget> createState() {
    return _MenuEncuentroSaberes();
  }
}

///RADION BUTTON
enum TipoEncuentro { Presencial, Virtual, Mixto }
enum ProductosOfrecidos { No, Si }
bool MixtoVirtual = false;



class _MenuEncuentroSaberes extends State<MenuEncuentroSaberes> {

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

      //widget.formData != null permite que el radio button sea opcional
      if (widget.formData != null && widget.formData!.codigoSaberesGrado != null) {
        setState(() {
          _ProductosOfrecidos = widget.formData!.codigoSaberesGrado == 0
              ? ProductosOfrecidos.No
              : ProductosOfrecidos.Si;
        });
      }


      if (widget.formData != null && widget.formData!.codigoModular! != "") {
        setState(() {
          if(widget.formData!.codigoModular == "M"){
            _TipoEncuentro = TipoEncuentro.Mixto;
          }
          if(widget.formData!.codigoModular == "P"){
            _TipoEncuentro = TipoEncuentro.Presencial;
          }
          if(widget.formData!.codigoModular == "V"){
            _TipoEncuentro = TipoEncuentro.Virtual;
          }
        });
      }

      if (widget.formData!.fechaEncuentro!.isNotEmpty) {
        setState(() {
          widget.formFechaCtrl!.text = widget.formData!.fechaEncuentro!;
        });
      }

      if (widget.formData!.observacion!.isNotEmpty) {
        setState(() {
          widget.formURLReunionCtrl!.text = widget.formData!.observacion!;
        });
      }

      if (widget.formData!.nombres!.isNotEmpty) {
        setState(() {
          widget.formNombreEncuentroCtrl!.text = widget.formData!.nombres!;
        });
      }

      if (widget.formData!.saberEspecifico!.isNotEmpty) {
        setState(() {
          widget.formSaberesEncuentroCtrl!.text = widget.formData!.saberEspecifico!;
        });
      }

      if (widget.formData!.puntoFocal!.isNotEmpty) {
        setState(() {
          widget.formAutoridadesEncuentroCtrl!.text = widget.formData!.puntoFocal!;
        });
      }

      if (widget.formData!.apepat!.isNotEmpty) {
        setState(() {
          widget.formDistritosEncuentroCtrl!.text = widget.formData!.apepat!;
        });
      }

      if (widget.formData!.apemat!.isNotEmpty) {
        setState(() {
          widget.formEntidadesEncuentroCtrl!.text = widget.formData!.apemat!;
        });
      }

      if (widget.formData!.nroNinos! != 0) {
        setState(() {
          widget.formUsuariosEncuentroCtrl!.text = widget.formData!.nroNinos!.toString();
        });
      }

      if (widget.formData!.nroNinas! != 0) {
        setState(() {
          widget.formUsuariasEncuentroCtrl!.text = widget.formData!.nroNinas!.toString();
        });
      }

      if (widget.formData!.codigoSaberesTema! != 0) {
        setState(() {
          widget.formUsuariosProductosCtrl!.text = widget.formData!.codigoSaberesTema!.toString();
        });
      }

      if (widget.formData!.codigoSaberesNivel! != 0) {
        setState(() {
          widget.formUsuariasProductosCtrl!.text = widget.formData!.codigoSaberesNivel!.toString();
        });
      }


    }








    super.initState();
    conseguirVersion();
  }

  bool isSatelliteGreen=false;

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

  TipoEncuentro? _TipoEncuentro = null;
  ProductosOfrecidos? _ProductosOfrecidos = null;

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
        Resources.valor_Encuentro_de_Saberes;

    //RADIO BUTTON
    if(_TipoEncuentro == TipoEncuentro.Mixto) {
      widget.formData?.codigoModular = "M";

      //OBSERVACION ES EL URL MEET
      widget.formData?.observacion =
      widget.formURLReunionCtrl!.text!.isEmpty
          ? ""
          : widget.formURLReunionCtrl!.text;

    }
    if(_TipoEncuentro == TipoEncuentro.Presencial) {
      widget.formData?.codigoModular = "P";

      //OBSERVACION ES EL URL MEET PRESENCIAL NO HAY
      widget.formData?.observacion = "";

    }
    if(_TipoEncuentro == TipoEncuentro.Virtual) {
      widget.formData?.codigoModular = "V";

      //OBSERVACION ES EL URL MEET
      widget.formData?.observacion =
      widget.formURLReunionCtrl!.text!.isEmpty
          ? ""
          : widget.formURLReunionCtrl!.text;

    }

    widget.formData?.codigoSaberesGrado =
        _ProductosOfrecidos?.index; //NO 0 //SI 1

    //CODIGO MODULAR
    widget.formData?.fechaEncuentro =
    widget.formFechaCtrl!.text!.isEmpty
        ? ""
        : widget.formFechaCtrl!.text;



    widget.formData?.nombres =
    widget.formNombreEncuentroCtrl!.text!.isEmpty
        ? ""
        : widget.formNombreEncuentroCtrl!.text;

    widget.formData?.saberEspecifico =
    widget.formSaberesEncuentroCtrl!.text!.isEmpty
        ? ""
        : widget.formSaberesEncuentroCtrl!.text;

    widget.formData?.puntoFocal =
    widget.formAutoridadesEncuentroCtrl!.text!.isEmpty
        ? ""
        : widget.formAutoridadesEncuentroCtrl!.text;

    //DISTRISO DE ENCUENTRO LO GRABAN EN APELLIDO PATERNO
    widget.formData?.apepat =
    widget.formDistritosEncuentroCtrl!.text!.isEmpty
        ? ""
        : widget.formDistritosEncuentroCtrl!.text;

    //ENTIDADES ENCUENTRO LO GRABAN EN APLLEIDO MATERNO
    widget.formData?.apemat =
    widget.formEntidadesEncuentroCtrl!.text!.isEmpty
        ? ""
        : widget.formEntidadesEncuentroCtrl!.text;


    widget.formData?.nroNinos =
    widget.formUsuariosEncuentroCtrl!.text!.isEmpty
        ? 0
        : int.parse(widget.formUsuariosEncuentroCtrl!.text);

    widget.formData?.nroNinas =
    widget.formUsuariasEncuentroCtrl!.text!.isEmpty
        ? 0
        : int.parse(widget.formUsuariasEncuentroCtrl!.text);

    //USUARIOS PRODUCTOS
    widget.formData?.codigoSaberesTema =
    widget.formUsuariosProductosCtrl!.text!.isEmpty
        ? 0
        : int.parse(widget.formUsuariosProductosCtrl!.text);

    //USUARIAS PRODUCTOS
    widget.formData?.codigoSaberesNivel =
    widget.formUsuariasProductosCtrl!.text!.isEmpty
        ? 0
        : int.parse(widget.formUsuariasProductosCtrl!.text);

    /*        List<SaberesProductivosDetalle> detalle = new ArrayList<SaberesProductivosDetalle>();
    ESTE VA PARA UN ARRAY O ALGO ASI

    widget.formData?.placa =
    widget.formProductosVentasCtrl!.text!.isEmpty
        ? ""
        : widget.formProductosVentasCtrl!.text;

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
          title: const Text(
            Resources.titulo_Encuentro_de_Saberes,
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

                //PONER DATOS
                print("GPSlatitude:"+GPSlongitude);
                if (isEnableServiceLocation && isHasPermissionLocation && isHasPermissionDevice && (GPSlongitude != "")) {
                  if (widget.formNombreEncuentroCtrl==null && widget.formNombreEncuentroCtrl!.text.isEmpty) {
                    HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                  } else {
                    CargaDialog(); //INICIALIZA DIALOGO

                    widget.formData?.codigoOperador =
                    "PENSION";

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
                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP", context);}
              },
            ),
            IconButton(
              icon: Image.asset(
                isSatelliteGreen ? Resources.sateliteverde : Resources.sateliterojo,
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
    widget.formNombreEncuentroCtrl!.clear();
    widget.formData = Visitas();
    setState(() {});
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
                controller: widget.formFechaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Fecha del encuentro',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 1095)),
                  );
                  if (pickedDate != null) {
                    widget.formFechaCtrl.text =
                        Helpers.formatDate('dd/MM/yyyy', pickedDate);
                  }
                },onSaved: (newValue) {
                widget.formFechaCtrl.text =
                    Helpers.formatDate('dd/MM/yyyy', new DateFormat("dd/MM/yyyy").parse(newValue!));
              },
                keyboardType: TextInputType.none,
              ), context),

          HelpersViewLetrasRojas.formItemsDesign( "Tipo de Encuentro"),
          const SizedBox(height: 16.0),


          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
            children: [
              const SizedBox(width: 0.0), // Create left padding


              Row(
                children: [
                  Text('Presencial', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 00.0), // Add spacing between text and radio
                  Radio<TipoEncuentro>(
                    value: TipoEncuentro.Presencial,
                    groupValue: _TipoEncuentro,
                    onChanged: (TipoEncuentro? value) {
                      setState(() {
                        _TipoEncuentro = value;
                        MixtoVirtual = false;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  Text('Virtual', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 0.0), // Add spacing between text and radio
                  Radio<TipoEncuentro>(
                    value: TipoEncuentro.Virtual,
                    groupValue: _TipoEncuentro,
                    onChanged: (TipoEncuentro? value) {
                      setState(() {
                        _TipoEncuentro = value;
                        MixtoVirtual = true;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  Text('Mixto', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 0.0), // Add spacing between text and radio
                  Radio<TipoEncuentro>(
                    value: TipoEncuentro.Mixto,
                    groupValue: _TipoEncuentro,
                    onChanged: (TipoEncuentro? value) {
                      setState(() {
                        _TipoEncuentro = value;
                        MixtoVirtual = true;
                      });
                    },
                  ),
                ],
              ),

            ],
          ),

        Visibility(
        visible: (MixtoVirtual),
        child:
          HelpersViewBlancoIcon.formItemsDesign(
              Icons.meeting_room,
              TextFormField(
                controller: widget.formURLReunionCtrl,
                decoration: const InputDecoration(
                  labelText: 'https://meet.google.com/...',
                ),
                maxLength: 150,
              ), context), ),

          HelpersViewLetrasRojas.formItemsDesign( "Datos del encuentro"),
          const SizedBox(height: 16.0),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.meeting_room,
              TextFormField(
                controller: widget.formNombreEncuentroCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Encuentro',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 100,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.co_present,
              TextFormField(
                controller: widget.formSaberesEncuentroCtrl,
                decoration: const InputDecoration(
                  labelText: 'Saberes Presentados',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 100,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.local_police_outlined,
              TextFormField(
                controller: widget.formAutoridadesEncuentroCtrl,
                decoration: const InputDecoration(
                  labelText: 'Principales autoridades Participan',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 100,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.location_city,
              TextFormField(
                controller: widget.formDistritosEncuentroCtrl,
                decoration: const InputDecoration(
                  labelText: 'Distritos Participantes',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 100,
              ), context),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.smart_display,
              TextFormField(
                controller: widget.formEntidadesEncuentroCtrl,
                decoration: const InputDecoration(
                  labelText: 'Entidad Organizadora',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 100,
              ), context),

          HelpersViewLetrasSubs.formItemsDesign( "Cantidad: Usuarios que muestran su saber"),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.male,
              TextFormField(
                controller: widget.formUsuariosEncuentroCtrl,
                decoration: const InputDecoration(
                  labelText: 'Usuarios que muestran su Saber',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 3,
              ), context),

          HelpersViewLetrasSubs.formItemsDesign( "Cantidad: Usuarias que muestran su saber"),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.female,
              TextFormField(
                controller: widget.formUsuariasEncuentroCtrl,
                decoration: const InputDecoration(
                  labelText: 'Usuarias que muestran su Saber',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 3,
              ), context),

          const SizedBox(height: 16.0),
          HelpersViewLetrasRojas.formItemsDesign( "Datos de los productos"),
          const SizedBox(height: 16.0),

          HelpersViewLetrasSubs.formItemsDesign( "Cantidad: Usuarios que llevan productos a la venta"),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.male,
              TextFormField(
                controller: widget.formUsuariosProductosCtrl,
                decoration: const InputDecoration(
                  labelText: 'Llevan productos (Usuarios)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 3,
              ), context),

          HelpersViewLetrasSubs.formItemsDesign( "Cantidad: Usuarias que llevan productos a la venta"),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.female,
              TextFormField(
                controller: widget.formUsuariasProductosCtrl,
                decoration: const InputDecoration(
                  labelText: 'Llevan productos (Usuarias)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 3,
              ), context),

          const SizedBox(height: 16.0),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.paste_rounded,
              TextFormField(
                controller: widget.formProductosVentasCtrl,
                decoration: const InputDecoration(
                  labelText: 'Productos para la venta',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 100,
              ), context),

          HelpersViewLetrasSubs.formItemsDesign( "¿Logro Vender los productos ofrecidos?"),

          //RADIO BUTTOn
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
            children: [

              Row(
                children: [
                  Text('Sí', style: const TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),
                  const SizedBox(width: 00.0), // Add spacing between text and radio
                  Radio<ProductosOfrecidos>(
                    value: ProductosOfrecidos.Si,
                    groupValue: _ProductosOfrecidos,
                    onChanged: (ProductosOfrecidos? value) {
                      setState(() {
                        _ProductosOfrecidos = value;
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
                  Radio<ProductosOfrecidos>(
                    value: ProductosOfrecidos.No,
                    groupValue: _ProductosOfrecidos,
                    onChanged: (ProductosOfrecidos? value) {
                      setState(() {
                        _ProductosOfrecidos = value;
                      });
                    },
                  ),
                ],
              ),


            ],
          ),

        ],
    );

  }

}