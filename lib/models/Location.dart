import 'dart:typed_data';

class Location {
  static const double size = 25;

  Location({this.titre, this.lat, this.long});

  String titre;
  String lat;
  String long;
}