import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:tayta/model/t_padron.dart';


class apiprovider_padron {


  //final BASE_URL = "https://padron.free.beeceptor.com";
  final client = GetIt.I.get<Client>();
  final api_versiones = "https://padron.free.beeceptor.com";

  Future<Padron> get_padron() async {
    try {
      print("iniciando PadronObtención...");
      Uri uri = Uri.parse(
          api_versiones);
      final response = await client.get (
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      print("response PADRON...${response.body}");

      final data = response.body;

      return Padron.fromJson(json.decode(data));


    } catch (e) {
      Padron Model = Padron();
      return  Model;
    }
  }


  Future<List<Padron>> get_padronLIST() async {
    try {
      print("iniciando PadronObtención...");
      Uri uri = Uri.parse(
          api_versiones);
      final response = await client.get (
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      print("response PADRON...${response.body}");
      return Padron.listFromJson(json.decode(response.body));


    } catch (e) {
      List<Padron> Model = List.empty();
      return  Model;
    }
  }


  /*
  Future<padronModel> get_padron() async {
    try {
      print("iniciando PadronObtención...");
      Uri uri = Uri.parse(
          api_versiones);
      final response = await client.get (
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      print("response PADRON...${response.body}");

      final data = response.body;

      return padronModel.fromJson(json.decode(data));


    } catch (e) {
      padronModel Model = padronModel();
      return  Model;
    }
  }


  Future<List<padronModel>> get_padronLIST() async {
    try {
      print("iniciando PadronObtención...");
      Uri uri = Uri.parse(
          api_versiones);
      final response = await client.get (
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      print("response PADRON...${response.body}");

      return padronModel.listFromJson(json.decode(response.body));


    } catch (e) {
      List<padronModel> Model = List.empty();
      return  Model;
    }
  }

   */

}