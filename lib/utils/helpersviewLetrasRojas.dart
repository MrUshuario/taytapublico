import 'package:flutter/material.dart';

class HelpersViewLetrasRojas {

  static Widget formItemsDesign(String text) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
      children: [
        const SizedBox(width: 0.0), // Create left padding

    ConstrainedBox(
    constraints: const BoxConstraints(
    minWidth: 200, // Set your minimum width here
    maxWidth: double.infinity, // Allow container to grow to 100% of parent
    ),
        child:  Container(
          width: 285.0,
          decoration: const BoxDecoration(
              border: Border(
              bottom: BorderSide(
              color: Colors.red,
              width: 2.0, // Adjust the width as needed
              ),
              ),
            //color: Colors.red,
          ),
          child:  Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              //color: Colors.white,
            ),
          ),
        ),
        )
      ],
    );
  }
}