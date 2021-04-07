import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class EstheticAppt extends Appointment {
  String? fur;
  
  Timestamp? entryHour;

  EstheticAppt(
      String id,
      Timestamp entryDate,
      UserProfile entryUser,
      bool isConfirmed,
      bool transfer,
      String direction,
      String fur,
      Timestamp entryHour) {
    this.id = id;
    this.entryDate = entryDate;
    this.entryUser = entryUser;
    this.isConfirmed = isConfirmed;
    this.transfer = transfer;
    this.direction = direction;
    this.fur = fur;
    this.entryHour = entryHour;
  }

  EstheticAppt.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.entryDate = json['entryDate'];
    this.entryHour = json['entryHour'];
    this.entryUser = UserProfile.fromJson(json['entryUser']);
    this.isConfirmed = json['isConfirmed'];
    this.transfer = json['transfer'];
    this.direction = json["direction"];
    this.fur = json['fur'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'entryDate': this.entryDate,
      'entryUser': this.entryUser!.toJson(),
      'isConfirmed': this.isConfirmed,
      'transfer': this.transfer,
      'direction': this.direction,
      'fur': this.fur,
      'entryHour': this.entryHour
    };
  }
}
