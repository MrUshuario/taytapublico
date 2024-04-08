import 'package:flutter/material.dart';

class HelpersViewTextSize {

  static Widget formItemsDesign(item, context) {
    return Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.red,
            //color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: ListTile(
            title: item
        ));
  }

  static String? validateField(String value, List<String> paramsValidate) {
    RegExp regExp = RegExp(paramsValidate[0]);
    if (value.isEmpty) {
      return paramsValidate[1];
    } else if (!regExp.hasMatch(value)) {
      return paramsValidate[2];
    }
    return null;
  }

  static Widget headerColumn(String? value) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue)
          ),
        ],
      ),
    );
  }

  static Widget column(String? value, bool? flagEdit, bool? flagSync) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            value.toString(),
            style: flagEdit == true && flagSync == true
                ? const TextStyle(fontSize: 14, color: Colors.green)
                : (flagEdit == true ? const TextStyle(fontSize: 14, color: Colors.blue) : const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}