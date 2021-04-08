

import 'package:lamanda_admin/models/pet.dart';
import 'package:lamanda_admin/models/service.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class StheticAppointment {
  String? appointmentId;
  DateTime? entryDate;
  DateTime? entryHour;
  UserProfile? client;
  Pet? pet;
  bool? isConfirmed;
  bool? transfer;
  String? address;
  String proofPhotoUrl = '';
  List<Service>? listService;
  double priceTotal = 0;
  String pymentType = '';

  StheticAppointment({
    this.appointmentId,
    this.listService,
    this.priceTotal = 0,
    this.proofPhotoUrl = '',
    this.pymentType = '',
    this.entryDate,
    this.client,
    this.pet,
    this.isConfirmed,
    this.entryHour,
    this.address,
    this.transfer,
  });

  StheticAppointment.fromJson(Map<String, dynamic> json) {
    //PetList getPetList = new PetList.fromJsonList(json['petList']);

    this.address = json['direction']; // cambiar a addres
    this.entryDate = json['entryDate'].toDate();
    this.client = UserProfile.fromJson(json['entryUser']);
    this.pymentType = json['pymentType'];
    this.appointmentId = json['id'];
    this.priceTotal = json['priceTotal'];
    this.entryHour = json['entryHour'].toDate();
    this.pet = Pet.fromJson(json['pet']);
    this.isConfirmed = json['isConfirmed'];
    this.proofPhotoUrl = json['proofPhotoUrl'];
    this.transfer = json['transfer'];
    this.listService = List<Service>.from(
        json['listService'].map((service) => Service.fromJson(service)));
  }

  Map<String, dynamic> toJson() {
    return {
      'direction': this.address,
      'entryDate': this.entryDate,
      'entryHour': this.entryHour,
      'entryUser': this.client!.toJson(),
      'id': this.appointmentId,
      'pet': this.pet!.toJson(),
      'isConfirmed': this.isConfirmed,
      'transfer': this.transfer,
      'proofPhotoUrl': this.proofPhotoUrl,
      'pymentType': this.pymentType,
      'listService': List<dynamic>.from(listService!.map((x) => x.toJson())),
      'priceTotal': this.priceTotal
    };
  }
}
