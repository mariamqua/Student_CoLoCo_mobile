import 'package:flutter/cupertino.dart';
import 'package:student_coloco_rest_api/helpers/colorAndTextStyle.dart';
import 'package:student_coloco_rest_api/models/Demande.dart';
import 'package:student_coloco_rest_api/services/DemandeService.dart';
import 'package:student_coloco_rest_api/widgets/my_header.dart';
import 'package:flutter/material.dart';

import 'DemandeDetails.dart';

class DemandePage extends StatefulWidget {
  @override
  _DemandeScreenState createState() => _DemandeScreenState();
}

class _DemandeScreenState extends State<DemandePage> {
  final controller = ScrollController();
  final DemandeService demandeService = DemandeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text('Les demandes',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 17.0),
        ),
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          FutureBuilder(
            future: demandeService.getDemandes(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Demande>> snapshot) {
              if (snapshot.hasData) {
                List<Demande> demandes = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      itemCount: demandes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(children: <Widget>[
                          eventCard(demande: demandes[index], context: context),

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
    );
  }
}
  Widget eventCard({Demande demande, BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: new EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child:new Padding(
          padding: new EdgeInsets.all(5.0),
          child: ListTile(
            leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,

                child: Image.network("https://static.thenounproject.com/png/540038-200.png",
                )
            ),

            title:  Text(demande.titre) ,
            subtitle:Text("Budget max: "+demande.budjetmax.toString() +" DH"),

            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DemandeViewDetails(
                        demande: demande,
                        demandeName: demande.titre,
                      )));
            },
          ),
        ),

      ),
    );
  }