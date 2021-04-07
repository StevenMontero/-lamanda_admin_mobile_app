import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';

class ApptStay extends Appointment {
  Timestamp? departureDate;
  String? departureUser;
  
  bool? isCastrated;
  bool? isSociable;
  bool? isVaccinationUpDate;
  Timestamp? lastDeworming;
  Timestamp? lastProtectionFleas;
  String? race;
  int? age;
}