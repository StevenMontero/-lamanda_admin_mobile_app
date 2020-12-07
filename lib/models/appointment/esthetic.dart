import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';

class EstheticAppt extends Appointment {
  EstheticAppt(
      String id,
      Timestamp entryDate,
      DocumentReference entryUser,
      bool isConfirmed,
      bool transfer,
      String direction) {
    this.id = id;
    this.entryDate = entryDate;
    this.entryUser = entryUser;
    this.isConfirmed = isConfirmed;
    this.transfer = transfer;
    this.direction = direction;
  }

  EstheticAppt.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.entryDate = json['entryDate'];
    this.entryUser = json['entryUser'];
    this.isConfirmed = json['isConfirmed'];
    this.transfer = json['transfer'];
    this.direction = json["direction"];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'entryDate': this.entryDate,
      'entryUser': this.entryUser,
      'isConfirmed': this.isConfirmed,
      'transfer': this.transfer,
      'direction': this.direction
    };
  }
}
