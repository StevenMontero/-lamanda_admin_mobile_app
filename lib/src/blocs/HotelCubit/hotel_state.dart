part of 'hotel_cubit.dart';

class HotelState extends Equatable {
  const HotelState(
      {this.status,
      required this.date,
      this.index = 0,
      this.hotelAppoimentList = const []});

  final DateTime date;
  final int? index;
  final List<HotelAppointment> hotelAppoimentList;
  final FormzStatus? status;

  HotelState copyWith({
    DateTime? date,
    List<HotelAppointment>? hotelAppoimentList,
    int? index,
    FormzStatus? status,
  }) {
    return HotelState(
        hotelAppoimentList: hotelAppoimentList ?? this.hotelAppoimentList,
        date: date ?? this.date,
        index: index ?? this.index,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        date,
        hotelAppoimentList,
        index,
      ];
}
