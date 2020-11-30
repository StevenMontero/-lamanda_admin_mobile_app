import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/pet.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class EstheticAppt {
  String id;
  Timestamp dateTime;
  List<Pet> petList;
  UserProfile user;
  bool isConfirmed;

  EstheticAppt(
      {this.id, this.dateTime, this.petList, this.user, this.isConfirmed});

  EstheticAppt.fromJson(String id, UserProfile user, List<Pet> petList,
      Map<String, dynamic> json) {
    this.id = id;
    this.dateTime = json['date'];
    this.petList = petList;
    this.user = user;
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
