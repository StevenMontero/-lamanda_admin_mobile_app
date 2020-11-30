import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class VeterinaryAppt {
  String id;
  Timestamp dateTime;
  String symptoms;
  DocumentReference user;
  bool isConfirmed;

  VeterinaryAppt(
      {this.id, this.dateTime, this.symptoms, this.user, this.isConfirmed});

  VeterinaryAppt.fromJson(String id, Map<String, dynamic> json) {
    this.id = id;
    this.dateTime = json['date'];
    this.symptoms = json['symptoms'];
    this.user = json['user'];
    this.isConfirmed = json['isConfirmed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': this.dateTime,
      'symptoms': this.symptoms,
      'user': this.user,
      'isConfirmed': this.isConfirmed
    };
  }
}
