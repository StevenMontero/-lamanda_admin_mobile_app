import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/hotel_appointment.dart';

class HotelAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('hotelAppointment');

  Future<List<HotelAppointment>?> getHotelAppoimentList(DateTime date) async {
    final List<HotelAppointment> daycareAppointmentList = [];
    QuerySnapshot snapshot = await _ref.get();

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((element) {
        Timestamp queryDate = element['entryDate'];
        if (date.day == queryDate.toDate().day) {
          daycareAppointmentList
              .add(HotelAppointment.fromJson(element.data()));
        }
      });
      return daycareAppointmentList;
    }
  }
}