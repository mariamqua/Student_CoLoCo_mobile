import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_coloco_rest_api/helpers/Constant.dart';
import 'package:student_coloco_rest_api/helpers/colorAndTextStyle.dart';
import 'package:student_coloco_rest_api/services/AuthService.dart';
import 'package:student_coloco_rest_api/views/Auth/register.dart';
import 'package:student_coloco_rest_api/views/HomePage.dart';

class Login extends StatefulWidget {

  final Function toggleView;
  Login({ this.toggleView });

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  bool _isLoading = false;


  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScaffoldState scaffoldState;
  _showMsg(msg) { //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            ///////////  background///////////
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
                            /////////////  Email//////////////
                            TextField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: mailController,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            /////////////// password////////////////////
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
                            /////////////  LogIn Botton///////////////////
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 10, right: 10),
                                  child: Text(
                                    _isLoading? 'Loging...' : 'Login',
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
                                onPressed: _isLoading ? null : _login,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ////////////   new account///////////////

                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Pas encore inscrit ? ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF616161),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    FlatButton(
                      child: new Text("S'inscrire",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Register()));
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

  void _login() async{

    setState(() {
      _isLoading = true;
    });

    var data = {
      'email' : mailController.text,
      'password' : passwordController.text
    };

    var res = await AuthService().postData(data, 'login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => HomePage()));
    }else{
      _showMsg(body['message']);
    }
    setState(() {
      _isLoading = false;
    });
  }
}