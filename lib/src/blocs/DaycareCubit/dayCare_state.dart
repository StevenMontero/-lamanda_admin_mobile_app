part of 'daycare_cubit.dart';

class DayCareState extends Equatable {
  const DayCareState(
      {this.status,
      required this.date,
      this.index = 0,
      this.dayCareAppoimentList = const []});

  final DateTime date;
  final int? index;
  final List<DaycareAppointment> dayCareAppoimentList;
  final FormzStatus? status;

  DayCareState copyWith({
    DateTime? date,
    List<DaycareAppointment>? appoimentsList,
    int? index,
    FormzStatus? status,
  }) {
    return DayCareState(
        dayCareAppoimentList: appoimentsList ?? this.dayCareAppoimentList,
        date: date ?? this.date,
        index: index ?? this.index,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        date,
        dayCareAppoimentList,
        index,
      ];
}
