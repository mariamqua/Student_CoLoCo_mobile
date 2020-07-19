import 'package:flutter/material.dart';
import 'package:student_coloco_rest_api/views/Demande/DemandesPage.dart';
import 'package:student_coloco_rest_api/views/HomePage.dart';
import 'package:student_coloco_rest_api/views/Offre/OffrePage.dart';
import 'package:student_coloco_rest_api/views/userDemande/Demandes.dart';
import 'package:student_coloco_rest_api/views/userOffre/Offres.dart';


class Menu extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(

        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(6),
              color: Colors.grey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 10),
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/colocation.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      "Colocation",
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Accueil'),
              focusColor: Colors.grey,
              dense: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile( 
              leading: Icon(Icons.announcement),
              title: Text('Les Offres'),
              dense: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OffrePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.announcement),
              title: Text('Les Demandes'),
              dense: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DemandePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.announcement),
              title: Text('Mes demandes'),
              dense: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DemandeUserPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.announcement),
              title: Text('Mes offres'),
              dense: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OffreUserPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Se déconnecter'),
              dense: true,
             /* onTap: () async {
                await _auth.signOut();

                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushReplacement(
                    context, MaterialPageRoute(
                    builder: (BuildContext context) => Login()));
              },*/
            ),
          ],
        ));
  }
}
