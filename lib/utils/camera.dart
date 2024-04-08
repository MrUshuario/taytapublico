import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tayta/model/t_visita.dart';

import 'cameraBuild.dart';

/// CameraApp is the Main Application.
class CameraApp extends StatelessWidget {
  List<XFile>? listMediaPath;
  Visitas? formDataModel;
  /// Default Constructor
  CameraApp(this.listMediaPath, this.formDataModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraHome(listMediaPath, formDataModel),
    );
  }
}