part of 'admin_user_cubit.dart';

abstract class AdminUserState extends Equatable {
  const AdminUserState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends AdminUserState {
  final listAdminUsers = false;
}

// ignore: must_be_immutable
class UsersModified extends AdminUserState {
  final listAdminUsers = true;
  AdminUser user;

  UsersModified(this.user);
}
