import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:tayta/infraestructure/dao/model/JSON/ModernizacionCobroUser.dart';
import 'dart:convert';

import 'package:tayta/model/t_padron.dart';


class apiprovider_usuarioBuscar {


  //final BASE_URL = "https://padron.free.beeceptor.com";
  final client = GetIt.I.get<Client>();
  final api_usuarioMC = "https://tarjeterizacion.free.beeceptor.com/a";
  final api_usuarioMC2 = "https://tarjeterizacion.free.beeceptor.com/";

  Future<ModernizacionCobro> obtener_usuario(int DNI) async {
    final Map<String, dynamic> bodyData = {'DNI': "$DNI"};
    try {
      print("iniciando obtener_usuario...");
      Uri uri = Uri.parse(
          api_usuarioMC);
      final response = await client.post (
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      );
      print("response USUARIO...${response.body}");

      final data = response.body;

      return ModernizacionCobro.fromJson(json.decode(data));


    } catch (e) {
      ModernizacionCobro Model = ModernizacionCobro();
      return  Model;
    }
  }

  Future<ModernizacionCobro> obtener_usuario2(int DNI) async {
    final Map<String, dynamic> bodyData = {'DNI': "$DNI"};
    try {
      print("iniciando obtener_usuario...");
      Uri uri = Uri.parse(
          api_usuarioMC2);
      final response = await client.post (
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      );
      print("response USUARIO...${response.body}");

      final data = response.body;

      return ModernizacionCobro.fromJson(json.decode(data));


    } catch (e) {
      ModernizacionCobro Model = ModernizacionCobro();
      return  Model;
    }
  }



}