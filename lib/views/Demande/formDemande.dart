import 'package:flutter/material.dart';
import 'package:student_coloco_rest_api/models/Demande.dart';
import 'package:student_coloco_rest_api/services/DemandeService.dart';
import 'package:student_coloco_rest_api/views/Demande/DemandesPage.dart';
import 'package:student_coloco_rest_api/views/userDemande/Demandes.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class DemandeAddScreen extends StatefulWidget {
  Demande demande;

  DemandeAddScreen({this.demande});

  @override
  _DemandeAddScreenState createState() => _DemandeAddScreenState();
}

class _DemandeAddScreenState extends State<DemandeAddScreen> {

  final DemandeService _demandeService = new DemandeService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String description = '';
  String tel = '';
  String titre = '';
  double budjet;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Ajouter une demande',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Montserrat', fontSize: 14.0),
          ),
          backgroundColor: Colors.greenAccent,
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Budjet maximum *',
                  ),
                  validator: (val) =>
                  val.isEmpty
                      ? 'Saisir votre budjet'
                      : null,
                  onChanged: (val) {
                    setState(() => budjet = double.parse(val));
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tél *',
                  ),
                  validator: (val) => val.isEmpty ? 'Saisir votre num' : null,
                  onChanged: (val) {
                    setState(() => tel = val);
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Décrivez le logement recherché *',
                  ),
                  validator: (val) =>
                  val.isEmpty ?
                  'Saisir la discription sur le logement'
                      : null,
                  onChanged: (val) {
                    setState(() => description = val);
                  },
                ),

                RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'Ajouter la demande',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Demande demande = new Demande(titre: titre,
                          description: description,
                          budjetmax: budjet.toString(),
                          tel: tel,
                          user_id: 1);
                      if (widget.demande == null) {
                        _demandeService.createDemande(demande).then((
                            isSuccess) {
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Demande ajouté"),
                            ));
                          }
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DemandeUserPage())
                        );
                      }
                    }
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

