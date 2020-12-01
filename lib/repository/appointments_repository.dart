import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/appointment/daycare.dart';
import 'package:lamanda_admin/models/appointment/esthetic.dart';
import 'package:lamanda_admin/models/appointment/hotel.dart';
import 'package:lamanda_admin/models/appointment/veterinary.dart';
import 'package:lamanda_admin/models/pet.dart';
import 'package:lamanda_admin/models/userProfile.dart';
import 'package:lamanda_admin/repository/pet_repository.dart';
import 'package:lamanda_admin/repository/user_repository.dart';

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

  Future<DaycareAppt> getDaycare(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refDaycare.doc(id).get();

    if (snapshot.exists) {
      return new DaycareAppt.fromJson(id, snapshot.data());
    } else {
      return null;
    }
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

  Future<HotelAppt> getHotel(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refHotel.doc(id).get();

    if (snapshot.exists) {
      return HotelAppt.fromJson(id, snapshot.data());
    } else {
      return null;
    }
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

  Future<EstheticAppt> getSthetic(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refSthetic.doc(id).get();

    if (snapshot.exists) {
      return EstheticAppt.fromJson(id, snapshot.data());
    } else {
      return null;
    }
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

  Future<VeterinaryAppt> getVeterinary(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _refVeterinary.doc(id).get();

    if (snapshot.exists) {
      return VeterinaryAppt.fromJson(id, snapshot.data());
    } else {
      return null;
    }
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

  Future<List<DaycareAppt>> getDaycareApptList(int day) async {
    final List<DaycareAppt> daycareList = new List();

    await _refDaycare.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc.exists) {
          Timestamp entryDate = doc['entryDate'];
          if (entryDate.toDate().day == day) {
            /* DocumentReference departureUserReference = doc['departureUser'];
            UserProfile departureUser = await UserRepository()
                .getUserProfile(departureUserReference.id);
*/
            /*DocumentReference entryUserReference = doc['entryUser'];
            UserProfile entryUser =
                await UserRepository().getUserProfile(entryUserReference.id);
                
            Map petListReference = doc['petList'];
  
            List<Pet> petList = new List();

            petListReference.forEach((key, value) async {
              DocumentReference petReference = value;
              Pet pet = await PetRepository().getPet(petReference.id);
              petList.add(pet);
            });*/

            DaycareAppt temp = new DaycareAppt.fromJson(doc.id, doc.data());
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

  Future<List<EstheticAppt>> getStheticApptList(int day) async {
    final List<EstheticAppt> stheticList = new List();
    QuerySnapshot snap = await _refSthetic.get();
    snap.docs.forEach((doc) {
      if (doc.exists) {
        Timestamp entryDate = doc['date'];
        if (entryDate.toDate().day == day) {
          EstheticAppt temp = new EstheticAppt.fromJson(doc.id, doc.data());
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

  Future<List<HotelAppt>> getHotelApptList(int day) async {
    final List<HotelAppt> hotelList = new List();
    await _refHotel.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc.exists) {
          Timestamp entryDate = doc['entryDate'];
          if (entryDate.toDate().day == day) {
            HotelAppt temp = new HotelAppt.fromJson(doc.id, doc.data());
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

  Future<List<VeterinaryAppt>> getVeterinaryApptList(int day) async {
    final List<VeterinaryAppt> veterinaryList = new List();
    await _refVeterinary.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc.exists) {
          Timestamp entryDate = doc['date'];
          if (entryDate.toDate().day == day) {
            VeterinaryAppt temp =
                new VeterinaryAppt.fromJson(doc.id, doc.data());
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
