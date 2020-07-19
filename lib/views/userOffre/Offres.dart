import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:student_coloco_rest_api/helpers/Constant.dart';
import 'package:student_coloco_rest_api/helpers/colorAndTextStyle.dart';
import 'package:student_coloco_rest_api/models/Offre.dart';
import 'package:student_coloco_rest_api/services/OffreService.dart';
import 'package:student_coloco_rest_api/views/Offre/formOffre.dart';
import 'package:student_coloco_rest_api/views/Offre/offreDetails.dart';
import 'package:flutter/material.dart';

class OffreUserPage extends StatefulWidget {
  @override
  _OffreUserScreenState createState() => _OffreUserScreenState();
}

class _OffreUserScreenState extends State<OffreUserPage> {
  final controller = ScrollController();
  final OffreService offreService = OffreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Les offres',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Montserrat', fontSize: 17.0),
        ),
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
            future: offreService.getOffres(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Offre>> snapshot) {
              if (snapshot.hasData) {
                List<Offre> offres = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      itemCount: offres.length,

                      itemBuilder: (BuildContext context, int index) {
                        return Stack(children: <Widget>[

                          offreCard(offre: offres[index], context: context),
                        ]);
                      }),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddOffre()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

Widget offreCard({Offre offre, BuildContext context}) {
  return Padding(
      padding: const EdgeInsets.only(top: 8.0),

      child: new Card(
        margin:
        new EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4,
        child:  InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      // 4
                        image: NetworkImage(
                            Constants.URl_IMAGES+offre.image),
                        fit: BoxFit.contain)
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: Column(
                    children: <Widget>[

                      Text("\n "+offre.titre,
                        style: TextStyle(
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                          child: Container(
                            child: Text(

                              " Prix:" +
                                  "3000 MAD \n Capacité :"+offre.capacite.toString() + " personnnes"
                                  + "\n Superficié: 600" ,
                              style: TextStyle(
                                color: Colors.black38,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                          )

                      ),

                    ],

                  ),

                ),


              )
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OffreViewDetails(
                      offre: offre,
                      offreName: offre.titre,
                    )
                )
            );
          },
        ),

      )

  );
}





