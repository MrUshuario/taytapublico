import 'package:get_it/get_it.dart';
import 'package:tayta/infraestructure/dao/model/JSON/VisitaPersonal_PROBLEM.dart';
import 'package:tayta/infraestructure/dao/model/JSON/versionesModel.dart';
import 'package:http/http.dart';
import 'package:tayta/model/t_version.dart';
import 'package:tayta/model/t_visita.dart';
import 'dart:convert';

import 'package:tayta/utils/resources_apis.dart';

import '../../../model/t_ubigeo.dart';
import '../model/responseinciofinactividad.dart';


class apiprovider_menuOpciones {


  final BASE_URL = "http://m.pension65.gob.pe:8080/RSAyza/grabarVisitaV2.json";
  final client = GetIt.I.get<Client>();
  final api_versiones = apisResources.REST_VERSION;
  final api_ubigeo = apisResources.REST_UBIGEO;


  //ESTE METODO ES UN ATAJO, NO SE DEBE ENVIAR VISITAS PORQUE TIENE LISTAS
  //LO QUE SE DEBE ENVIAR ES EL OBJETO VISITA_PERSONAL ES EL QUE RECIBE LA API
  //HAY UN 2DO OBJETO A ENVIAR PERO SE IGNORARA POR EL MOMENTO.
  Future<ReponseInicioFinActividades> apiInsertInicioFinActividad(Visitas request) async {
    try {
      Uri uri = Uri.parse(BASE_URL);
      String body = json.encode(request.toMap());
      print("iniciando apiInsertInicioFinActividad...");
      print("body: $body");
      final response = await client.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      print("response apiInsertInicioFinActividad...${response.body}");

      if (response.statusCode == 200) {
        return ReponseInicioFinActividades.fromJson(json.decode(response.body));
      } else {
        return ReponseInicioFinActividades.fromJson(json.decode(response.body));
      }

    } catch (e) {

      throw Exception(e);
    }
  }

  //ESTE ES EL CORRECTO A USAR MAS TARDE
  Future<ReponseInicioFinActividades> Sincronizar_VisitaPersonal(VisitaPersonal request) async {
    try {
      Uri uri = Uri.parse(BASE_URL);
      String body = json.encode(request.toMap());
      print("iniciando apiInsertInicioFinActividad...");
      print("body: $body");
      final response = await client.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      print("response apiInsertInicioFinActividad...${response.body}");

      if (response.statusCode == 200) {
        return ReponseInicioFinActividades.fromJson(json.decode(response.body));
      } else {
        return ReponseInicioFinActividades.fromJson(json.decode(response.body));
      }

    } catch (e) {

      throw Exception(e);
    }
  }

  Future<versionesModel> get_VersionModel() async {
    try {print("iniciando saveStudent...");
      Uri uri = Uri.parse(
          api_versiones);
      final response = await client.get (
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      //print("response saveStudent...${response.body}");

      return versionesModel.fromJson(json.decode(response.body));

    } catch (e) {
      versionesModel Model = versionesModel();
      return  Model;
    }
  }

  Future<Version> get_VersionEntity() async {
    try {
      print("iniciando saveStudent...");
      Uri uri = Uri.parse(
          api_versiones);
      final response = await client.get (
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      //print("response saveStudent...${response.body}");

      return Version.fromJson(json.decode(response.body));

    } catch (e) {
      Version entity = Version();
      return  entity;
    }
  }

  Future<List<Ubigeo>> post_Ubigeo(String imei) async {
    //final Map<String, dynamic> bodyData = {'codigoImei': imei.toString()};
    final Map<String, dynamic> bodyData = {'codigoImei': "40F79283FD021552"};
    try {
      print("iniciando postUbigeo...");
      Uri uri = Uri.parse(
          api_ubigeo);
      final response = await client.post (
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),

      );

      final Map<String, dynamic> data = jsonDecode(response.body);
      print("response ubigeo...${data['ubigeos']}");
      return Ubigeo.listFromJson(data['ubigeos']);

    } catch (e) {
      List<Ubigeo> ubi = List.empty();
      return  ubi;
    }
  }

}