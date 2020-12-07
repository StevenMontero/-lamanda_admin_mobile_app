import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class Appointment {
  String id;
  Timestamp entryDate;
  DocumentReference entryUser;
  bool transfer;
  bool isConfirmed;
  String direction;
  UserProfile entryUserProfile;

  bool isDeclined = false;

  String uniqueId;
}
