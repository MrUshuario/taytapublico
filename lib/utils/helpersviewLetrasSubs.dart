import 'package:flutter/material.dart';

class HelpersViewLetrasSubs {

  static Widget formItemsDesign(String text) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
      children: [
        const SizedBox(width: 0.0), // Create left padding
        Container(
          width: 285.0,
          decoration: const BoxDecoration(
            //color: Colors.red,
          ),
          child:  Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16.0,

              //color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}