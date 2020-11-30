import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_admin/models/appointment/daycare.dart';
import 'package:lamanda_admin/models/appointment/esthetic.dart';
import 'package:lamanda_admin/models/appointment/hotel.dart';
import 'package:lamanda_admin/models/appointment/veterinary.dart';
import 'package:lamanda_admin/models/userProfile.dart';
import 'package:lamanda_admin/repository/appointments_repository.dart';
import 'package:lamanda_admin/repository/user_repository.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/widgets/appBar.dart';
import 'package:lamanda_admin/src/widgets/calendarWidgetLibrary.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  double heightCard = 40.0;
  double widthCard;
  Size _screenSize;

  DateTime _selectedDate;

  FilterAppts stheticFilter = new FilterAppts('Estét.',
      ColorsApp.primaryColorBlue, ColorsApp.primaryColorBlueDegraded, true, 2);
  FilterAppts veterinaryFilter = new FilterAppts(
      'Veter.',
      ColorsApp.primaryColorTurquoise,
      ColorsApp.primaryColorTurquoiseDegraded,
      true,
      4);
  FilterAppts daycareFilter = new FilterAppts('Guard.',
      ColorsApp.primaryColorPink, ColorsApp.primaryColorPinkDegraded, true, 1);
  FilterAppts hotelFilter = new FilterAppts(
      'Hotel',
      ColorsApp.primaryColorOrange,
      ColorsApp.primaryColorOrangeDegraded,
      true,
      3);

  List<FilterAppts> _cast;
  List<String> _filters = <String>[];

  List<DaycareAppt> daycareApptList = new List();
  List<EstheticAppt> stheticApptList = new List();
  List<HotelAppt> hotelApptList = new List();
  List<VeterinaryAppt> veterinaryApptList = new List();

  final AppointmentsRepository appointmentsRepository =
      new AppointmentsRepository();

  _AppointmentListState() {
    _cast = <FilterAppts>[
      stheticFilter,
      veterinaryFilter,
      daycareFilter,
      hotelFilter,
    ];
    _resetSelectedDate();
  }
  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    widthCard = _screenSize.width * 0.23;
    double titleSize = _screenSize.width * 0.045;

    return Scaffold(
      appBar: titlePage(context),
      body: Column(
        children: [
          SizedBox(height: 2),
          Text("Administración de Citas",
              style: TextStyle(
                  color: ColorsApp.primaryColorBlue,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w900)),
          Divider(
            height: 5,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: actorWidgets.toList(),
          ),
          _listAppointments(),
        ],
      ),
    );
  }

  Iterable<Widget> get actorWidgets sync* {
    widthCard = _screenSize.width * 0.25;
    double textSize = widthCard * 0.14;
    heightCard = _screenSize.height * 0.055;

    for (FilterAppts filter in _cast) {
      yield Container(
        padding: EdgeInsets.symmetric(horizontal: _screenSize.width * 0.005),
        width: widthCard,
        child: FilterChip(
          backgroundColor: filter.nonSelectionColor,
          selectedColor: filter.selectionColor,
          avatar:
              CircleAvatar(backgroundColor: Color(0x00FFFFFF), child: Text("")),
          labelStyle: TextStyle(color: Colors.white, fontSize: textSize),
          label: Text(filter.name),
          selected: !_filters.contains(filter.name),
          onSelected: (bool value) {
            setState(() {
              if (!value) {
                _filters.add(filter.name);
                filter.selected = false;
                switch (filter.type) {
                  case 1:
                    daycareApptList = null;
                    break;
                  case 2:
                    stheticApptList = null;
                    break;
                  case 3:
                    hotelApptList = null;
                    break;
                  case 4:
                    veterinaryApptList = null;
                    break;
                  default:
                }
              } else {
                _filters.removeWhere((String name) {
                  return name == filter.name;
                });
                filter.selected = true;
              }
              if (filter.selected) {
                print("Se activa");
              } else {
                print("se desactiva");
              }
            });
          },
        ),
      );
    }
  }

  Widget _listAppointments() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: _screenSize.width * 0.95,
      height: _screenSize.height * 0.765,
      decoration: BoxDecoration(
        color: Color(0xFF6C78EB),
        borderRadius: new BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 2),
          CalendarTimeline(
            initialDate: _selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 30)),
            lastDate: DateTime.now().add(Duration(days: 60)),
            onDateSelected: (date) {
              setState(() {
                daycareApptList = null;
                hotelApptList = null;
                veterinaryApptList = null;
                stheticApptList = null;
                _selectedDate = date;
              });
            },
            leftMargin: 20,
            monthColor: Colors.white70,
            dayColor: Colors.teal[200],
            dayNameColor: Color(0xFF333A47),
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: Color(0xFF333A47),
            locale: 'es',
          ),
          _createApptContainer()
        ],
      ),
    );
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  Widget _createApptContainer() {
    double titlesSize = _screenSize.width * 0.045;
    Widget list;
    return Container(
      margin: EdgeInsets.only(top: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      width: _screenSize.width * 0.9,
      height: _screenSize.height * 0.63,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: _screenSize.width * 0.1,
              ),
              Text(
                "Hora",
                style: TextStyle(color: Colors.black, fontSize: titlesSize),
              ),
              SizedBox(
                width: _screenSize.width * 0.3,
              ),
              Text(
                "Detalles",
                style: TextStyle(color: Colors.black, fontSize: titlesSize),
              ),
            ],
          ),
          Expanded(
              child: FutureBuilder(
            future: _getAppoitments(),
            builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
              if (snapshot.hasData) {
                return _createList(snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))
        ],
      ),
    );
  }

  Future<List<int>> _getAppoitments() async {
    List<int> list = new List();
    if (daycareFilter.selected) {
      daycareApptList =
          await appointmentsRepository.getDaycareApptList(_selectedDate.day);
      if (daycareApptList != null) {
        daycareApptList.sort((a, b) =>
            a.entryDate.toDate().hour.compareTo(b.entryDate.toDate().hour));
        list.add(1);
      }
    }

    if (stheticFilter.selected) {
      stheticApptList =
          await appointmentsRepository.getStheticApptList(_selectedDate.day);
      if (stheticApptList != null) {
        stheticApptList.sort((a, b) =>
            a.dateTime.toDate().hour.compareTo(b.dateTime.toDate().hour));
        list.add(1);
      }
    }

    if (hotelFilter.selected) {
      hotelApptList =
          await appointmentsRepository.getHotelApptList(_selectedDate.day);
      if (hotelApptList != null) {
        hotelApptList.sort((a, b) =>
            a.entryDate.toDate().hour.compareTo(b.entryDate.toDate().hour));
        list.add(1);
      }
    }

    if (veterinaryFilter.selected) {
      veterinaryApptList =
          await appointmentsRepository.getVeterinaryApptList(_selectedDate.day);
      if (veterinaryApptList != null) {
        veterinaryApptList.sort((a, b) =>
            a.dateTime.toDate().hour.compareTo(b.dateTime.toDate().hour));
        list.add(1);
      }
    }

    if (!daycareFilter.selected &&
        !stheticFilter.selected &&
        !hotelFilter.selected &&
        !veterinaryFilter.selected) {
      list.add(1);
    }
    /*if (daycareApptList == null &&
        stheticApptList == null &&
        hotelApptList == null &&
        veterinaryApptList == null) {
      list.add(1);
    }*/
    if (list.isNotEmpty) {
      return list;
    } else {
      return null;
    }
  }

  Widget _createList(List<int> listReceived) {
    listReceived = null;

    List<Widget> list = new List();
    if (daycareApptList != null) {
      if (daycareApptList.isNotEmpty) {
        list.add(_createAppts(1));
      }
    }

    if (stheticApptList != null) {
      if (stheticApptList.isNotEmpty) {
        list.add(_createAppts(2));
      }
    }

    if (hotelApptList != null) {
      if (hotelApptList.isNotEmpty) {
        list.add(_createAppts(3));
      }
    }
    if (veterinaryApptList != null) {
      if (veterinaryApptList.isNotEmpty) {
        list.add(_createAppts(4));
      }
    }
    /*if (daycareApptList == null &&
        stheticApptList == null &&
        hotelApptList == null &&
        veterinaryApptList == null) {
      return _showMessage(
          "Aún no hay citas para el día de hoy");
    }*/
    if (!daycareFilter.selected &&
        !stheticFilter.selected &&
        !hotelFilter.selected &&
        !veterinaryFilter.selected) {
      return _showMessage(
          "Presiona uno de los filtros para poder ver información");
    }
    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  Widget _showMessage(String message) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.exclamationTriangle,
            size: 50,
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _createAppts(int type) {
    List<Widget> appointmentsConfirmed = new List();
    List<Widget> appointmentsNonConfirmed = new List();
    Widget appointmentTemp;
    Color backgroundColor;
    String title;
    Container titleConfirmed = new Container();
    Container titleNonConfirmed = new Container();

    switch (type) {
      case 1:
        daycareApptList.forEach((element) {
          appointmentTemp = _createAppoitment(
              element.entryUser.id,
              element.entryDate.toDate(),
              ColorsApp.primaryColorPink,
              element.isConfirmed);
          if (element.isConfirmed) {
            appointmentsConfirmed.add(appointmentTemp);
          } else {
            appointmentsNonConfirmed.add(appointmentTemp);
          }
        });
        backgroundColor = ColorsApp.primaryColorPinkDegraded;
        title = "Guardería";
        break;
      case 2:
        stheticApptList.forEach((element) {
          appointmentTemp = _createAppoitment(
              element.user.id,
              element.dateTime.toDate(),
              ColorsApp.primaryColorPink,
              element.isConfirmed);
          if (element.isConfirmed) {
            appointmentsConfirmed.add(appointmentTemp);
          } else {
            appointmentsNonConfirmed.add(appointmentTemp);
          }
        });
        backgroundColor = ColorsApp.primaryColorBlueDegraded;
        title = "Estética";
        break;
      case 3:
        hotelApptList.forEach((element) {
          appointmentTemp = _createAppoitment(
              element.entryUser.id,
              element.entryDate.toDate(),
              ColorsApp.primaryColorPink,
              element.isConfirmed);
          if (element.isConfirmed) {
            appointmentsConfirmed.add(appointmentTemp);
          } else {
            appointmentsNonConfirmed.add(appointmentTemp);
          }
        });
        backgroundColor = ColorsApp.primaryColorOrangeDegraded;
        title = "Hotel";
        break;
      case 4:
        veterinaryApptList.forEach((element) {
          appointmentTemp = _createAppoitment(
              element.user.id,
              element.dateTime.toDate(),
              ColorsApp.primaryColorPink,
              element.isConfirmed);
          if (element.isConfirmed) {
            appointmentsConfirmed.add(appointmentTemp);
          } else {
            appointmentsNonConfirmed.add(appointmentTemp);
          }
        });
        backgroundColor = ColorsApp.primaryColorTurquoiseDegraded;
        title = "Veterinaria";
        break;
    }

    if (appointmentsConfirmed.isNotEmpty) {
      titleConfirmed = Container(
        width: _screenSize.width * 0.8,
        child: Text(
          "Citas confirmadas",
          style: TextStyle(fontSize: 13),
        ),
      );
    }
    if (appointmentsNonConfirmed.isNotEmpty) {
      titleNonConfirmed = Container(
        width: _screenSize.width * 0.8,
        child: Text(
          "Citas sin confirmar",
          style: TextStyle(fontSize: 13),
        ),
      );
    }

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: _screenSize.width * 0.87,
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 3,
            ),
            Column(
              children: [
                titleConfirmed,
                Column(
                  children: appointmentsConfirmed,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                titleNonConfirmed,
                Column(children: appointmentsNonConfirmed),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAppoitment(
      String userId, DateTime date, Color color, bool isConfirmed) {
    Color hourColor;
    Color apptColor;
    Icon icon;

    if (isConfirmed) {
      hourColor = Colors.white;
      apptColor = color;
      icon = Icon(
        FontAwesomeIcons.chevronRight,
        color: Colors.white,
        size: 20,
      );
    } else {
      hourColor = ColorsApp.problemPrimaryColorDegraded;
      apptColor = ColorsApp.problemPrimaryColor;
      icon = Icon(
        FontAwesomeIcons.chevronRight,
        color: Colors.white,
        size: 20,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
              color: hourColor,
              borderRadius: new BorderRadius.circular(8.0),
            ),
            height: 34,
            alignment: Alignment.center,
            width: _screenSize.width * 0.235,
            margin: EdgeInsets.symmetric(vertical: 1),
            child: Text(
              _getTime(date),
              style: TextStyle(
                  color: Colors.black, fontSize: _screenSize.width * 0.043),
            )),
        SizedBox(
          width: _screenSize.width * 0.01,
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: apptColor,
              borderRadius: new BorderRadius.circular(8.0),
            ),
            width: _screenSize.width * 0.56,
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: _screenSize.width * 0.47,
                    child: FutureBuilder(
                      future: UserRepository().getUserProfile(userId),
                      builder: (BuildContext context,
                          AsyncSnapshot<UserProfile> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.userName +
                                " " +
                                snapshot.data.lastName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          );
                        } else {
                          return Center(
                              child: Container(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          ));
                        }
                      },
                    )),
                SizedBox(
                  width: 2,
                ),
                GestureDetector(child: icon)
              ],
            )),
      ],
    );
  }

  String _getTime(DateTime date) {
    int hour;
    String hourString;
    String minute;
    String ampm;

    if (date.minute.toString().length == 1) {
      minute = "0" + date.minute.toString();
    } else {
      minute = date.minute.toString();
    }

    if (date.hour >= 13) {
      ampm = "PM";

      switch (date.hour) {
        case 13:
          hour = 1;
          break;
        case 14:
          hour = 2;
          break;
        case 15:
          hour = 3;
          break;
        case 16:
          hour = 4;
          break;
        case 17:
          hour = 5;
          break;
        case 18:
          hour = 6;
          break;
        case 19:
          hour = 7;
          break;
        case 20:
          hour = 8;
          break;
        default:
      }

      if (hour.toString().length == 1) {
        hourString = "0" + hour.toString();
      } else {
        hourString = hour.toString();
      }
    } else {
      ampm = "AM";
      if (date.hour.toString().length == 1) {
        hourString = "0" + date.hour.toString();
      } else {
        hourString = date.hour.toString();
      }
    }
    return hourString + ":" + minute + " " + ampm;
  }
}

class FilterAppts {
  FilterAppts(this.name, this.selectionColor, this.nonSelectionColor,
      this.selected, this.type);
  final String name;
  final Color selectionColor;
  final Color nonSelectionColor;
  bool selected;
  final int type;
}
