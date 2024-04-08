import 'package:flutter/material.dart';
import 'package:tayta/utils/resources.dart';

class HelpersViewAlertProgressSinc extends StatelessWidget {

    const HelpersViewAlertProgressSinc({super.key,
      required this.Mensaje,
      required this.subtexto,
      required this.progress,
      required this.mostrar,
      required this.contadorInicio,
      required this.contadorFin
    });

    final int? contadorInicio;
    final int? contadorFin;
    final String Mensaje;
    final String subtexto;
    final double progress;
    final bool mostrar;

    final double width = 250.0;
    final double height = 20.0;

    @override
    Widget build(BuildContext context) {
      return   Column(
        children: [

          Align(
            alignment: Alignment.topLeft, // Align to top left corner
            child: Container(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 20),
              child: Row(
                children: [
                  Image.asset(Resources.iconInfo),
                  Expanded(
                    child: Text(
                      Mensaje,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Separators (optional):
          const SizedBox(height: 10),

          // Second text:
          Container(
            padding: const EdgeInsets.all(20),
            child:  Text(
              subtexto,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          // Separators (optional):
          const SizedBox(height: 10),


          //PROGRESS BAR
          Visibility(
            visible: mostrar,
            child:
          Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              width: width*progress,
              height: height,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                '${(progress*100).toInt()}%',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
      ),
          //FIN PROGRESS BAR
      ],
      );
    }

}