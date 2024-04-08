import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tayta/model/t_visita.dart';
import 'package:tayta/utils/camera.dart';
import 'package:tayta/utils/resources.dart';
import 'package:video_player/video_player.dart';

class HelpersViewCamera extends StatefulWidget  {
  static Widget formItemsDesign(mediaPath, context, texto) {
    XFile? videoFile;
    VideoPlayerController? videoController;
    final VideoPlayerController? localVideoController = videoController;

    bool fototomada = false;

    void TomarFoto(context, mediaPath) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Color(0xFFD60000),
                          ),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: const Text("Cerrar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        )),
                    if (localVideoController == null && mediaPath!.isEmpty)
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
                                    ? Image.network(mediaPath!)
                                    : Image.file(File(mediaPath!)))
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.pink)),
                                child: Center(
                                  child: AspectRatio(
                                      aspectRatio: localVideoController
                                          .value.aspectRatio,
                                      child: VideoPlayer(localVideoController)),
                                ),
                              ),
                      ),
                  ],
                )));
          });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Center horizontally
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 50.0), // Adjust as needed
          child: Text(
            texto,
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),

        //TOMAR FOTO
        GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraApp(List.empty(growable: true), Visitas())),
            );
          },
          child: Image.asset(Resources.fotoImg, width: 48, height: 48),
        ),

        //VER FOTO
        (mediaPath != null && mediaPath.isNotEmpty)
            ? GestureDetector(
                onTap: () {
                  TomarFoto(context, mediaPath!);
                },
                child: Image.asset(Resources.fotoCam, width: 48, height: 48),
              )
            : SizedBox(),

        // BORRAR FOTO
        GestureDetector(
          onTap: () {
            //setState(() {
            mediaPath = null;
            //});
          },
          child: Image.asset(Resources.fotoX, width: 48, height: 48),
        ),
      ],
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
