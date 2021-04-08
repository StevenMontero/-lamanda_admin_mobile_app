import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/daycare_appointment.dart';
import 'package:lamanda_admin/models/hotel_appointment.dart';
import 'package:lamanda_admin/models/sthetic_appoiments_list.dart';
import 'package:lamanda_admin/models/sthetic_appointment.dart';
import 'package:lamanda_admin/models/veterinary_appoiment_list.dart';
import 'package:lamanda_admin/models/veterinary_appointment.dart';

class AppointmentsRepository {
  final CollectionReference _refDaycare =
      FirebaseFirestore.instance.collection('daycareAppointment');
  final CollectionReference _refHotel =
      FirebaseFirestore.instance.collection('hotelAppointment');
  final CollectionReference _refSthetic =
      FirebaseFirestore.instance.collection('stheticAppointment');
  final CollectionReference _refVeterinary =
      FirebaseFirestore.instance.collection('veterinaryAppointment');

  Future<void> addNewDaycare(DaycareAppointment daycare) {
    return _refDaycare
        .add(daycare.toJson())
        .then((value) => print('Daycare Added'))
        .catchError((error) => print('Failed to add daycare: $error'));
  }

  Future<DaycareAppointment?> getDaycare(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refDaycare.doc(id).get();
    DaycareAppointment daycare = DaycareAppointment.fromJson(snapshot.data()!);
    daycare.appointmentId = id;
    if (snapshot.exists) {
      return daycare;
    } else {
      return null;
    }
  }

  void deleteDaycare(String? id) {
    _refDaycare.doc(id).delete();
  }

  Future<void> updateDaycare(
    DaycareAppointment daycare,
  ) {
    return _refDaycare
        .doc(daycare.appointmentId)
        .update(daycare.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  Future<void> addNewHotel(HotelAppointment hotel) {
    return _refHotel
        .add(hotel.toJson())
        .then((value) => print('Hotel Added'))
        .catchError((error) => print('Failed to add hotel: $error'));
  }

  Future<HotelAppointment?> getHotel(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refHotel.doc(id).get();
    HotelAppointment hotel = HotelAppointment.fromJson(snapshot.data()!);
    hotel.appointmentId = id;
    if (snapshot.exists) {
      return hotel;
    } else {
      return null;
    }
  }

  void deleteHotel(String? id) {
    _refHotel.doc(id).delete();
  }

  Future<void> updateHotel(
    HotelAppointment hotel,
  ) {
    return _refHotel
        .doc(hotel.appointmentId)
        .update(hotel.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  Future<void> addNewSthetic(StheticAppointment sthetic) {
    return _refSthetic
        .add(sthetic.toJson())
        .then((value) => print('Sthetic Added'))
        .catchError((error) => print('Failed to add sthetic: $error'));
  }

  Future<StheticAppointment?> getSthetic(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refSthetic.doc(id).get();
    StheticAppointment sthetic = StheticAppointment.fromJson(snapshot.data()!);
    sthetic.appointmentId = id;
    if (snapshot.exists) {
      return sthetic;
    } else {
      return null;
    }
  }

  void deleteSthetic(String? id) {
    _refSthetic.doc(id).delete();
  }

  Future<void> updateSthetic(
    StheticAppointment sthetic,
  ) {
    return _refSthetic
        .doc(sthetic.appointmentId)
        .update(sthetic.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  Future<void> addNewVeterinary(VeterinaryAppointment veterinary) {
    return _refVeterinary
        .add(veterinary.toJson())
        .then((value) => print('Sthetic Added'))
        .catchError((error) => print('Failed to add sthetic: $error'));
  }

  Future<VeterinaryAppointment?> getVeterinary(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refVeterinary.doc(id).get();
    VeterinaryAppointment vet = VeterinaryAppointment.fromJson(snapshot.data()!);
    vet.appointmentId = id;
    if (snapshot.exists) {
      return vet;
    } else {
      return null;
    }
  }

  void deleteVeterinary(String? id) {
    _refVeterinary.doc(id).delete();
  }

  Future<void> updateVeterinary(
    VeterinaryAppointment veterinary,
  ) {
    return _refVeterinary
        .doc(veterinary.appointmentId)
        .update(veterinary.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  //GET THE LIST OF EACH APPOINTMENT
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<List<DaycareAppointment>?> getDaycareApptList(int day) async {
    final List<DaycareAppointment> daycareList = [];

    await _refDaycare.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc.exists) {
          Timestamp entryDate = doc['date'];
          if (entryDate.toDate().day == day) {
            DaycareAppointment temp = new DaycareAppointment.fromJson(doc.data());
            temp.appointmentId = doc.id;
            daycareList.add(temp);
          }
        }
      });
    });

    if (daycareList.isNotEmpty) {
      return daycareList;
    } else {
      return null;
    }
  }

  Future<EstheticAppointmentsList?> getEstheticAppomint(
      String appointmentId) async {
    DocumentSnapshot snapshot;
    snapshot = await _refSthetic.doc(appointmentId).get();
    if (snapshot.exists) {
      return EstheticAppointmentsList.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<List<HotelAppointment>?> getHotelApptList(int day) async {
    final List<HotelAppointment> hotelList = [];
    await _refHotel.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc.exists) {
          Timestamp entryDate = doc['entryDate'];
          if (entryDate.toDate().day == day) {
            HotelAppointment temp = new HotelAppointment.fromJson(doc.data());
            temp.appointmentId = doc.id;
            hotelList.add(temp);
          }
        }
      });
    });

    if (hotelList.isNotEmpty) {
      return hotelList;
    } else {
      return null;
    }
  }

   Future<VeterinaryAppointmenList?> getVeterinaryAppointments(
      String appointmentId) async {
    DocumentSnapshot snapshot;
    snapshot = await _refVeterinary.doc(appointmentId).get();
    if (snapshot.exists) {
      return VeterinaryAppointmenList.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }
}
