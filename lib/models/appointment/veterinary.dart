import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class VeterinaryAppt {
  String id;
  Timestamp dateTime;
  String symptoms;
  UserProfile user;
  bool isConfirmed;

  VeterinaryAppt(
      {this.id, this.dateTime, this.symptoms, this.user, this.isConfirmed});

  VeterinaryAppt.fromJson(
      String id, UserProfile user, Map<String, dynamic> json) {
    this.id = id;
    this.dateTime = json['date'];
    this.symptoms = json['symptoms'];
    this.user = user;
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
