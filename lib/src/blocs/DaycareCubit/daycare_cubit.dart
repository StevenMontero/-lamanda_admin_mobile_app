import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_admin/models/daycare_appointment.dart';
import 'package:lamanda_admin/repository/daycare_appointment_repositorydb.dart';

part 'dayCare_state.dart';

class DayCareCubit extends Cubit<DayCareState> {
  DayCareCubit(this._appointmentRepository)
      : super(DayCareState(date: DateTime.now()));
  final DaycareAppointmentRepository _appointmentRepository;
  void scheduleLoad(DateTime date) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final list = await _appointmentRepository.getDaycareApptList(date);

      emit(state.copyWith(
        appoimentsList: list,
        date: DateTime.now(),
        status: FormzStatus.submissionSuccess,
        index: 0,
      ));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void dateInCalendarChanged(DateTime date) async {
    emit(state.copyWith(date: date));
    final list = await _appointmentRepository.getDaycareApptList(date);
    emit(state.copyWith(appoimentsList: list));
  }
}
