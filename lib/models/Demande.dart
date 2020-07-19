import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Demande {
  String titre;
  String budjetmax;
  String description;
  String tel;
  int user_id;
  int id;

  Demande({
    @required this.titre,
    @required this.budjetmax,
    @required this.description,
    @required this.id,
    @required this.tel,
    @required this.user_id,
  });

  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      titre: json['titre'] as String,
      description: json['description'] as String,
      budjetmax: json['budjetmax'] as String,
      user_id: json['user_id'] as int,
      id: json['id'] as int,
      tel: json['tel'] as String,

    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "titre": titre, "description": description, "budjetmax": budjetmax, "user_id":user_id,'tel':tel};
  }
}
  List<Demande> DemandeFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Demande>.from(data.map((item) => Demande.fromJson(item)));
  }

  String DemandeToJson(Demande data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }
