
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_coloco_rest_api/helpers/Constant.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {

  postData(data, apiUrl) async {
    var fullUrl =Constants.API_ADDRESS + apiUrl + await _getToken();
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }
  getData(apiUrl) async {
    var fullUrl = Constants.API_ADDRESS + apiUrl + await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}