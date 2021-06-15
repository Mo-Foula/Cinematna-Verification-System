import 'dart:convert';

import 'package:cinematna_verification/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<dynamic> loginUser(String name, String jobTitle) async {
  final String apiUrl2 =
      "http://localhost/Project/Final%20Project/verification%20system/admin_login_api.php";
  final String apiUrl = "https://reqres.in/api/users";


  // final response = await http.post(Uri.https("reqres.in", "/api/users"),
  // print('craaaaaaaaaaaaaaaaaaaaaaaaaash');
  final response = await http.post(Uri.https("cinematna.000webhostapp.com",
      "/verification system/admin_login_api.php"),

    body: jsonEncode(<String, String>{"user": name, "pass": jobTitle}),
    headers: <String, String>{
      'Content-Type':
      'application/json; charset=UTF-8',
      // 'Access-Control-Allow-Origin': ' *'
    },
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    print(userModelFromJson(responseString).cinema_name);
    print('Success');

    // print(responseString['message']);
    // return jsonDecode(responseString);
    return [userModelFromJson(responseString), 200];
  } else {
    // print('craaaaaaaaaaaaaaaaaaaaaaaaaash');
    // print(response.statusCode);
    // print(response.request);
    // print(response.headers);
    // print(response.body);
    return [null, response.statusCode];
    // print(welcomeFromJson(response.body));
  }
}
