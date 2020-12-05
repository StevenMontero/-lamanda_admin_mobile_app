import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/pet.dart';

class PetRepository {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('pet');

  Future<void> addNewPet(Pet pet) {
    return _ref
        .add(pet.toJson())
        .then((value) => print('Pet Added'))
        .catchError((error) => print('Failed to add pet: $error'));
  }

  Future<Pet> getPet(String id) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(id).get();
    if (snapshot.exists) {
      return Pet.fromJson(snapshot.data());
    } else {
      return null;
    }
  }

  Future<void> updatePet(
    Pet pet,
  ) {
    return _ref
        .doc(pet.id)
        .update(pet.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }
}
