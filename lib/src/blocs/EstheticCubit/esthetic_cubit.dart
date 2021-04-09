import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_admin/models/sthetic_appointment.dart';
import 'package:lamanda_admin/repository/esthetic_appointment_repositorydb.dart';

part 'esthetic_state.dart';

class EstheticCubit extends Cubit<EstheticState> {
  EstheticCubit(this._appointmentRepository)
      : super(EstheticState(date: DateTime.now()));
  final StheticAppointmentRepository _appointmentRepository;
  void scheduleLoad(DateTime date) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final idDate = '${date.day}-${date.month}-${date.year}';
      final list = await _appointmentRepository.getEstheticAppointment(idDate);
      emit(state.copyWith(
        appoimentsList: list != null ? list.appointments : [],
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
    final idDate = '${date.day}-${date.month}-${date.year}';
    final list = await _appointmentRepository.getEstheticAppointment(idDate);
    emit(state.copyWith(
        appoimentsList: list != null ? list.appointments : []));
  }
}
