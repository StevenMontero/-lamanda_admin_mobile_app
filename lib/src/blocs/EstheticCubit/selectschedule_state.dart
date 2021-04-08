part of 'selectschedule_cubit.dart';

class EstheticState extends Equatable {
  const EstheticState(
      {this.status,
      required this.date,
      this.index = 0,
      this.stheticAppoimentList = const []});

  final DateTime date;
  final int? index;
  final List<StheticAppointment> stheticAppoimentList;
  final FormzStatus? status;

  EstheticState copyWith({
    DateTime? date,
    List<StheticAppointment>? schedule,
    int? index,
    FormzStatus? status,
  }) {
    return EstheticState(
        stheticAppoimentList: schedule ?? this.stheticAppoimentList,
        date: date ?? this.date,
        index: index ?? this.index,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        date,
        stheticAppoimentList,
        index,
      ];
}
