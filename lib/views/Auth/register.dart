import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_coloco_rest_api/helpers/colorAndTextStyle.dart';
import 'package:student_coloco_rest_api/services/AuthService.dart';
import 'package:student_coloco_rest_api/views/HomePage.dart';

import 'login.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //TextEditingController firstNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController NameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            /////////////  background/////////////
            new Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.4, 0.9],
                  colors: [
                    kInfectedColor,
                    kPrimaryColor,
                    kLightColor,
                  ],
                ),
              ),
            ),

            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /////////////// name////////////
                            TextField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: NameController,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                hintText: "Name",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            /////////////// Email ////////////
                            TextField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: mailController,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.grey,
                                ),
                                hintText: "Email ",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            /////////////// password ////////////
                            TextField(
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),


                            /////////////// SignUp Button ////////////
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isLoading ? 'Creating...' : 'Create account',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  color: kDarkColor,
                                  disabledColor: Colors.grey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(20.0)),
                                  onPressed: _isLoading ? null :  _handleLogin
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /////////////// already have an account ////////////
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Déjà sur Coloco ? ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF616161),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    FlatButton(
                      child: new Text("S'identifier ",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),),
                      onPressed: () {
                        // ignore: unnecessary_statements
                        (context) => Login();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'name' : NameController.text,
      'email' : mailController.text,
      'password' : passwordController.text,
    };

    var res = await AuthService().postData(data, 'register');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => HomePage()));
    }

    setState(() {
      _isLoading = false;
    });
  }
}