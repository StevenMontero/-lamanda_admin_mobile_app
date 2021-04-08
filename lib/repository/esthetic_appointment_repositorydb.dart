import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/sthetic_appoiments_list.dart';

class StheticAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('stheticAppointment');

  Future<EstheticAppointmentsList?> getEstheticAppointment(
      String appointmentId) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(appointmentId).get();
    if (snapshot.exists) {
      return EstheticAppointmentsList.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }
}