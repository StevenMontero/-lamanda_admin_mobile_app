import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class VeterinaryAppt {
  String id;
  Timestamp dateTime;
  String symptoms;
  UserProfile user;

  VeterinaryAppt({this.id, this.dateTime, this.symptoms, this.user});

  VeterinaryAppt.fromJson(
      String id, UserProfile user, Map<String, dynamic> json) {
    this.id = id;
    this.dateTime = json['dateTime'];
    this.symptoms = json['symptoms'];
    this.user = user;
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': this.dateTime,
      'symptoms': this.symptoms,
      'user': this.user,
    };
  }
}
