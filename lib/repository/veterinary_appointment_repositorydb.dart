import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/veterinary_appoiment_list.dart';

class VeterinaryAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('veterinaryAppointment');
  
  Future<VeterinaryAppointmenList?> getVetAppointments(
      String appointmentId) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(appointmentId).get();
    if (snapshot.exists) {
      return VeterinaryAppointmenList.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }
}