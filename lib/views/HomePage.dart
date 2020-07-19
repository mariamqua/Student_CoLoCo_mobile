import 'package:flutter/material.dart';
import 'package:student_coloco_rest_api/views/Demande/DemandesPage.dart';
import 'package:student_coloco_rest_api/views/Offre/OffrePage.dart';
import 'package:student_coloco_rest_api/views/menu/menu.dart';
import 'package:student_coloco_rest_api/views/userDemande/Demandes.dart';
import 'package:student_coloco_rest_api/views/userOffre/Offres.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Coloco',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Accueil',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Montserrat', fontSize: 17.0),
          ),
          backgroundColor: Colors.greenAccent,
        ),
        drawer: Menu(),
        body: Stack(
          children: <Widget>[
            Container(
              child: CustomPaint(
                child: Container(
                  color: Color(0xFFEEEEEE),
                  height: size.height / 2,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70),
              color: Color(0xFFEEEEEE),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    createGridItem(0, "Demandes", 'assets/images/demandes.png'),
                    createGridItem(1, "Offres", 'assets/images/offres.png'),
                    createGridItem(
                        2, "Mes Demandes", 'assets/images/mesdemandes.png'),
                    createGridItem(
                        3, "Mes Offres", 'assets/images/mesoffres.png'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createGridItem(int position, String title, String imgPath) {
    return Builder(builder: (context) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
        child: Card(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.white),
          ),
          child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    // With MaterialPageRoute, you can pass data between pages,
                    // but if you have a more complex app,   will quickly get lost.
                    MaterialPageRoute(
                  builder: (context) =>
                      //FirstPage()
                      //This is condition [Position] indicates wich page you want to navigate to
                      position == 0
                          ? DemandePage()
                          : position == 1
                              ? OffrePage()
                              : position == 2
                                  ? DemandeUserPage()
                                  : position == 3 ? OffreUserPage() : Menu(),
                ));
              },
              child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Image.asset(imgPath, height: 100, fit: BoxFit.cover),
                      SizedBox(height: 10.0),
                      Container(
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontSize: 17.0),
                        ),
                      ),
                  ],
              ))),
        ),
      );
    });
  }
}
