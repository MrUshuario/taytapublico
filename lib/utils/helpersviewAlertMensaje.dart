import 'package:flutter/material.dart';
import 'package:tayta/utils/resources.dart';

class HelpersViewAlertMensaje {

  static Widget formItemsDesign(String text, context) {
    return Container(
      // Customize padding and styling as needed:
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Align:
          Align(
            alignment: Alignment.topLeft, // Align to top left corner
            child: Container(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 20),
              child: Row(
                children: [
                  Image.asset(Resources.iconInfo),
                  Expanded(
                    child: Text(
                      "Mensaje",
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
            child: Text(
              "Selecciones si la persona visitada está fallecida",
              style: const TextStyle(fontSize: 16),
            ),
          ),

          // Separators (optional):
          const SizedBox(height: 10),

          // InkWell:
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align row to the end
            children: [
              Spacer(), // Push remaining space to the left
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                  child: const Text(
                    "ACEPTAR",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}