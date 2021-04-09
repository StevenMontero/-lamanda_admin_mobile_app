import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_admin/models/veterinary_appointment.dart';
import 'package:lamanda_admin/repository/veterinary_appointment_repositorydb.dart';

part 'veterinary_state.dart';

class VeterinaryCubit extends Cubit<VeterinaryState> {
  VeterinaryCubit(this._appointmentRepository)
      : super(VeterinaryState(date: DateTime.now()));
  final VeterinaryAppointmentRepository _appointmentRepository;
  void scheduleLoad(DateTime date) async {
    final idDate = '${date.day}-${date.month}-${date.year}';
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final list = await _appointmentRepository.getVetAppointments(idDate);

      emit(state.copyWith(
        veterinaryAppoimentList: list != null ? list.appointments : [],
        date: DateTime.now(),
        status: FormzStatus.submissionSuccess,
        index: 0,
      ));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void dateInCalendarChanged(DateTime date) async {
    final idDate = '${date.day}-${date.month}-${date.year}';
    emit(state.copyWith(date: date));
    final list = await _appointmentRepository.getVetAppointments(idDate);
    emit(state.copyWith(veterinaryAppoimentList: list != null ? list.appointments : []));
  }
}
