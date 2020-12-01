import 'package:cloud_firestore/cloud_firestore.dart';

class DaycareAppt {
  String id;
  Timestamp departureDate;
  String departureUser;
  Timestamp entryDate;
  DocumentReference entryUser;
  Map petList;
  bool transfer;
  bool isConfirmed;

  DaycareAppt(
      {this.id,
      this.departureDate,
      this.departureUser,
      this.entryDate,
      this.entryUser,
      this.petList,
      this.transfer,
      this.isConfirmed});

  DaycareAppt.fromJson(String id, Map<String, dynamic> json) {
    this.id = id;
    this.departureDate = json['departureDate'];
    this.entryDate = json['entryDate'];
    this.transfer = json['transfer'];
    this.departureUser = json['departureUser'];
    this.entryUser = json['entryUser'];
    this.petList = json['petList'];
    this.isConfirmed = json['isConfirmed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'departureDate': this.departureDate,
      'departureUser': this.departureUser,
      'entryDate': this.entryDate,
      'entryUser': this.entryUser,
      'petList': this.petList,
      'transfer': this.transfer,
      'isConfirmed': this.isConfirmed
    };
  }
}
