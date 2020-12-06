import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';
import 'package:lamanda_admin/models/appointment/apptStay.dart';

class HotelAppt extends ApptStay {
  HotelAppt(
      String id,
      Timestamp departureDate,
      String departureUser,
      Timestamp entryDate,
      DocumentReference entryUser,
      bool transfer,
      bool isConfirmed,
      bool declined,
      String direction) {
    this.id = id;
    this.departureDate = departureDate;
    this.departureUser = departureUser;
    this.entryDate = entryDate;
    this.entryUser = entryUser;
    this.transfer = transfer;
    this.isConfirmed = isConfirmed;
    this.declined = declined;
    this.direction = direction;
  }

  HotelAppt.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.departureDate = json['departureDate'];
    this.entryDate = json['entryDate'];
    this.transfer = json['transfer'];
    this.isConfirmed = json['isConfirmed'];

    this.departureUser = json['departureUser'];
    this.entryUser = json['entryUser'];
    this.declined = json["declined"];
    this.direction = json["direction"];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'departureDate': this.departureDate,
      'departureUser': this.departureUser,
      'entryDate': this.entryDate,
      'entryUser': this.entryUser,
      'transfer': this.transfer,
      'isConfirmed': this.isConfirmed,
      'declined': this.declined,
      'direction': this.direction
    };
  }
}
