import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/resources.dart';
import 'menu_deOpciones.dart';

class MenuProgreso extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MenuProgreso();
  }

}

class _MenuProgreso extends State<MenuProgreso> {



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //controller?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          title:  Text(Resources.titulo_Bitacora, style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFFD60000),
          actions: [
            IconButton(
              icon: Image.asset(Resources.flechaazul),
              color: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Image.asset(Resources.iconInfo),
                          SizedBox(width: 4), // Espacio entre el icono y el texto
                          Expanded(
                            child: Text(
                              '¿Seguro que quieres salir?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20, // Tamaño de fuente deseado
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        ButtonBar(
                          alignment: MainAxisAlignment.start, // Alinea los botones a la izquierda
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Cierra el diálogo
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MenudeOpciones()),
                                );
                              },
                              child: Text('Sí',
                                style: TextStyle(
                                  fontSize: 18, // Tamaño de fuente deseado
                                ),),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Cierra el diálogo
                              },
                              child: Text('No',
                                style: TextStyle(
                                  fontSize: 18, // Tamaño de fuente deseado
                                ),),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            /*
            IconButton(

            ),

             */
          ],
        ),

        body:  Center (
          child: SingleChildScrollView(
            child: Container(
              width: 420,
              margin: const EdgeInsets.all(41.0),
              child: Form(
                //key: widget.keyForm,
                child: formUI(),
              ),
            ),
          ),
        ),
      );
  }

  Widget formUI() {
    return  Container(
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
    children: [

        ],
      )
    );
  }
}