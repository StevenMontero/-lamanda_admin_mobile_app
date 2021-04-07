import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/daycare.dart';
import 'package:lamanda_admin/models/appointment/esthetic.dart';
import 'package:lamanda_admin/models/appointment/hotel.dart';
import 'package:lamanda_admin/models/appointment/veterinary.dart';

class AppointmentsRepository {
  final CollectionReference _refDaycare =
      FirebaseFirestore.instance.collection('daycareAppointment');
  final CollectionReference _refHotel =
      FirebaseFirestore.instance.collection('hotelAppointment');
  final CollectionReference _refSthetic =
      FirebaseFirestore.instance.collection('stheticAppointment');
  final CollectionReference _refVeterinary =
      FirebaseFirestore.instance.collection('veterinaryAppointment');

  Future<void> addNewDaycare(DaycareAppt daycare) {
    return _refDaycare
        .add(daycare.toJson())
        .then((value) => print('Daycare Added'))
        .catchError((error) => print('Failed to add daycare: $error'));
  }

  Future<DaycareAppt?> getDaycare(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refDaycare.doc(id).get();
    DaycareAppt daycare = DaycareAppt.fromJson(snapshot.data()!);
    daycare.id = id;
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
    DaycareAppt daycare,
  ) {
    return _refDaycare
        .doc(daycare.id)
        .update(daycare.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  Future<void> addNewHotel(HotelAppt hotel) {
    return _refHotel
        .add(hotel.toJson())
        .then((value) => print('Hotel Added'))
        .catchError((error) => print('Failed to add hotel: $error'));
  }

  Future<HotelAppt?> getHotel(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refHotel.doc(id).get();
    HotelAppt hotel = HotelAppt.fromJson(snapshot.data()!);
    hotel.id = id;
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
    HotelAppt hotel,
  ) {
    return _refHotel
        .doc(hotel.id)
        .update(hotel.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  Future<void> addNewSthetic(EstheticAppt sthetic) {
    return _refSthetic
        .add(sthetic.toJson())
        .then((value) => print('Sthetic Added'))
        .catchError((error) => print('Failed to add sthetic: $error'));
  }

  Future<EstheticAppt?> getSthetic(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refSthetic.doc(id).get();
    EstheticAppt sthetic = EstheticAppt.fromJson(snapshot.data()!);
    sthetic.id = id;
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
    EstheticAppt sthetic,
  ) {
    return _refSthetic
        .doc(sthetic.id)
        .update(sthetic.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  Future<void> addNewVeterinary(VeterinaryAppt veterinary) {
    return _refVeterinary
        .add(veterinary.toJson())
        .then((value) => print('Sthetic Added'))
        .catchError((error) => print('Failed to add sthetic: $error'));
  }

  Future<VeterinaryAppt?> getVeterinary(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refVeterinary.doc(id).get();
    VeterinaryAppt vet = VeterinaryAppt.fromJson(snapshot.data()!);
    vet.id = id;
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
    VeterinaryAppt veterinary,
  ) {
    return _refVeterinary
        .doc(veterinary.id)
        .update(veterinary.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  //GET THE LIST OF EACH APPOINTMENT
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<List<DaycareAppt>?> getDaycareApptList(int day) async {
    final List<DaycareAppt> daycareList = [];

    await _refDaycare.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc.exists) {
          Timestamp entryDate = doc['date'];
          if (entryDate.toDate().day == day) {
            DaycareAppt temp = new DaycareAppt.fromJson(doc.data());
            temp.id = doc.id;
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

  Future<List<EstheticAppt>?> getStheticApptList(int day) async {
    final List<EstheticAppt> stheticList = [];
    QuerySnapshot snap = await _refSthetic.get();
    snap.docs.forEach((doc) {
      if (doc.exists) {
        Timestamp entryDate = doc['entryDate'];
        if (entryDate.toDate().day == day) {
          EstheticAppt temp = new EstheticAppt.fromJson(doc.data());
          temp.id = doc.id;
          stheticList.add(temp);
        }
      }
    });
    if (stheticList.isNotEmpty) {
      return stheticList;
    } else {
      return null;
    }
  }

  Future<List<HotelAppt>?> getHotelApptList(int day) async {
    final List<HotelAppt> hotelList = [];
    await _refHotel.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc.exists) {
          Timestamp entryDate = doc['entryDate'];
          if (entryDate.toDate().day == day) {
            HotelAppt temp = new HotelAppt.fromJson(doc.data());
            temp.id = doc.id;
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

  Future<List<VeterinaryAppt>?> getVeterinaryApptList(int day) async {
    final List<VeterinaryAppt> veterinaryList = [];
    await _refVeterinary.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc.exists) {
          Timestamp entryDate = doc['entryDate'];
          if (entryDate.toDate().day == day) {
            VeterinaryAppt temp = new VeterinaryAppt.fromJson(doc.data());
            temp.id = doc.id;
            veterinaryList.add(temp);
          }
        }
      });
    });

    if (veterinaryList.isNotEmpty) {
      return veterinaryList;
    } else {
      return null;
    }
  }
}
