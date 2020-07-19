import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_coloco_rest_api/helpers/colorAndTextStyle.dart';
import 'package:student_coloco_rest_api/models/Demande.dart';
import 'package:student_coloco_rest_api/views/menu/menu.dart';


class DemandeViewDetails extends StatelessWidget {
  final String demandeName;
  final Demande demande;

  const DemandeViewDetails({Key key, this.demandeName, this.demande})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color:Colors.white,
        child: new Stack (
          children: <Widget>[
            _getContent(),
          ],
        ),
      ),
    );
  }


  Container _getContent() {
    final _overviewTitle = "Description".toUpperCase();
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          new demandeSummary(demande,
            horizontal: false,
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_overviewTitle,
                  ),
                new Separator(),
                new Text(
                    demande.description),
                new Text("\n Tél : "),
                new Text(demande.tel),
                new Text("\n Budjet max : "),
                new Text(demande.budjetmax),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: 18.0,
        color: kDeathColor
    );
  }
}


class demandeSummary extends StatelessWidget {

  final Demande demande;
  final bool horizontal;

  demandeSummary(this.demande, {this.horizontal = true});

  demandeSummary.vertical(this.demande): horizontal = false;


  @override
  Widget build(BuildContext context) {




    final demandeCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Text(demande.titre,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
                fontSize: 18.0,
                fontWeight: FontWeight.w600
            ),
          ),
          new Container(height: 10.0),
          new Text(demande.budjetmax +" MAD"),
          new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new Container (
                width: 32.0,
              ),

            ],
          ),
        ],
      ),
    );


    final demandeCard = new Container(
      child: demandeCardContent,
      height: horizontal ? 4.0 : 154.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 6.0)
          : new EdgeInsets.only(top: 0.0),
      decoration: new BoxDecoration(
        color: kLightColor,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new GestureDetector(
        onTap: horizontal
            ? () => Navigator.of(context).push(
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new DemandeViewDetails(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
          ) ,
        )
            : null,
        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              demandeCard,

            ],
          ),
        )
    );
  }
}