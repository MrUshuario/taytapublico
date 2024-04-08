import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewCamera.dart';
import 'package:tayta/utils/helpersviewTextSize.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';

class MenuEncuentroMagico extends StatefulWidget {

  //CAMARA
  String? mediaPath;

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formTituloCtrl = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return _MenuEncuentroMagico();
  }
}

class _MenuEncuentroMagico extends State<MenuEncuentroMagico> {

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
        appBar:  HelpersViewCabecera.formItemsDesign(Resources.titulo_Encuentro_Magico, context),
        //drawer: const MenuLateral(),
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
        ),),
    );

  }


  Widget formUI() {
    return  Column(
        children: <Widget>[

          HelpersViewBlancoIcon.formItemsDesign(
              Icons.label,
              TextFormField(
                controller: widget.formTituloCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingresar Título',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 8,
              ), context),

          HelpersViewTextSize.formItemsDesign(
              TextFormField(
                //controller: widget.formEntidadCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ingresar Comentario',
                ),
                //readOnly: true,
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 500,
                maxLines: 5,
              ), context),

          const Divider(),

          HelpersViewCamera.formItemsDesign(widget.mediaPath, context, "Foto 1"),
          HelpersViewCamera.formItemsDesign(widget.mediaPath, context, "Foto 2"),
          HelpersViewCamera.formItemsDesign(widget.mediaPath, context, "Foto 3"),

        ],
    );

  }

}