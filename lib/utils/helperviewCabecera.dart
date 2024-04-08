import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/viewmodels/UI/menu_deOpciones.dart';

import '../infraestructure/dao/formdatamodeldao_visita.dart';

class HelpersViewCabecera {

  static String imageSource = Resources.sateliteverde;



  static PreferredSizeWidget formItemsDesign(titulo,context) {

    return AppBar(
      title:  Text(titulo, style: TextStyle(color: Colors.white),),
      backgroundColor: Color(0xFFD60000),
      //leading: Icon(Icons.menu),
      actions: [
        IconButton(
          icon: Image.asset(Resources.flechaazul),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
            );
          },
        ),
      ],
    );
  }
  static void Guardar(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text ("Se ha guardado la actividad \n(Click aqui si desea ir \nal menú principal)", style: TextStyle(fontSize: 16),)
                              ),
                              Icon(Icons.save, color: Colors.red,)
                            ],
                          ),
                        ),

                      )
                    ],
                  )
              )
          );
        }
    );
  }



    static Future<void> CoordenadasGPS(BuildContext context) async {
      // Establece la imagen
      imageSource = Resources.sateliteverde;

      // Obtiene la fecha y hora actual
      DateTime now = DateTime.now();

      // Formatea la fecha y hora actual
      String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);

      // Inicializa el objeto Location
      Location location = Location();

      // Obtiene las coordenadas de la ubicación actual
      LocationData? currentLocation = await location.getLocation();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('latitude',currentLocation.latitude.toString());
      await prefs.setString('longitude', currentLocation.longitude.toString());
      await prefs.setString('altitude', currentLocation.altitude.toString());


      // Muestra la ventana emergente
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.all(20),
                content: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: <Widget>[

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                            children: [
                              Text(
                                'Coordenadas Actualizadas',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                            children: [
                              Text(
                                'Fecha:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                formattedDate, // Muestra la fecha actual formateada
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                            children: [
                              Text(
                                'Latitud:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                currentLocation?.latitude?.toStringAsFixed(4) ?? 'Desconocido',
                                // Muestra la latitud actual o 'Desconocido' si no está disponible
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                            children: [
                              Text(
                                'Longitud:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                currentLocation?.longitude?.toStringAsFixed(4) ?? 'Desconocido',
                                // Muestra la longitud actual o 'Desconocido' si no está disponible
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                            children: [
                              Text(
                                'Altitud:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                currentLocation?.altitude?.toStringAsFixed(4) ?? 'Desconocido',
                                // Muestra la altitud actual o 'Desconocido' si no está disponible
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),


                    ],
                  )
              )
          );
        }
    );

  }

}