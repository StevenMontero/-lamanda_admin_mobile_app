import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';

class DaycareAppt extends Appointment {
  Timestamp departureDate;
  String departureUser;

  DaycareAppt(
      String id,
      Timestamp departureDate,
      String departureUser,
      Timestamp entryDate,
      DocumentReference entryUser,
      Map petList,
      bool transfer,
      bool isConfirmed,
      bool declined,
      String direction) {
    this.id = id;
    this.departureDate = departureDate;
    this.departureUser = departureUser;
    this.entryDate = entryDate;
    this.entryUser = entryUser;
    this.petList = petList;
    this.transfer = transfer;
    this.isConfirmed = isConfirmed;
    this.declined = declined;
    this.direction = direction;
  }

  DaycareAppt.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.departureDate = json['departureDate'];
    this.entryDate = json['entryDate'];
    this.transfer = json['transfer'];
    this.departureUser = json['departureUser'];
    this.entryUser = json['entryUser'];
    this.petList = json['petList'];
    this.isConfirmed = json['isConfirmed'];
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
      'petList': this.petList,
      'transfer': this.transfer,
      'isConfirmed': this.isConfirmed,
      'declined': this.declined,
      'direction': this.direction
    };
  }
}
