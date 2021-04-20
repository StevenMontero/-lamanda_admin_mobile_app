import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_admin/models/hotel_appointment.dart';
import 'package:lamanda_admin/repository/hotel_appointment_repositorydb.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  HotelCubit(this._appointmentRepository)
      : super(HotelState(date: DateTime.now()));
  final HotelAppointmentRepository _appointmentRepository;
  void scheduleLoad(DateTime date) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final list = await _appointmentRepository.getHotelAppoimentList(date);

      emit(state.copyWith(
        hotelAppoimentList: list != null ? list : [],
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
    final list = await _appointmentRepository.getHotelAppoimentList(date);
    emit(state.copyWith(hotelAppoimentList: list != null ? list : []));
  }
}
