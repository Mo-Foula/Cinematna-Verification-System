// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

User_Model userModelFromJson(String str) => User_Model.fromJson(json.decode(str));

// String userModelToJson(User_Model data) => json.encode(data.toJson());

class User_Model {
  User_Model({
    this.admin_id,
    this.cinema_id,
    this.cinema_name,
  });

  String admin_id;
  String cinema_id;
  String cinema_name;

  factory User_Model.fromJson(Map<String, dynamic> json) => User_Model(
    admin_id: json["admin_id"],
    cinema_id: json["cinema_id"],
    cinema_name: json["cinema_name"],
  );

  // Map<String, dynamic> toJson() => {
  //   "name": user,
  //   "job": cinema_id,
  // };
}
