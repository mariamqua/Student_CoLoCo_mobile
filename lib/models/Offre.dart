import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Offre {
  String titre;
  String description;
  int user_id;
  int id;
  String adresse;
  String superficie;
  String prix;
  int capacite;
  String image;
  String latitude;
  String longitude;
  String tel;

  Offre({
    @required this.titre,
    @required this.adresse,
    @required this.capacite,
    @required this.prix,
    @required this.superficie,
    @required this.description,
    @required this.id,
    @required this.user_id,
    @required this.latitude,
    @required this.image,
    @required this.longitude,
    @required this.tel
  });

  factory Offre.fromJson(Map<String, dynamic> json) {
    return Offre(
      titre: json['titre'] as String,
      description: json['description'] as String,
      adresse: json['adresse'] as String,
      prix: json['prix'] as String,
      superficie: json['superficie'] as String,
      capacite: json['capacite'] as int,
      user_id: json['user_id'] as int,
      id: json['id'] as int,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      tel: json['tel'] as String,
      image: json['image'] as String,

    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "titre": titre , "adresse": adresse, "description": description, "prix": prix,
      "user_id":user_id,"capacite":capacite,"latitude":latitude, "longitude":longitude,"superficie":superficie,
      "tel":tel,"image":image};
  }
  }
  List<Offre> OffreFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Offre>.from(data.map((item) => Offre.fromJson(item)));
  }

  String OffreToJson(Offre data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }