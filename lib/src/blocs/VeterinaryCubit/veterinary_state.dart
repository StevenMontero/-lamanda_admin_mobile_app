part of 'veterinary_cubit.dart';

class VeterinaryState extends Equatable {
  const VeterinaryState(
      {this.status,
      required this.date,
      this.index = 0,
      this.veterinaryAppoimentList = const []});

  final DateTime date;
  final int? index;
  final List<VeterinaryAppointment> veterinaryAppoimentList;
  final FormzStatus? status;

  VeterinaryState copyWith({
    DateTime? date,
    List<VeterinaryAppointment>? veterinaryAppoimentList,
    int? index,
    FormzStatus? status,
  }) {
    return VeterinaryState(
        veterinaryAppoimentList: veterinaryAppoimentList ?? this.veterinaryAppoimentList,
        date: date ?? this.date,
        index: index ?? this.index,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        date,
        veterinaryAppoimentList,
        index,
      ];
}
