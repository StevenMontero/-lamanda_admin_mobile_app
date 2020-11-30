import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/pet.dart';
import 'package:lamanda_admin/models/userProfile.dart';
import 'package:lamanda_admin/repository/user_repository.dart';

class DaycareAppt {
  String id;
  Timestamp departureDate;
  UserProfile departureUser;
  Timestamp entryDate;
  UserProfile entryUser;
  List<Pet> petList;
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

  DaycareAppt.fromJson(String id, UserProfile departureUser,
      UserProfile entryUser, List<Pet> petList, Map<String, dynamic> json) {
    this.id = id;
    this.departureDate = json['departureDate'];
    this.entryDate = json['entryDate'];
    this.transfer = json['transfer'];
    this.departureUser = departureUser;
    this.entryUser = entryUser;
    this.petList = petList;
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
