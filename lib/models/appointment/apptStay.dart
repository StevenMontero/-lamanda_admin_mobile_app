import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';

class ApptStay extends Appointment {
  Timestamp departureDate;
  String departureUser;
}