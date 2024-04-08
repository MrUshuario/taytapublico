import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tayta/infraestructure/dao/apis/apiprovider_menuOpciones.dart';
import 'package:tayta/main.dart';
import 'package:tayta/model/Visita_MODEL.dart';
import 'package:tayta/model/t_visita.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/helpersviewAlertMensajeFOTO.dart';
import 'package:tayta/utils/helpersviewAlertProgressCircle.dart';
import 'package:tayta/utils/helpersviewAlertProgressSinc.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/viewmodels/UI/DesUso/menu_asistenciaTecnica.dart';
import 'package:tayta/viewmodels/UI/menu_login.dart';
import 'package:tayta/viewmodels/UI/menu_progreso.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_bitacora.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_campanaSalud.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_contactoReferencia.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_dialogoSaberes.dart';
import 'package:tayta/viewmodels/UI/DesUso/menu_encuentroMagico.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_encuentroSaberes.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_inicio_fin.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_procesarPadron.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_puntoPago.dart';
import 'package:tayta/viewmodels/UI/DesUso/menu_registroSaberes.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_reporteConsolidado.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_reporteUsuarios.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_casosViolencia.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_tarjetizacionCapacitacion.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_transmisionInter.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_verificacionRemota.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_visitaColectiva.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_visitaPresencial.dart';
import 'package:tayta/viewmodels/UI/viewmodels/form_viewsmodel_inicioFinActividades.dart';

import '../../infraestructure/dao/database/database.dart';
import '../../infraestructure/dao/formdatamodeldao_visita.dart';

class MenudeOpciones extends StatefulWidget {
  final viewModel = FormDataModelViewModel();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDao => _appDatabase.formDataModelDaoVisita;
  int? total = 0;
  //PRUEBA PROGRESO;

  // PARA CARGAR EL MODIFICAR
  String? mediaPath;
  List<XFile>? listMediaPath;
  Visitas? formDataModel;

  MenudeOpciones({Key? key});

  @override
  State<StatefulWidget> createState() {
    return _MenudeOpciones();
  }
}

class _MenudeOpciones extends State<MenudeOpciones> {


  Widget VisitaPresencial = MenuVisitaPresencial(List.empty(growable: true), Visitas()),
      Bitacora = MenuBitacora(List.empty(growable: true), Visitas()),
      VerificacionRemota = MenuVerificacionRemota(List.empty(growable: true), Visitas()),
      VisitaColectiva = MenuVisitaColectiva(List.empty(growable: true), Visitas()),
      AsistenciaTecnica = MenuAsistenciaTecnica(List.empty(growable: true), Visitas()), //NO
      CampanaSalud = MenuCampanaSalud(List.empty(growable: true), Visitas()),
      EncuentroMagico = MenuEncuentroMagico(), //NO
      PuntodePago = MenuPuntoPago(List.empty(growable: true), Visitas()),
      ReporteConsolidado = MenuReporteConsolidado(Visitas()),
      ProcesarPadron = MenuProcesarPadron(), //NO
      ReporteUsuarios = MenuReporteUsuarios(), //NO
      DialogoSaberes = MenuDialogoSaberes(List.empty(growable: true), Visitas()),
      TransmisionInter = MenuTransmisionInter(Visitas()),
      EncuentroSaberes = MenuEncuentroSaberes(Visitas()),
      RegistroSAberes = MenuRegistroSaberes(), //NO
      ContactoRefererencia = MenuContactoReferencia(Visitas()),
      SituacionRiesgo = MenuSituacionesRiesgo(Visitas()),
      InicioFin = MenuInicioFin(List.empty(growable: true), Visitas()),
      TarjetizacionCapacitacion = MenuTarjetizacionCapacitacion( Visitas());


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

  Future<void> ConseguirFotos(Visitas obj) async {
    var res = await widget.formDataModelDao.totalFormDataModels();
    setState(() {
      widget.total = res;
    });
  }


  Future<void> loadTotalRegister() async {
    var res = await widget.formDataModelDao.totalFormDataModels();
    setState(() {
      widget.total = res;
    });
  }

  void actualizarTotalConTemporizador(int nuevoTotal) {
    Timer(Duration(seconds: 1), () {
      setState(() {
        widget.total = nuevoTotal;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          Constants.tituloMenudeOpciones,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD60000),
        //leading: Icon(Icons.menu),
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
                                MaterialPageRoute(builder: (context) => login()),
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
            icon: Image.asset(Resources.iconProgreso),
            color: Colors.white,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuProgreso()),
              );
            },
          ),

          IconButton(
            icon: Image.asset(Resources.iconSincronizar),
            color: Colors.white,
            onPressed: () async {

              SincronizarDialog();

            },
          ),
        ],
      ),
      //drawer: const MenuLateral(),
      body: formUI(),
    );
  }

  void SincronizarDialog(){
    String MensajeSinc = "Se sincronizara todo el listado";
    String MensajeSubSinc = "¿Desea sincronizar los registros?";
    bool mostrar = false;

    double progresso = 0.0;
    int progressoInicio = 0;
    int? progressoFin = widget.total;
    double sumando = 4.44;

    if (widget.total != 0) {
      sumando = (100/widget.total!)/100;
    }



    showDialog(
        context: context,
        builder: (context){
          //AGREGAR ESTO POR SI QUIERO QUE EL DIALOG SE REFRESQUE
          return StatefulBuilder(
              builder: (context, setState)
          {
            return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: SingleChildScrollView(
                    child: Column(
                      children: [

                        //BARRA DE PROGRESO CON SU TITULO
                            HelpersViewAlertProgressSinc(
                                Mensaje: MensajeSinc,
                                subtexto: MensajeSubSinc,
                                progress: progresso,
                                mostrar: mostrar,
                                contadorInicio: progressoInicio,
                                contadorFin: progressoFin
                            ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // Align row to the end
                          children: [
                            Spacer(), // Push remaining space to the left

                            InkWell(
                              onTap: () async {

                                //INICIALIZA CARGA
                                setState(() {
                                  mostrar = true;
                                  //progresso = 0.0;
                                  //progresso += (sumando);
                                  MensajeSinc = "Sincronizando Data";
                                  MensajeSubSinc = "$progressoInicio/$progressoFin";
                                });


                                var api = await getIt.getAsync<
                                    apiprovider_menuOpciones>();
                                var iniciFinActividades = await widget
                                    ._appDatabase.formDataModelDaoVisita
                                    .findAllVISITAS();
                                if (iniciFinActividades.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "No hay data para sincronizar")));
                                } else {
                                  for (var element in iniciFinActividades) {
                                    var response = await api
                                        .apiInsertInicioFinActividad(element);
                                    print("response: $response");

                                    //AUMENTA
                                    setState(() {
                                      //mostrar = true;
                                      //progresso = 0.0;
                                      progresso += (sumando);
                                      progressoInicio++;
                                      MensajeSubSinc = "$progressoInicio/$progressoFin";
                                    });

                                  }

                                  Navigator.pop(
                                      context); //Close your current dialog
                                  showDialogValidFields(
                                      "Sincronización exitosa");


                                  //Navigator.of(context).pop();

                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 20, bottom: 20),
                                child: const Text(
                                  "Sincronizar",
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
    );
  }


  void ModificarBorrar(int index, Visitas obj) {

    String titulo = getItemDescription(obj.codigoRegistro);

    showDialog(
        context: context,
        builder: (BuildContext context){
      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: SingleChildScrollView(
              child: Column(
                children: [
                  HelpersViewAlertMensajeFOTO.formItemsDesign("${index + 1})  ${obj.fechaRegistro} \n$titulo \n${obj.dni} \n${obj.imei}","¿Que acción desea realizar?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align row to the end
                    children: [
                      Spacer(), // Push remaining space to the left

                      InkWell(
                        onTap: () {



              //MODIFICAR CARGAR DATA

              int? codigoForm =  obj.codigoRegistro ;

              switch (codigoForm) {

                case Resources.valor_Bitacora:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuBitacora(widget.listMediaPath!, obj)),
                  );

                case Resources.valor_Contacto_Referencia:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuContactoReferencia(obj)),
                  );

                case Resources.valor_Inicio_Fin_de_Actividades:

                  //await ConseguirFotos(obj);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuInicioFin(List.empty(growable: true), obj)),
                  );

                case Resources.valor_Encuentro_de_Saberes:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuEncuentroSaberes(obj)),
                  );
                case Resources.valor_Situaciones_de_Riesgo:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuSituacionesRiesgo(obj)),
                  );
                case Resources.valor_Punto_de_Pago:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuPuntoPago(widget.listMediaPath!, obj)),
                  );
                /*
                case Resources.valor_Visita_Presencial:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuVisitaPresencial(widget.listMediaPath!, widget.formDataModel)),
                  );
                case Resources.valor_Verificacion_Remota:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuVerificacionRemota(widget.listMediaPath!, widget.formDataModel)),
                  );
                case Resources.valor_Visita_Colectiva:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuVisitaColectiva(widget.listMediaPath!, widget.formDataModel)),
                  );

                case Resources.valor_Dialogos_de_Saberes:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuDialogoSaberes(widget.listMediaPath!, widget.formDataModel)),
                  );
                case Resources.valor_Transmision_Interegeneracional:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuTransmisionInter(widget.listMediaPath!, widget.formDataModel)),
                  );
                case Resources.valor_Campana_de_Salud:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuCampanaSalud(widget.listMediaPath!, widget.formDataModel)),
                  );

                case Resources.valor_Reporte_Consolidado_Individual:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuReporteConsolidado(widget.listMediaPath!, widget.formDataModel)),
                  );
                case Resources.valor_Procesar_Padron:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuProcesarPadron(widget.listMediaPath!, widget.formDataModel)),
                  );
                case Resources.valor_Reporte_Usuarios:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuReporteUsuarios(widget.listMediaPath!, widget.formDataModel)),
                  );
                case Resources.valor_Asistencia_Tecnica:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuAsistenciaTecnica(widget.listMediaPath!, widget.formDataModel)),
                  );
                case Resources.valor_Encuentro_Magico:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuEncuentroMagico(widget.listMediaPath!, widget.formDataModel)),
                  );
                case Resources.valor_Registro_de_Saberes:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuRegistroSaberes(widget.listMediaPath!, widget.formDataModel)),
                  );
                  */

                            default:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                              );
                          }



                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                          child: const Text(
                            "Modificar",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: ()   async {
                          widget.formDataModelDao.BorrarFormDataModels(obj.codigoVisita!);
                          widget.viewModel.deleteItem(index);
                          Navigator.of(context).pop();
                          var nuevoTotal = widget.total;
                          actualizarTotalConTemporizador(nuevoTotal! - 1);

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

  String getItemDescription(int? codigoRegistro) {

    var ListNombreReporteBD = [
      [
        Resources.titulo_Visita_Presencial, Resources.valor_Visita_Presencial
      ],
      [
        Resources.titulo_Verificacion_Remota, Resources.valor_Verificacion_Remota
      ],
      [
        Resources.titulo_Visita_Colectiva, Resources.valor_Visita_Colectiva
      ],
      [
        Resources.titulo_Asistencia_Tecnica, Resources.valor_Asistencia_Tecnica
      ],
      [
        Resources.titulo_Campana_de_Salud, Resources.valor_Campana_de_Salud
      ],
      [
        Resources.titulo_Encuentro_Magico, Resources.valor_Encuentro_Magico
      ],
      [
        Resources.titulo_Punto_de_Pago, Resources.valor_Punto_de_Pago
      ],
      [
        Resources.titulo_Reporte_Consolidado_Individual, Resources.valor_Reporte_Consolidado_Individual
      ],
      [
        Resources.titulo_Procesar_Padron, Resources.valor_Procesar_Padron
      ],
      [
        Resources.titulo_Reporte_Usuarios, 0 //no tiene
      ],
      [
        Resources.titulo_Dialogos_de_Saberes, Resources.valor_Dialogos_de_Saberes
      ],
      [
        Resources.titulo_Transmision_Interegeneracional,Resources.valor_Transmision_Interegeneracional
      ],
      [
        Resources.titulo_Encuentro_de_Saberes, Resources.valor_Encuentro_de_Saberes
      ],
      [
        Resources.titulo_Registro_de_Saberes, Resources.valor_Registro_de_Saberes
      ],
      [
        Resources.titulo_Contacto_Referencia, Resources.valor_Contacto_Referencia
      ],
      [
        Resources.titulo_Casos_de_Violencia, Resources.valor_Situaciones_de_Riesgo
      ],
      [
        Resources.titulo_Inicio_Fin_de_Actividades, Resources.valor_Inicio_Fin_de_Actividades
      ],
      [
        Resources.titulo_Bitacora, Resources.valor_Bitacora
      ],
      [
        Resources.titulo_Cobro_Capacitacion, Resources.valor_Cobro_Capacitacion
      ],
      [
        Resources.titulo_Cobro_Tarjetizacion, Resources.valor_Cobro_Tarjetizacion
      ]
    ];

    for (var entry in ListNombreReporteBD) {
      var entrada = entry[1];
      if (entrada == codigoRegistro) {
        return entry[0] as String; // Cast to String for clarity
      }
    }
    return "No definido";
  }

  void showModal(int lista) {

    var OperativasLIST = [
    [
        Resources.tayta_Visita_Presencial,
        Resources.titulo_Visita_Presencial,
        VisitaPresencial
      ],
      [
        Resources.tayta_Verificacion_Remota,
        Resources.titulo_Verificacion_Remota,
        VerificacionRemota
      ],
      [Resources.tayta_Visita_Colectiva,
        Resources.titulo_Visita_Colectiva,
        VisitaColectiva
      ],
      [Resources.tayta_Punto_de_Pago,
        Resources.titulo_Punto_de_Pago,
        PuntodePago
      ],
      [Resources.tayta_Bitacora,
      Resources.titulo_Bitacora,
        Bitacora
      ],
    ];

    var ComplementariasLIST = [
      [
        Resources.tayta_Dialogos_de_Saberes,
        Resources.titulo_Dialogos_de_Saberes,
        DialogoSaberes
      ],
      [
        Resources.tayta_Transmision_Interegeneracional,
        Resources.titulo_Transmision_Interegeneracional,
        TransmisionInter
      ],
      [
        Resources.tayta_Encuentro_de_Saberes,
        Resources.titulo_Encuentro_de_Saberes,
        EncuentroSaberes
      ],
      [Resources.tayta_Campana_de_Salud,
        Resources.titulo_Campana_de_Salud,
        CampanaSalud
      ],
      [
        Resources.tayta_Situaciones_de_Riesgo,
        Resources.titulo_Casos_de_Violencia,
        SituacionRiesgo
      ],
      [
        Resources.tayta_Contacto_Referencia,
        Resources.titulo_Contacto_Referencia,
        ContactoRefererencia
      ],
    ];

    var OtrasLIST = [
      [
        Resources.tayta_Inicio_Fin_de_Actividades,
        Resources.titulo_Inicio_Fin_de_Actividades,
        InicioFin
      ],
      [
        Resources.tayta_Reporte_Consolidado_Individual,
        Resources.titulo_Reporte_Consolidado_Individual,
        ReporteConsolidado
      ],
      [Resources.tayta_Procesar_Padron,
        Resources.titulo_Procesar_Padron,
        ProcesarPadron
      ],
      [Resources.tayta_Reporte_Usuarios,
        Resources.titulo_Reporte_Usuarios,
        ReporteUsuarios
      ],
      [Resources.tayta_Tarjetizacion_Capacitacion,
        Resources.titulo_Tarjetizacion_Capacitacion,
        TarjetizacionCapacitacion
      ],
    ];

    var ProductosLIST = [
      [
        Resources.tayta_Asistencia_Tecnica,
        Resources.titulo_Asistencia_Tecnica,
        AsistenciaTecnica
      ],
      [Resources.tayta_Encuentro_Magico,
        Resources.titulo_Encuentro_Magico,
        EncuentroMagico
      ],
      [
        Resources.tayta_Registro_de_Saberes,
        Resources.titulo_Registro_de_Saberes,
        RegistroSAberes
      ],
    ];

    if (lista == 1) {
      ProductosLIST = OperativasLIST;
    } else if (lista == 2) {
      ProductosLIST = ComplementariasLIST;
    } else if (lista == 3) {
      ProductosLIST = OtrasLIST;
    }


    //final Widget value = () => MenuVerificacionRemota() as Widget;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        //TALVEZ SIRVA TALVEZ NO
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Tipo de Registro',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                    itemCount: ProductosLIST.length,
                    itemBuilder: (_, i) {
                      final String imagePath = ProductosLIST[i][0] as String;
                      final String textValue = ProductosLIST[i][1] as String;
                      final Widget ui = ProductosLIST[i][2] as Widget;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            //Widget myWidget = MenuVerificacionRemota();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ui),
                            );
                          },
                          child: SizedBox(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Image.asset(
                                    imagePath,
                                  ),
                                ),
                                //Icon(iconValue, color: Colors.red,),

                                Text(
                                  textValue,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2, // Set the number of lines here
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          },
        );
      },
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


          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),

          GestureDetector(
              onTap: () {
                showModal(1);
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
                child: const Text("Opciones Operativas",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )
          ),

          const SizedBox(height: 16.0),

          GestureDetector(
              onTap: () {
                showModal(2);
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
                child: const Text("Opciones Complementarias",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )
          ),

          const SizedBox(height: 16.0),

          GestureDetector(
              onTap: () {
                showModal(3);
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
                child: const Text("Otras Opciones",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )
          ),

          const SizedBox(height: 16.0),

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
          // AnimatedInfiniteScrollView debajo del botón

          Expanded(
            child: AnimatedInfiniteScrollView<Visitas>(
              viewModel: widget.viewModel,
              itemBuilder: (context, index, item) => Card(
                child: InkWell(
                  onTap: () {
                    ModificarBorrar(index, item);
                  },
                child: ListTile(
                  title: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.040,
                    child: Text(
                      "${index + 1}.- ${getItemDescription(item.codigoRegistro)}",
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
                        "Fecha de Registro: ${item.fechaRegistro}",
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
                        "Descripción: ${item.observacion}",
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
          ),
        ],
      ),
    );
  }
}
