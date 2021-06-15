import 'dart:convert';

import 'package:cinematna_verification/model/ticket_model.dart';
import 'package:cinematna_verification/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<dynamic> checkTicket(String ticketNumber) async {
  final String apiUrl2 =
      "http://localhost/Project/Final%20Project/verification%20system/admin_login_api.php";
  final String apiUrl = "https://reqres.in/api/users";

  final response = await http.post(Uri.https("cinematna.000webhostapp.com", "/verification system/check_ticket_api.php"),

    body: jsonEncode(<String, String>{"num": ticketNumber}),
    headers: <String, String>{
      'Content-Type':
      'application/json; charset=UTF-8',
      // 'Access-Control-Allow-Origin': ' *'
    },
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;

    print('Success');

    // print(responseString['message']);
    // return jsonDecode(responseString);
    return ticketModelFromJson(responseString);
  } else {
    print('craaaaaaaaaaaaaaaaaaaaaaaaaash');
    print(response.statusCode);
    print(response.request);
    print(response.headers);
    print(response.body);
    return null;
    // print(welcomeFromJson(response.body));
  }

}
