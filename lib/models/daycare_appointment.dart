//import 'package:lamanda_petshopcr/src/models/pet.dart';
//import 'package:lamanda_petshopcr/src/models/pet_list.dart';
import 'package:lamanda_admin/models/userProfile.dart';
import 'package:lamanda_admin/models/pet.dart';

class DaycareAppointment {
  String? appointmentId;
  DateTime? date;
  DateTime? entryHour;
  DateTime? departureHour;
  UserProfile? client;
  String? userPickup;
  DateTime? lastDeworming;
  DateTime? lastProtectionFleas;
  String? direccion;
  bool? transfer;
  bool? isConfirmed;
  Pet? pet;
  String proofPhotoUrl = '';
  String pymentType = '';
  double priceTotal = 0;

  DaycareAppointment(
      {this.appointmentId,
      this.date,
      this.entryHour,
      this.departureHour,
      this.priceTotal = 0,
      this.pymentType = '',
      this.proofPhotoUrl = '',
      this.pet,
      this.client,
      this.userPickup,
      this.direccion,
      this.lastDeworming,
      this.lastProtectionFleas,
      this.transfer,
      this.isConfirmed});

  DaycareAppointment.fromJson(Map<String, dynamic> json) {
    this.appointmentId = json['id'];
    this.date = json['date'].toDate();
    this.pymentType = json['pymentType'];
    this.pet = Pet.fromJson(json['pet']);
    this.entryHour = json['entryHour'].toDate();
    this.proofPhotoUrl = json['proofPhotoUrl'];
    this.departureHour = json['departureHour'].toDate();
    this.client = UserProfile.fromJson(json['userDeliver']);
    this.priceTotal = json['priceTotal'];
    this.userPickup = json['userPickup'];
    this.direccion = json['direction'];
    this.lastDeworming = json['lastDeworing'] != null ? json['lastDeworing'].toDate() : null;
    this.lastProtectionFleas = json['lastProtectionFleas'] != null ? json['lastProtectionFleas'].toDate() : null;
    this.transfer = json['transfer'];
    this.isConfirmed = json['isConfirmed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.appointmentId,
      'date': this.date,
      'pymentType': this.pymentType,
      'entryHour': this.entryHour,
      'departureHour': this.departureHour,
      'userDeliver': this.client!.toJson(),
      'userPickup': this.userPickup,
      'direction': this.direccion,
      'lastDeworing': this.lastDeworming,
      'lastProtectionFleas': this.lastProtectionFleas,
      'transfer': this.transfer,
      'isConfirmed': this.isConfirmed,
      'pet': this.pet!.toJson(),
      'proofPhotoUrl': this.proofPhotoUrl,
      'priceTotal': this.priceTotal
    };
  }
}
