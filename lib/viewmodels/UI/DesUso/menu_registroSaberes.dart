import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpers.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';

import '../../../utils/helpersviewBlancoSelect.dart';

class MenuRegistroSaberes extends StatefulWidget {

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formDepartamentoCtrl = TextEditingController();
  TextEditingController formProvinciaCtrl = TextEditingController();
  TextEditingController formDistritoCtrl = TextEditingController();
  TextEditingController formFallecimientoDateCtrl = TextEditingController();
  TextEditingController formCodigoRegistroCtrl = TextEditingController();


  final ParamDepartamento = List.filled(3, "", growable: false);
  final ParamProvincia = List.filled(3, "", growable: false);
  final ParamDistrito = List.filled(3, "", growable: false);

  List<String> listDepart = ["Lima", "Cusco", "Junin"];
  List<String> listProvince = ["Lima", "Huaraz", "San Mateo"];
  List<String> listDistrict = ["Lima", "Chosica", "Vitarte"];
  
  @override
  State<StatefulWidget> createState() {
    return _MenuRegistroSaberes();
  }
}

class _MenuRegistroSaberes extends State<MenuRegistroSaberes> {

  late int PREFversionInstancia;
  late String PREFversionAplicacionVigente;
  late String PREFversionAplicacion;
  late int PREFversionCondicion;
  late int PREFversionOperador;
  late String PREFimei;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar:  HelpersViewCabecera.formItemsDesign(Resources.titulo_Registro_de_Saberes, context),
        //drawer: const MenuLateral(),
        body:  Center (
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
        ),),
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
                controller: widget.formFallecimientoDateCtrl,
                decoration: const InputDecoration(
                  labelText: 'Fecha del encuentro',
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

          HelpersViewLetrasRojas.formItemsDesign( "Ingresar Información Registro"),
          const SizedBox(height: 16.0),

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.code,
              TextFormField(
                controller: widget.formCodigoRegistroCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingresar codigo de Registro',
                ),
                //readOnly: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 6,
              ), context),

        ],
    );

  }

}