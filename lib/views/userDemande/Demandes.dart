import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:student_coloco_rest_api/models/Demande.dart';
import 'package:student_coloco_rest_api/models/User.dart';
import 'package:student_coloco_rest_api/services/DemandeService.dart';
import 'package:student_coloco_rest_api/views/Demande/DemandeDetails.dart';
import 'package:flutter/material.dart';
import 'package:student_coloco_rest_api/views/Demande/formDemande.dart';

class DemandeUserPage extends StatefulWidget {
  @override
  _DemandeUserScreenState createState() => _DemandeUserScreenState();
}

class _DemandeUserScreenState extends State<DemandeUserPage> {
  final controller = ScrollController();
  final DemandeService demandeService = DemandeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text('Mes demandes',
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
               // final u = Provider.of<User>(context);

                /*for (var demande in demandes) {
                  if (demande.user_id == 1) demandes.add(demande);
                }*/
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DemandeAddScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
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
            subtitle:Text("Budget max: "+demande.budjetmax +" DH"),

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