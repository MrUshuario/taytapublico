import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tayta/viewmodels/UI/DesUso/menu_asistenciaTecnica.dart';
import 'package:tayta/viewmodels/UI/DesUso/menu_encuentroMagico.dart';
import 'package:tayta/viewmodels/UI/DesUso/menu_registroSaberes.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_bitacora.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_campanaSalud.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_casosViolencia.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_contactoReferencia.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_dialogoSaberes.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_encuentroSaberes.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_procesarPadron.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_puntoPago.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_reporteConsolidado.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_reporteUsuarios.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_transmisionInter.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_verificacionRemota.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_visitaColectiva.dart';
import 'package:tayta/viewmodels/UI/opciones/menu_visitaPresencial.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/resources.dart';
import '../model/t_visita.dart';
import '../viewmodels/UI/opciones/menu_inicio_fin.dart';

class DisplayPhoto extends StatefulWidget {

  String? mediaPath;
  List<XFile>? listMediaPath;
  Visitas? formDataModel;
  //String? byte;

  /// Default Constructor
  DisplayPhoto(this.listMediaPath, this.formDataModel, this.mediaPath, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DisplayPhoto();
  }
}

class _DisplayPhoto extends State<DisplayPhoto> {

  XFile? videoFile;
  VideoPlayerController? videoController;
   // = this.formDataModel.fotoUno;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text("Ver Foto", style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFFD60000),
        actions: [
          IconButton(
            icon: Image.asset(Resources.flechaazul),
            color: Colors.white,
            onPressed: () {

              var codigoForm =  widget.formDataModel?.codigoRegistro ;
              switch (codigoForm) {
                /*
                case Resources.valor_Visita_Presencial:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuVisitaPresencial(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Verificacion_Remota:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuVerificacionRemota(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Visita_Colectiva:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuVisitaColectiva(widget.listMediaPath, widget.formDataModel)),
                  );

                 */
                case Resources.valor_Punto_de_Pago:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuPuntoPago(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Bitacora:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuBitacora(widget.listMediaPath, widget.formDataModel)),
                  );
                  /*
                case Resources.valor_Dialogos_de_Saberes:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuDialogoSaberes(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Transmision_Interegeneracional:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuTransmisionInter(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Encuentro_de_Saberes:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuEncuentroSaberes(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Campana_de_Salud:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuCampanaSalud(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Situaciones_de_Riesgo:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuSituacionesRiesgo(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Contacto_Referencia:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuContactoReferencia(widget.listMediaPath, widget.formDataModel)),
                  );

                   */
                case Resources.valor_Inicio_Fin_de_Actividades:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuInicioFin(widget.listMediaPath, widget.formDataModel)),
                  );
                  /*
                case Resources.valor_Reporte_Consolidado_Individual:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuReporteConsolidado(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Procesar_Padron:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuProcesarPadron(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Reporte_Usuarios:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuReporteUsuarios(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Asistencia_Tecnica:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuAsistenciaTecnica(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Encuentro_Magico:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuEncuentroMagico(widget.listMediaPath, widget.formDataModel)),
                  );
                case Resources.valor_Registro_de_Saberes:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenuRegistroSaberes(widget.listMediaPath, widget.formDataModel)),
                  );

                   */
                default:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                  );
              }

            },
          ),
        ],
      ),
      body: _thumbnailWidget(),);
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    final VideoPlayerController? localVideoController = videoController;

    return Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            if (localVideoController == null && widget.mediaPath!.isEmpty)
              Container()
            else
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: (localVideoController == null)
                    ? (
                    // The captured image on the web contains a network-accessible URL
                    // pointing to a location within the browser. It may be displayed
                    // either with Image.network or Image.memory after loading the image
                    // bytes to memory.
                    kIsWeb
                        ? Image.network(widget.mediaPath!)
                        : Image.file(File(widget.mediaPath!)))
                    : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink)),
                  child: Center(
                    child: AspectRatio(
                        aspectRatio:
                        localVideoController.value.aspectRatio,
                        child: VideoPlayer(localVideoController)),
                  ),
                ),
              ),
          ],
        );
  }

}