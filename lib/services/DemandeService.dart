import 'package:http/http.dart';
import 'package:student_coloco_rest_api/helpers/Constant.dart';
import 'package:student_coloco_rest_api/models/Demande.dart';
import 'dart:async';
import 'dart:convert';

class DemandeService {
  final String URL = Constants.API_ADDRESS + "demandes";
  Client client = Client();

  Future<List<Demande>> getDemandes() async {
    Response res = await get(URL);
    if (res.statusCode == 200) {
      print('---------------1-------------------');
      List<dynamic> body = jsonDecode(res.body);
      print('----------2-----------');
      List<Demande> demandes = body.map((dynamic item) =>
          Demande.fromJson(item)).toList();
      print('-------3--------------');
      return demandes;
    } else {
      throw "Can't get demandes.";
    }
  }

  Future<bool> createDemande(Demande data) async {

    final response = await client.post(URL,
      headers: {"content-type": "application/json"},
      body: DemandeToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateDemande(Demande data) async {
    final response = await client.put(
      "$URL/${data.id}",
      headers: {"content-type": "application/json"},
      body: DemandeToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteDemande(int id) async {
    final response = await client.delete(
      "$URL/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}