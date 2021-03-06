

import 'package:lamanda_admin/models/sthetic_appointment.dart';

class EstheticAppointmentsList {
  String date = '';
  List<StheticAppointment> appointments = [];
  List<DateTime> reservedTimes = [];
  EstheticAppointmentsList(
      {required this.date,
      required this.appointments,
      required this.reservedTimes});

  EstheticAppointmentsList.fromJson(Map<String, dynamic> json) {
    this.date = json['date'];
    this.appointments = List<StheticAppointment>.from(json['appointments']
        .map((model) => StheticAppointment.fromJson(model)));
    this.reservedTimes =
        List<DateTime>.from(json['reservedTimes'].map((date) => date.toDate()));
  }

  Map<String, dynamic> toJson() {
    return {
      'date': this.date,
      'reservedTimes': this.reservedTimes,
      'appointments': List<dynamic>.from(appointments.map((x) => x.toJson()))
    };
  }
}
