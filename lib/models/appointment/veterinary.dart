import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class VeterinaryAppt extends Appointment {
  String symptoms;
  String race;

  VeterinaryAppt(
      String id,
      Timestamp entryDate,
      Map petList,
      UserProfile entryUser,
      bool isConfirmed,
      bool transfer,
      String direction,
      String race) {
    this.id = id;
    this.entryDate = entryDate;
    this.entryUser = entryUser;
    this.isConfirmed = isConfirmed;
    this.transfer = transfer;
    this.direction = direction;
    this.race = race;
  }

  VeterinaryAppt.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.entryDate = json['entryDate'];
    this.symptoms = json['symptoms'];
    this.entryUser = UserProfile.fromJson(json['entryUser']);
    this.isConfirmed = json['isConfirmed'];
    this.transfer = json['transfer'];
    this.direction = json["direction"];
    this.race = json['race'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'entryDate': this.entryDate,
      'symptoms': this.symptoms,
      'entryUser': this.entryUser.toJson(),
      'isConfirmed': this.isConfirmed,
      'direction': this.direction,
      'race': this.race
    };
  }
}
