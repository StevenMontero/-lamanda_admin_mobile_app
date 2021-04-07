import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lamanda_admin/models/adminUser.dart';
import 'package:lamanda_admin/repository/admin_user_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'admin_user_state.dart';

class AdminUserCubit extends Cubit<AdminUserState> {
  AdminUserCubit() : super(UsersInitial());
  final adminUsers = new AdminUserRepository();
  final _usersController = new BehaviorSubject<List<AdminUser>>();
  get getProductsStream => _usersController.stream;

  void createAdminUser(AdminUser user) {
    adminUsers.addNewUser(user);
    emit(new UsersModified(user));
  }

  void modifyUser(AdminUser user) {
    final AdminUserState currentState = state;
    if (currentState is UsersModified) {
      currentState.user = user;
      adminUsers.updateUser(user);
      emit(new UsersModified(user));
    }
  }

  void deleteUser(AdminUser user) {
    final AdminUserState currentState = state;
    if (currentState is UsersModified) {
      currentState.user = user;
      adminUsers.deleteUser(user.id);
      emit(new UsersModified(user));
    }
  }

  Future<List<AdminUser>> getAdminUsers() async {
    List<AdminUser> list = await adminUsers.getUsers();
    if (list.isEmpty != true) {
      emit(new UsersModified(new AdminUser()));
    }
    _usersController.sink.add(list);
    return list;
  }

  Future<AdminUser?> getProduct(String id) {
    return adminUsers.getUserProfile(id);
  }

  dispose() {
    _usersController?.close();
  }
}
