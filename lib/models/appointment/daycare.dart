import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/apptStay.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class DaycareAppt extends ApptStay {
  Timestamp? entryHour;
  DaycareAppt(
      String id,
      Timestamp departureDate,
      String departureUser,
      Timestamp entryDate,
      UserProfile entryUser,
      bool transfer,
      bool isConfirmed,
      String direction,
      bool isCastrated,
      bool isSociable,
      bool isVaccinationUpDate,
      Timestamp lastDeworming,
      Timestamp lastProtectionFleas,
      String race,
      int age,
      Timestamp entryHour) {
    this.id = id;
    this.departureDate = departureDate;
    this.departureUser = departureUser;
    this.entryDate = entryDate;
    this.entryUser = entryUser;
    this.transfer = transfer;
    this.isConfirmed = isConfirmed;
    this.direction = direction;

    this.isCastrated = isCastrated;
    this.isSociable = isSociable;
    this.isVaccinationUpDate = isVaccinationUpDate;
    this.lastDeworming = lastDeworming;
    this.lastProtectionFleas = lastProtectionFleas;
    this.race = race;
    this.age = age;

    this.entryHour = entryHour;
  }

  DaycareAppt.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.departureDate = json['departureHour'];
    this.entryDate = json['date'];
    this.transfer = json['transfer'];
    this.departureUser = json['userPickup'];
    this.entryUser = UserProfile.fromJson(json['userDeliver']);
    this.isConfirmed = json['isConfirmed'];
    this.direction = json["direction"];

    this.isCastrated = json['isCastrated'];
    this.isSociable = json['isSociable'];
    this.isVaccinationUpDate = json['isVaccinationUpDate'];
    this.lastDeworming = json['lastDeworing'];
    this.lastProtectionFleas = json['lastProtectionFleas'];
    this.race = json['race'];
    this.age = json['age'];

    this.entryHour = json['entryHour'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'departureHour': this.departureDate,
      'userPickup': this.departureUser,
      'date': this.entryDate,
      'userDeliver': this.entryUser!.toJson(),
      'transfer': this.transfer,
      'isConfirmed': this.isConfirmed,
      'direction': this.direction,
      'isCastrated': this.isCastrated,
      'isSociable': this.isSociable,
      'isVaccinationUpDate': this.isVaccinationUpDate,
      'lastDeworing': this.lastDeworming,
      'lastProtectionFleas': this.lastProtectionFleas,
      'race': this.race,
      'age': this.age,
      'entryHour': this.entryHour,
    };
  }
}
