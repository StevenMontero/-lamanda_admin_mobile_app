import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/models/adminUser.dart';

class AdminUserRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('adminUser');

  Future<void> addNewUser(AdminUser user) {
    return _ref
        .add(user.toJson())
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  Future<AdminUser?> getUserProfile(String idUser) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(idUser).get();
    if (snapshot.exists) {
      return AdminUser.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<void> updateUser(
    AdminUser user,
  ) {
    return _ref
        .doc(user.id)
        .update(user.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  Future<void> deleteUser(String? id) async {
    _ref
        .doc(id)
        .delete()
        .then((value) => print('deleted adminUser'))
        .catchError((e) {
      print(e);
    });
  }

  Future<List<AdminUser>> getUsers() async {
    final listAdminUsers = <AdminUser>[];
    AdminUser temp = AdminUser();
    QuerySnapshot snap = await _ref.get();
    snap.docs.forEach((p) {
      temp = AdminUser.fromJson(p.data());
      temp.id = p.id;
      listAdminUsers.add(temp);
    });
    return listAdminUsers;
  }
}
