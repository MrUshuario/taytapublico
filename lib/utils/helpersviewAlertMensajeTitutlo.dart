import 'package:flutter/material.dart';
import 'package:tayta/utils/resources.dart';

class HelpersViewAlertMensajeTitulo {

  static Widget formItemsDesign(String text) {
    return Column(
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
                    text,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}