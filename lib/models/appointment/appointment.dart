import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/userProfile.dart';

class Appointment {
  String id;
  Timestamp entryDate;
  DocumentReference entryUser;
  bool transfer;
  bool isConfirmed;
  bool declined;
  String direction;
  UserProfile entryUserProfile;

  String uniqueId;
}
