import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';

class EstheticAppt extends Appointment {
  EstheticAppt(
      String id,
      Timestamp entryDate,
      Map petList,
      DocumentReference entryUser,
      bool isConfirmed,
      bool transfer,
      bool declined,
      String direction) {
    this.id = id;
    this.entryDate = entryDate;
    this.petList = petList;
    this.entryUser = entryUser;
    this.isConfirmed = isConfirmed;
    this.transfer = transfer;
    this.declined = declined;
    this.direction = direction;
  }

  EstheticAppt.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.entryDate = json['entryDate'];
    this.petList = json['petList'];
    this.entryUser = json['entryUser'];
    this.isConfirmed = json['isConfirmed'];
    this.transfer = json['transfer'];
    this.declined = json["declined"];
    this.direction = json["direction"];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'entryDate': this.entryDate,
      'petList': this.petList,
      'entryUser': this.entryUser,
      'isConfirmed': this.isConfirmed,
      'transfer': this.transfer,
      'declined': this.declined,
      'direction': this.direction
    };
  }
}
