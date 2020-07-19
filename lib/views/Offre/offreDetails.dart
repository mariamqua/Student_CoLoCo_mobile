
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_coloco_rest_api/helpers/Constant.dart';
import 'package:student_coloco_rest_api/models/Offre.dart';
import 'package:student_coloco_rest_api/models/Location.dart';
import 'package:student_coloco_rest_api/views/map/map_marker.dart';
import 'package:url_launcher/url_launcher.dart';


class OffreViewDetails extends StatelessWidget {
  final String offreName;
  final Offre offre;
  const OffreViewDetails({Key key, this.offreName, this.offre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          snap: true,
          floating: true,
          backgroundColor:Colors.white70,
          expandedHeight: 300,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          flexibleSpace: FlexibleSpaceBar(
            background: ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
              child: Image.network(
                  Constants.URl_IMAGES+offre.image,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ?
                      loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                    offre.titre,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  "\n \n 3000  MAD",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "${offre.capacite} personnes, Superficié : 600",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Tél  ${offre.tel}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Description : ",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                child: Text(
                  offre.description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              new Divider(),

              Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    elevation: 15.0,
                    padding: EdgeInsets.only(top: 6.0, bottom: 6.0,left: 6.0,right: 6.0),
                    child: Text(
                      'Ouvrir la localisation',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Location loc = new Location();
                      loc.titre = offre.titre;
                      print(loc.titre);

                      // loc.image = Base64Decoder().convert(offre.images);
                      loc.lat = offre.latitude;
                      loc.long = offre.longitude;

                      print(loc.lat);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              MarkerManager(monument: loc,)));
                    },
                  ),

                  RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    elevation: 15.0,
                    padding: EdgeInsets.only(top: 6.0, bottom: 6.0,left: 6.0,right: 6.0),
                    child: Text(
                      'Appeler',
                      style: TextStyle(color: Colors.white),
                    ),

                    onPressed: () {
                      launch("tel:" + offre.tel);
                    },
                  ),

                  RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    elevation: 15.0,
                    padding: EdgeInsets.only(top: 6.0, bottom: 6.0,left: 6.0,right: 6.0),
                    child: Text(
                      'Google maps',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      launch(
                          "https://maps.google.com/?q=" + offre.latitude + "," +
                              offre.longitude);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }
}