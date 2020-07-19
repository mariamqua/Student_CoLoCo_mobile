import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_coloco_rest_api/route_generator.dart';
import 'package:student_coloco_rest_api/views/Auth/login.dart';
import 'package:student_coloco_rest_api/views/HomePage.dart';
import 'package:student_coloco_rest_api/views/menu/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
  void _checkIfLoggedIn() async{
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token!= null){
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _isLoggedIn ? HomePage() :  Login(),
      ),

    );
  }
}