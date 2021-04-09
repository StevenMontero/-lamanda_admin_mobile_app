import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/daycare_appointment.dart';

class DaycareAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('daycareAppointment');

  //Future<DaycareAppointment?> getUserAppointment(String appointmentId) async {
  //  DocumentSnapshot snapshot;
  //  snapshot = await _ref.doc(appointmentId).get();
  //  if (snapshot.exists) {
  //    return DaycareAppointment.fromJson(snapshot.data()!);
  //  } else {
  //    return null;
  //  }
  //}

  Future<List<DaycareAppointment>?> getDaycareApptList(DateTime date) async {
    final List<DaycareAppointment> daycareAppointmentList = [];
    QuerySnapshot snapshot = await _ref.get();

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((element) {
        Timestamp queryDate = element['date'];
        if (date.day == queryDate.toDate().day) {
          daycareAppointmentList
              .add(DaycareAppointment.fromJson(element.data()));
        }
      });
      return daycareAppointmentList;
    }
  }
}
