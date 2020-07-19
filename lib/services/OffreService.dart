import 'dart:convert';
import 'package:http/http.dart';
import 'package:student_coloco_rest_api/helpers/Constant.dart';
import 'package:student_coloco_rest_api/models/Offre.dart';

class OffreService {
  final String URL = Constants.API_ADDRESS + "offres";
  Client client = Client();

  Future<List<Offre>> getOffres() async {
    Response res = await get(URL);
    if (res.statusCode == 200) {
      print('---------------1-------------------');
      List<dynamic> body = jsonDecode(res.body);
      print('----------2-----------' );
      List<Offre> offres = body.map((dynamic item) => Offre.fromJson(item)).toList();
      print('-------3--------------');
      return offres;
    } else {
      throw "Can't get offres.";
    }
  }

  Future<bool> createOffre(Offre data) async {

    final response = await client.post(URL,
      headers: {"content-type": "application/json"},
      body: OffreToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

}