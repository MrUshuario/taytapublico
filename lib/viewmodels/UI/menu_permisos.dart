import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tayta/utils/constantes.dart';
import 'package:tayta/utils/resources.dart';
import 'package:tayta/viewmodels/UI/menu_login.dart';
import 'package:permission_handler/permission_handler.dart';


class MenuPermisos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuPermisos();
  }
}

class _MenuPermisos extends State<MenuPermisos> {
  bool permiso_telefono = true;
  bool permiso_gps = true;
  bool permiso_camara= true;

  String textoprueba = "asdas";

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var sto = await Permission.storage.status;
    var gps = await Permission.locationWhenInUse.status;
    var cam = await Permission.camera.status;


    if(!sto.isDenied){

      setState(() {
        textoprueba = "1111";
        permiso_telefono = true;
      });


    }

    if(!gps.isDenied){

      setState(() {
        textoprueba = "1111";
        permiso_gps = true;
      });

    }

    if(!cam.isDenied){

      setState(() {
        textoprueba = "1111";
        permiso_camara = true;
      });


    }
  }

  /*
  @override
  void initState() async  {

    var sto = await Permission.storage.status;
    var gps = await Permission.locationWhenInUse.status;
    var cam = await Permission.camera.status;

    if(sto.isDenied){
      permiso_telefono = false;
  }

    if(gps.isDenied){
      permiso_gps = false;
    }

    if(cam.isDenied){
      permiso_camara = false;
    }
  } */

  pedir_permiso_telefono(context){
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

                    },

                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.red))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text ("Habilitar camara del celular", style: TextStyle(fontSize: 16),)
                          ),
                          Icon(Icons.camera_alt, color: Colors.blue,)
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



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar: AppBar(
          title: const Text(Constants.tituloPermisos, style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFFD60000),
        ),
        //drawer: const MenuLateral(),
        body: Center (
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
      ),
    );
  }

  Widget formUI() {
    return Column(
        children: <Widget>[

          Text('Permisos', style: const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,
        ),),
          Row(
            children: [
              Text('Almacen', style: const TextStyle(
                fontSize: 16.0,
                //color: Colors.white,
              ),),
              const SizedBox(width: 30.0), // AGREGA ESPACIO

              Switch(
                value: permiso_telefono,
                activeColor: Colors.red,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    permiso_telefono = value;
                  });
                },
              ),
            ],
          ),

          Row(
            children: [
              Text('GPS', style: const TextStyle(
                fontSize: 16.0,
                //color: Colors.white,
              ),),
              const SizedBox(width: 60.0), // AGREGA ESPACIO

              Switch(
                value: permiso_gps,
                activeColor: Colors.red,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    permiso_gps = value;
                  });
                },
              ),
            ],
          ),

          Row(
            children: [
              Text('Camara', style: const TextStyle(
                fontSize: 16.0,
                //color: Colors.white,
              ),),
              const SizedBox(width: 35.0), // AGREGA ESPACIO

              Switch(
                value: permiso_camara,
                activeColor: Colors.red,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    permiso_camara = value;
                  });
                },
              ),
            ],
          ),


          GestureDetector(
              onTap: () async {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  login()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(30.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Color(0xFFD60000),
                  /*
                  gradient: const LinearGradient(colors: [
                      Color(0xFF0EDED2),
                    Color(0xFFD60000),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),

                   */
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: const Text("ACCEDER",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),



          const Text('Habilitar todas las opciones para poder trabajar con el AYZA',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
            fontSize: 16.0,
            //color: Colors.white,
          ),
          ),


        ],
    );
  }

}