import 'package:cloud_firestore/cloud_firestore.dart';

class EstheticAppt {
  String id;
  Timestamp dateTime;
  Map petList;
  DocumentReference user;
  bool isConfirmed;

  EstheticAppt(
      {this.id, this.dateTime, this.petList, this.user, this.isConfirmed});

  EstheticAppt.fromJson(String id, Map<String, dynamic> json) {
    this.id = id;
    this.dateTime = json['date'];
    this.petList = json['petList'];
    this.user = json['user'];
    this.isConfirmed = json['isConfirmed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': this.dateTime,
      'petList': this.petList,
      'user': this.user,
      'isConfirmed': this.isConfirmed
    };
  }
}
