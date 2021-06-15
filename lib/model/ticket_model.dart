// To parse this JSON data, do
//
//     final ticketModel = ticketModelFromJson(jsonString);

import 'dart:convert';

TicketModel ticketModelFromJson(String str) => TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
  TicketModel({
    this.status,
    this.message,
    this.seatsLetters,
    this.partyStart,
    this.bookingName,
    this.partyDate,
  });

  int status;
  String message;
  List<String> seatsLetters;
  String partyStart;
  String bookingName;
  DateTime partyDate;

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
    status: json["status"],
    message: json["message"],
    seatsLetters: List<String>.from(json["seats_letters"].map((x) => x)),
    partyStart: json["party_start"],
    bookingName: json["booking_name"],
    partyDate: DateTime.parse(json["party_date"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "seats_letters": List<dynamic>.from(seatsLetters.map((x) => x)),
    "party_start": partyStart,
    "booking_name": bookingName,
    "party_date": "${partyDate.year.toString().padLeft(4, '0')}-${partyDate.month.toString().padLeft(2, '0')}-${partyDate.day.toString().padLeft(2, '0')}",
  };
}
