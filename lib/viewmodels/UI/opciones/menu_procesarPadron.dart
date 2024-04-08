import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tayta/infraestructure/dao/apis/apiprovider_padron.dart';
import 'package:tayta/infraestructure/dao/database/database.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_padron.dart';
import 'package:tayta/infraestructure/dao/model/JSON/padronModel.dart';
import 'package:tayta/model/t_padron.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpersviewBlancoDNI.dart';
import 'package:tayta/utils/helpersviewLetrasRojas.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/utils/helperviewCabecera.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class MenuProcesarPadron extends StatefulWidget {
  final _appDatabase = GetIt.I.get<AppDatabase>();
  apiprovider_padron apiVersion = apiprovider_padron();

  FormDataModelDaoPADRON get formDataModelDao => _appDatabase.formDataModelDaoPadron;

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formDNI = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return _MenuProcesarPadron();
  }
}

class _MenuProcesarPadron extends State<MenuProcesarPadron> {
  apiprovider_padron apiVersion = apiprovider_padron();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          title:  Text(Resources.titulo_Procesar_Padron, style: TextStyle(color: Colors.white),),
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
              icon: Image.asset(Resources.procesar),
              color: Colors.white,
              onPressed: () {

                HelpersViewCabecera.Guardar(context);

              },
            ),
          ],
        ),
        //drawer: const MenuLateral(),
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

  //MODAL
  Future<void> GuardarPadron() async {
    //DATA EN DURO
    padronModel? Model = padronModel();

    Padron InsertarPadronENTITY  = await apiVersion.get_padron();
    print('padronModel: ${InsertarPadronENTITY.padronDni}');

    /*
    InsertarPadron?.padronDni = Model.padronDni;
    InsertarPadron?.padronPaterno=  Model.padronPaterno;
    InsertarPadron?.padronMaterno=  Model.padronMaterno;
    InsertarPadron?.padronNombres=  Model.padronNombres;
    InsertarPadron?.padronsexo=  Model.padronsexo;
    InsertarPadron?.padronFechaNacimiento=  Model.padronFechaNacimiento;
    InsertarPadron?.padronUbigeo=  Model.padronUbigeo;
    InsertarPadron?.padronDepartamento=  Model.padronDepartamento;
    InsertarPadron?.padronProvincia=  Model.padronProvincia;
    InsertarPadron?.padronDistrito=  Model.padronDistrito;
    InsertarPadron?.padronSDireccion=  Model.padronSDireccion;
    InsertarPadron?.padronCentroPoblado=  Model.padronCentroPoblado;
    InsertarPadron?.padronLatitud=  Model.padronLatitud;
    InsertarPadron?.padronLongitud=  Model.padronLongitud;
    InsertarPadron?.padronPerope=  Model.padronPerope;
    InsertarPadron?.padronEdad=  Model.padronEdad;
    InsertarPadron?.flagPlanTrabajo=  Model.flagPlanTrabajo;
    InsertarPadron?.padronDDireccion=  Model.padronDDireccion;
    InsertarPadron?.padronDireccionP65=  Model.padronDireccionP65;
    InsertarPadron?.padronCodigoTipoCondicion=  Model.padronCodigoTipoCondicion;
    InsertarPadron?.padronDescripcionCondicion=  Model.padronDescripcionCondicion;
    InsertarPadron?.padronFechaVisita=  Model.padronFechaVisita;
    InsertarPadron?.padronUsuario=  Model.padronUsuario;
    InsertarPadron?.padronPrioridad=  Model.padronPrioridad;
    InsertarPadron?.padronContactoTelefonico=  Model.padronContactoTelefonico;
    InsertarPadron?.padronPersonaContacto=  Model.padronPersonaContacto;
  */

    await widget.formDataModelDao.insertFormDataModel(InsertarPadronENTITY);



    /*
    List<padronModel> Model = padronModel();
    Model = await apiVersion.get_padron();
    print(Model); */

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
                  const Text('GUARDADO PADRON',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
              /*
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
              */
            );
          },
        );
      },
    );

  }


    Widget formUI() {
    return  Column(
        children: <Widget>[


          GestureDetector(
              onTap: () async {
                GuardarPadron();
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: const Color(0xFFD60000),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text("BUSCAR ONLINE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),




          const SizedBox(height: 16.0),
          HelpersViewLetrasRojas.formItemsDesign( "Archivo Seleccionado"),
          const SizedBox(height: 16.0),
          HelpersViewLetrasRojas.formItemsDesign( "Total Registros"),
          const SizedBox(height: 16.0),
        ],
    );

    }

  }