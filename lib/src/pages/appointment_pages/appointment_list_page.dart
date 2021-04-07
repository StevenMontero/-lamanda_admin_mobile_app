import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';
import 'package:lamanda_admin/models/appointment/daycare.dart';
import 'package:lamanda_admin/models/appointment/esthetic.dart';
import 'package:lamanda_admin/models/appointment/hotel.dart';
import 'package:lamanda_admin/models/appointment/veterinary.dart';
import 'package:lamanda_admin/repository/appointments_repository.dart';
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

  List<DaycareAppt> daycareApptList = [];
  List<EstheticAppt> stheticApptList = [];
  List<HotelAppt> hotelApptList = [];
  List<VeterinaryAppt> veterinaryApptList = [];

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
                if (snapshot.connectionState == ConnectionState.done) {
                  if (_selectedDate.day == DateTime.now().day) {
                    return _showMessage(
                        "Aún no hay citas para el día de hoy", false);
                  } else {
                    return _showMessage(
                        "Aún no hay citas para este día", false);
                  }
                } else {
                  return Center(
                    child: Image.asset('assets/gif/loading.gif'),
                  );
                }
              }
            },
          ))
        ],
      ),
    );
  }

  Future<List<int>> _getAppoitments() async {
    List<int> list = [];
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
            a.entryDate.toDate().hour.compareTo(b.entryDate.toDate().hour));
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
            a.entryDate.toDate().hour.compareTo(b.entryDate.toDate().hour));
        list.add(1);
      }
    }

    if (!daycareFilter.selected &&
        !stheticFilter.selected &&
        !hotelFilter.selected &&
        !veterinaryFilter.selected) {
      list.add(1);
    }
    if (list.isNotEmpty) {
      return list;
    } else {
      return null;
    }
  }

  Widget _createList(List<int> listReceived) {
    listReceived = null;

    List<Widget> list = [];
    if (daycareApptList != null) {
      if (daycareApptList.isNotEmpty) {
        list.add(_createApptsCategories(1));
      }
    }

    if (stheticApptList != null) {
      if (stheticApptList.isNotEmpty) {
        list.add(_createApptsCategories(2));
      }
    }

    if (hotelApptList != null) {
      if (hotelApptList.isNotEmpty) {
        list.add(_createApptsCategories(3));
      }
    }
    if (veterinaryApptList != null) {
      if (veterinaryApptList.isNotEmpty) {
        list.add(_createApptsCategories(4));
      }
    }
    if (!daycareFilter.selected &&
        !stheticFilter.selected &&
        !hotelFilter.selected &&
        !veterinaryFilter.selected) {
      return _showMessage(
          "Presiona uno de los filtros para poder ver información", true);
    }
    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  Widget _showMessage(String message, bool isFilters) {
    String typeIcon;
    if (isFilters) {
      typeIcon = 'assets/gif/alert.gif';
    } else {
      typeIcon = 'assets/gif/dog.gif';
    }
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: _screenSize.width * 0.4,
            child: Image.asset(typeIcon),
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

  Widget _createApptsCategories(int type) {
    String title;
    Color backgroundColor;
    Color apptsColor;
    List<Appointment> appointmentsConfirmed = [];
    List<Appointment> appointmentsNonConfirmed = [];
    Appointment appointmentTemp;

    switch (type) {
      case 1:
        daycareApptList.forEach((element) {
          appointmentTemp = element;
          if (element.isConfirmed) {
            appointmentsConfirmed.add(appointmentTemp);
          } else {
            appointmentsNonConfirmed.add(appointmentTemp);
          }
        });
        title = "Guardería";
        backgroundColor = ColorsApp.primaryColorPinkDegraded;
        apptsColor = ColorsApp.primaryColorPink;
        break;
      case 2:
        stheticApptList.forEach((element) {
          appointmentTemp = element;
          if (element.isConfirmed) {
            appointmentsConfirmed.add(appointmentTemp);
          } else {
            appointmentsNonConfirmed.add(appointmentTemp);
          }
        });
        title = "Estética";
        backgroundColor = ColorsApp.primaryColorBlueDegraded;
        apptsColor = ColorsApp.primaryColorBlue;
        break;
      case 3:
        hotelApptList.forEach((element) {
          appointmentTemp = element;
          if (element.isConfirmed) {
            appointmentsConfirmed.add(appointmentTemp);
          } else {
            appointmentsNonConfirmed.add(appointmentTemp);
          }
        });
        title = "Hotel";
        backgroundColor = ColorsApp.primaryColorOrangeDegraded;
        apptsColor = ColorsApp.primaryColorOrange;
        break;
      case 4:
        veterinaryApptList.forEach((element) {
          appointmentTemp = element;
          if (element.isConfirmed) {
            appointmentsConfirmed.add(appointmentTemp);
          } else {
            appointmentsNonConfirmed.add(appointmentTemp);
          }
        });
        title = "Veterinaria";
        backgroundColor = ColorsApp.primaryColorTurquoiseDegraded;
        apptsColor = ColorsApp.primaryColorTurquoise;
        break;
    }
    return createIndividualCategory(title, backgroundColor, apptsColor,
        appointmentsConfirmed, appointmentsNonConfirmed, type);
  }

  Widget createIndividualCategory(
      String title,
      Color backgroundColor,
      Color apptColor,
      List<Appointment> confirmed,
      List<Appointment> nonConfirmed,
      int type) {
    Column confirmedWidget = new Column();
    Column nonConfirmedWidget = new Column();
    if (confirmed.isNotEmpty) {
      confirmedWidget = createApptsAccordingStatus(
          "Citas confirmadas", confirmed, apptColor, Colors.white, type);
    }
    if (nonConfirmed.isNotEmpty) {
      nonConfirmedWidget = createApptsAccordingStatus("Citas sin confirmar",
          nonConfirmed, Colors.white, Colors.black, type);
    }
    return Card(
        color: backgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            Container(
              child: Text(title, style: TextStyle(fontSize: 18)),
            ),
            confirmedWidget,
            nonConfirmedWidget,
          ],
        ));
  }

  Widget createApptsAccordingStatus(String status, List<Appointment> list,
      Color apptColorReceived, Color textColor, int type) {
    return Column(
      children: [
        Container(
          width: _screenSize.width * 0.8,
          child: Text(
            status,
            style: TextStyle(fontSize: 13),
          ),
        ),
        Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: null,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              Appointment temp = list[index];
              String name = temp.entryUser.userName;
              if (temp.entryUser.lastName != null) {
                name += " " + temp.entryUser.lastName;
              }
              if (type == 4) {
                VeterinaryAppt vet = temp;
              }
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'apptDetails',
                    arguments: temp,
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          height: 34,
                          alignment: Alignment.center,
                          width: _screenSize.width * 0.235,
                          margin: EdgeInsets.symmetric(vertical: 1),
                          child: Text(
                            _getTime(temp.entryDate.toDate()),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _screenSize.width * 0.043),
                          )),
                      SizedBox(
                        width: _screenSize.width * 0.01,
                      ),*/
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                            color: apptColorReceived,
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          width: _screenSize.width * 0.8,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  width: _screenSize.width * 0.47,
                                  child: Text(
                                    name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: textColor, fontSize: 13),
                                  )),
                              SizedBox(
                                width: 2,
                              ),
                              Icon(FontAwesomeIcons.chevronRight,
                                  color: textColor, size: 20)
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
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
