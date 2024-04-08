import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpersviewBlancoDNI.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewCamera.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/helpersviewTextSize.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';

import '../../../infraestructure/dao/database/database.dart';
import '../../../infraestructure/dao/formdatamodeldao_visita.dart';
import '../../../model/t_visita.dart';
import '../../../utils/camera.dart';
import '../../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../../utils/helpersviewBlancoSelect.dart';
import '../../../utils/viewdisplayfoto.dart';

class MenuAsistenciaTecnica extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;
  bool? isShowButtonCameraInitial = true;
  String imageSource = Resources.sateliterojo;
  Visitas? formData;
  List<XFile>? listMediaPath;
  String title = Resources.titulo_Asistencia_Tecnica;

  //CAMARA
  String? mediaPath;

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formDepartamentoCtrl = TextEditingController();
  TextEditingController formProvinciaCtrl = TextEditingController();
  TextEditingController formDistritoCtrl = TextEditingController();
  TextEditingController formCentroPobladoCtrl = TextEditingController();
  TextEditingController formAsistenciaTecnicaCtrl = TextEditingController();
  TextEditingController formTipoAsistenciaTecnicaCtrl = TextEditingController();
  TextEditingController formEntidadCtrl = TextEditingController();
  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formApellidoPaternoCtrl = TextEditingController();
  TextEditingController formApellidoMaternoCtrl = TextEditingController();
  TextEditingController formNombresCtrl = TextEditingController();
  TextEditingController formSexoCtrl = TextEditingController();
  TextEditingController formNCargoCtrl = TextEditingController();
  TextEditingController formNObservacionesCtrl = TextEditingController();

  TextEditingController? formUsuarioCtrl = TextEditingController();



  final ParamDepartamento = List.filled(3, "", growable: false);
  final ParamProvincia = List.filled(3, "", growable: false);
  final ParamDistrito = List.filled(3, "", growable: false);
  final ParamCentroPoblado = List.filled(3, "", growable: false);

  final ParamAsistencia = List.filled(3, "", growable: false);
  final ParamTipoAsistencia = List.filled(3, "", growable: false);


  List<String> listDepart = ["Lima", "Cusco", "Junin"];
  List<String> listProvince = ["Lima", "Huaraz", "San Mateo"];
  List<String> listDistrict = ["Lima", "Chosica", "Vitarte"];
  List<String> listCentroPoblado = ["Lima", "Chosica", "Vitarte"];
  //final nameLastNameParamValidateForm = List.filled(3, "", growable: false);

  List<String> listSelectAsistencia = [
    "Presentacion de la intervencion",
    "Institucionalizacion de la intervencion",
    "Dialgoos de Saberes Productivos",
    "Elaboración de fichas de saberes y portadores de saberes",
    "Contextualizacion de saberes",
    "Actividades de trnasmision Intergeneracional",
    "Revitalizacion de lenguas",
    "Encuentro de Saberes Productivos",
    "Emprendimientos Productivos",
    "Comercializacion",
    "Presentacion a concursos",
    "Participacion en el Sello Municipal",
    "Otros",
  ];

  List<String> listSelectTipoAsistencia = [
    "Presencial",
    "Virtual",
  ];

  MenuAsistenciaTecnica(this.listMediaPath, this.formData, {super.key});


  @override
  State<StatefulWidget> createState() {
   return _MenuAsistenciaTecnica();
  }
}


enum Recorrido { Inicio, Fin }
enum EstadoActividad { Inicio, Fin }



class _MenuAsistenciaTecnica extends State<MenuAsistenciaTecnica> {

  late int PREFversionInstancia;
  late String PREFversionAplicacionVigente;
  late String PREFversionAplicacion;
  late int PREFversionCondicion;
  late int PREFversionOperador;
  late String PREFimei;

  Future<void> conseguirVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      PREFversionAplicacionVigente = prefs.getString('versionAplicacionVigente') ?? "aa";
      PREFversionCondicion = prefs.getInt('versionCondicion') ?? 2000;
      PREFversionOperador = prefs.getInt('versionOperador') ?? 3000;
      PREFimei = prefs.getString('imei') ?? "cc";
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

    //
    widget.ParamDepartamento[1] = "Obligatorio";
    widget.ParamDepartamento[2] = "Formato incorrecto. [a-z] y [A-Z]";

    widget.ParamProvincia[1] = "Obligatorio";
    widget.ParamProvincia[2] = "Formato incorrecto. [a-z] y [A-Z]";

    widget.ParamDistrito[1] = "Obligatorio";
    widget.ParamDistrito[2] = "Formato incorrecto. [a-z] y [A-Z]";

    widget.ParamCentroPoblado[1] = "Obligatorio";
    widget.ParamCentroPoblado[2] = "Formato incorrecto. [a-z] y [A-Z]";

    conseguirVersion();

  }

  //RADION BUTTOn
  Recorrido? _Recorrido = null;
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar:  HelpersViewCabecera.formItemsDesign(Resources.titulo_Asistencia_Tecnica, context),
        //drawer: const MenuLateral(),
        body: Center (
        child: SingleChildScrollView(
          child: Container(
            width: 420,
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
    widget.listMediaPath!.clear();
    _EstadoActividad = EstadoActividad.Inicio;
    widget.formUsuarioCtrl!.clear();
    widget.isShowButtonCameraInitial = true;
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
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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

        //CENTRO POBLADO
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
                  widget.ParamDistrito),
              isDense: true,
              isExpanded: true,
              hint: const Text("Centro Poblado"),
              //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formCentroPobladoCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formCentroPobladoCtrl.text))
            )
            ),


        const SizedBox(height: 16.0), // Add margin between text fields
        HelpersViewLetrasRojas.formItemsDesign( "Datos de la Asistencia Técnica"),
        const SizedBox(height: 16.0),

        HelpersViewBlancoSelect.formItemsDesign(

            DropdownButtonFormField(
              items: widget.listSelectAsistencia.map((dep) {
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
                widget.formAsistenciaTecnicaCtrl.text = value!.isEmpty || value == null ? "" : value!;
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
                  widget.formAsistenciaTecnicaCtrl.text!,
                  widget.ParamAsistencia),
              isDense: true,
              isExpanded: true,
              hint: const Text("Seleccione Asistencia Técnica"),
              //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formAsistenciaTecnicaCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formAsistenciaTecnicaCtrl.text))
            )
            ),

        const SizedBox(height: 16.0), // Add margin between text fields
        HelpersViewLetrasRojas.formItemsDesign( "Tipo de Asistencia"),
        const SizedBox(height: 16.0),

        HelpersViewBlancoSelect.formItemsDesign(
            DropdownButtonFormField(
              items: widget.listSelectTipoAsistencia.map((dep) {
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
                widget.formTipoAsistenciaTecnicaCtrl.text = value!.isEmpty || value == null ? "" : value!;
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
                  widget.formTipoAsistenciaTecnicaCtrl.text!,
                  widget.ParamTipoAsistencia),
              isDense: true,
              isExpanded: true,
              hint: const Text("Seleccione Tipo de Asistencia Técnica"),
              //value: widget.listDepart.elementAt(widget.listDepart.indexOf(widget.formTipoAsistenciaTecnicaCtrl.text) == -1 ? 0 : widget.listDepart.indexOf(widget.formTipoAsistenciaTecnicaCtrl.text))
            )
            ),

        HelpersViewBlancoIcon.formItemsDesign(
            Icons.add_box,
            TextFormField(
              controller: widget.formEntidadCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingresar Entidad',
              ),
              //keyboardType: TextInputType.number,
              //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 8,
            ), context),

        const SizedBox(height: 16.0), // Add margin between text fields
        HelpersViewLetrasRojas.formItemsDesign( "Datos de la persona asistida"),
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
                    labelStyle: const TextStyle(fontSize: 14.0),
                    isDense: true,
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
              controller: widget.formApellidoPaternoCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingresar apellido paterno',
              ),
              //readOnly: true,
              //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 8,
            ), context),

        HelpersViewBlancoIcon.formItemsDesign(
            Icons.person,
            TextFormField(
              controller: widget.formApellidoMaternoCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingresar apellido materno',
              ),
              //readOnly: true,
              //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 8,
            ), context),

        HelpersViewBlancoIcon.formItemsDesign(
            Icons.person,
            TextFormField(
              controller: widget.formNombresCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingresar nombres',
              ),
              //readOnly: true,
              //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 8,
            ), context),

        HelpersViewBlancoIcon.formItemsDesign(
            Icons.group,
            TextFormField(
              controller: widget.formSexoCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingresar sexo',
              ),
              //readOnly: true,
              //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 8,
            ), context),

        HelpersViewBlancoIcon.formItemsDesign(
            Icons.work,
            TextFormField(
              controller: widget.formNCargoCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingresar cargo',
              ),
              //readOnly: true,
              //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 8,
            ), context),

        HelpersViewTextSize.formItemsDesign(
            TextFormField(
              controller: widget.formNObservacionesCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingresar Observaciones',
              ),
              //readOnly: true,
              //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 255,
              maxLines: 5,
            ), context),

        const SizedBox(height: 16.0),

        Visibility(
          visible: widget.isShowButtonCameraInitial!,
          child: GestureDetector(
            onTap: () {
              widget.formData?.recorrido = _EstadoActividad!.index;
              widget.formData?.observacion =
              widget.formUsuarioCtrl!.text!.isEmpty
                ? ""
                : widget.formUsuarioCtrl!.text;
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
                            onTap: () {
                              widget.formData?.recorrido =
                                  _EstadoActividad!.index;
                              widget.formData?.observacion =
                              widget.formUsuarioCtrl!.text!.isEmpty
                                ? ""
                                : widget.formUsuarioCtrl!.text;
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
                            onTap: () {
                              if (widget.listMediaPath!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                        Text("No hay fotos para mostrar")));
                          } else {
                            print("path:${widget.listMediaPath![0]}");
                            widget.formData?.recorrido =
                                _EstadoActividad!.index;
                            widget.formData?.observacion =
                            widget.formUsuarioCtrl!.text!.isEmpty
                                ? ""
                                : widget.formUsuarioCtrl!.text;
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
        
        )
      ),
    ]
  );
}

}
