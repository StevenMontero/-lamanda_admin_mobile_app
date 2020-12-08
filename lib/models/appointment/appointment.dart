import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class Appointment {
  String id;
  Timestamp entryDate;
  UserProfile entryUser;
  bool transfer;
  bool isConfirmed;
  String direction;

  bool isDeclined = false;

  String uniqueId;
}
