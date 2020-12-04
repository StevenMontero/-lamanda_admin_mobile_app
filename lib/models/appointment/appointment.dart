import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String id;
  Timestamp entryDate;
  DocumentReference entryUser;
  Map<String, DocumentReference> petList;
  bool transfer;
  bool isConfirmed;
  bool declined;
  String direction;

  String uniqueId;
}
