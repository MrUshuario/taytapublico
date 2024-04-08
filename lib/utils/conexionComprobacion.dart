import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetChecker {
  static bool _isConnected = true;
  static bool get isConnected => _isConnected;

  static void init() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _isConnected = false;
      } else {
        _isConnected = true;
      }
    });
  }

  static Widget buildInternetIndicator() {
    return _isConnected
        ? Container() // Retorna un contenedor vacío si hay conexión
        : Container(
      color: Color(0xFFD60000),
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Colors.white),
          SizedBox(width: 8.0),
          Text('No hay conexión a Internet',
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
