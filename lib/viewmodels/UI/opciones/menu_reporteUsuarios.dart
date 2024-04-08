import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tayta/infraestructure/dao/database/database.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_padron.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpersviewAlertMensajeFOTO.dart';
import 'package:tayta/utils/helpersviewBlancoDNI.dart';
import 'package:tayta/utils/helpersviewBlancoIcon.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';
import 'package:tayta/viewmodels/UI/viewmodels/form_viewsmodel_reporteUsuarios.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/t_padron.dart';
import '../../../utils/helpersviewBlancoSelect.dart';

class MenuReporteUsuarios extends StatefulWidget {
  final viewModel = FormDataModelViewModel();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoPADRON get formDataModelDao => _appDatabase.formDataModelDaoPadron;
  int? total = 0;

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formDNICtrl = TextEditingController();
  TextEditingController formDepartamentoCtrl = TextEditingController();
  TextEditingController formProvinciaCtrl = TextEditingController();
  TextEditingController formDistritoCtrl = TextEditingController();
  TextEditingController formCentroPobladoCtrl = TextEditingController();
  TextEditingController formCampana = TextEditingController();
  TextEditingController formFechaAtencion = TextEditingController();
  TextEditingController formUsuariosAtendidos = TextEditingController();

  final ParamDepartamento = List.filled(3, "", growable: false);
  final ParamProvincia = List.filled(3, "", growable: false);
  final ParamDistrito = List.filled(3, "", growable: false);

  List<String> listDepart = ["Lima", "Cusco", "Junin"];
  List<String> listProvince = ["Lima", "Huaraz", "San Mateo"];
  List<String> listDistrict = ["Lima", "Chosica", "Vitarte"];

  MenuReporteUsuarios({Key? key});

  @override
  State<StatefulWidget> createState() {
    return _MenuReporteUsuarios();
  }
}
//TIENE UNA CABECERA DISTINTA
class _MenuReporteUsuarios extends State<MenuReporteUsuarios> {


  @override
  void initState() {
    widget.viewModel
      ..listen()
      ..getPaginationList();
    loadTotalRegister();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  Future<void> loadTotalRegister() async {
    var res = await widget.formDataModelDao.totalFormDataModels();
    setState(() {
      widget.total = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          title:  Text(Resources.titulo_Reporte_Usuarios, style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFFD60000),
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
              icon: Image.asset(Resources.portafolio),
              color: Colors.white,
              onPressed: () {


              },
            ),
            IconButton(
              icon: Image.asset(Resources.ubicacion),
              color: Colors.white,
              onPressed: () {


              },
            ),
            IconButton(
              icon: Image.asset(Resources.refrescar),
              color: Colors.white,
              onPressed: () {


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


  void ModificarBorrar(int index, String? fecha, String? latitud, String? longitud) {

    String url = "https://www.google.com/maps/search/?q=${latitud},${longitud}";

    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeFOTO.formItemsDesign("${index + 1})  ${fecha} \n","¿Que acción desea realizar?"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Align row to the end
                        children: [
                          Spacer(), // Push remaining space to the left

                          InkWell(
                            onTap: () async {

                              /*
                              String url = "https://www.google.com/maps/search/?q=${latitud},${longitud}";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }

                              */

                              final Uri urlMAp = Uri.parse(url);
                              if (!await launchUrl(urlMAp)) {
                                throw Exception('Could not launch $urlMAp');
                              }

                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "GPS",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: ()   {

                              widget.viewModel.deleteItem(index);

                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Borrar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: ()   {
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
    return Container(
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
        children: <Widget>[

          HelpersViewLetrasRojas.formItemsDesign("Reporte de Usuarios"),

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

          Container(
            margin: EdgeInsets.only(left: 20.0, top: MediaQuery.of(context).size.height * 0.020, bottom: MediaQuery.of(context).size.height * 0.020),
            alignment: Alignment.centerLeft,
            child: Text(
              "Total de Registros: ${widget.total}",
              textAlign: TextAlign.left,
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // Center horizontally
              children: [
                Image.asset(Resources.inconflechaD, width: 48, height: 48),
                const Text(
                  "0/1", //DEBO PONER EL TOTAL ENTRE 1
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                Image.asset(Resources.inconflechaI, width: 48, height: 48),
                // Add Textfield with appropriate margin
              ],
            ),
          ),


          /*
          Unhandled Exception: Bad state: Stream has already been listened to.
           */

          //Expanded( child: SizedBox(
            SizedBox(
              width: double.infinity, // Fills available space horizontally
              height: 275, // Set your desired height
            child: AnimatedInfiniteScrollView<Padron>(
              viewModel: widget.viewModel,
              itemBuilder: (context, index, item) => Card(
                child: InkWell(
                  onTap: () {
                    //ModificarBorrar(index, item.padronFechaNacimiento, getItemDescription(item.padronCodigoTipoCondicion) );
                    ModificarBorrar(index, item.padronFechaNacimiento, item.padronLatitud, item.padronLongitud);
                  },
                  child: ListTile(
                    title: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.040,
                      child: Text(
                        "${index + 1}.- ${item.padronDni}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fecha de Registro: ${item.padronFechaNacimiento}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.040,
                        ),
                        Text(
                          "Dirección: ${item.padronDDireccion}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              refreshIndicator: true,
            ),
          //),
          ),

        ],
    ),
    );
  }

}