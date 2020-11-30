import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      ColorsApp.primaryColorBlue, ColorsApp.primaryColorBlueDegraded, true);
  FilterAppts veterinaryFilter = new FilterAppts(
      'Veter.',
      ColorsApp.primaryColorTurquoise,
      ColorsApp.primaryColorTurquoiseDegraded,
      true);
  FilterAppts daycareFilter = new FilterAppts('Guard.',
      ColorsApp.primaryColorPink, ColorsApp.primaryColorPinkDegraded, true);
  FilterAppts hotelFilter = new FilterAppts('Hotel',
      ColorsApp.primaryColorOrange, ColorsApp.primaryColorOrangeDegraded, true);

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
            future:
                appointmentsRepository.getDaycareApptList(_selectedDate.day),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              print("antes de comprobación");
              if (snapshot.hasData) {
                print("snap has data");
                return _createList(snapshot.data);
              } else {
                print("snap NOT has data");
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

  Future<List<List<dynamic>>> _getAppoitments() async {
    List<List<dynamic>> list = new List();
    if (daycareFilter.selected) {
      daycareApptList =
          await appointmentsRepository.getDaycareApptList(_selectedDate.day);
      daycareApptList.sort((a, b) => a.entryDate.compareTo(b.entryDate));
      list.add(daycareApptList);
    } else {
      daycareApptList.clear();
    }

    if (stheticFilter.selected) {
      stheticApptList =
          await appointmentsRepository.getStheticApptList(_selectedDate.day);
      list.add(stheticApptList);
    } else {
      stheticApptList.clear();
    }

    if (hotelFilter.selected) {
      hotelApptList =
          await appointmentsRepository.getHotelApptList(_selectedDate.day);
      list.add(hotelApptList);
    } else {
      hotelApptList.clear();
    }

    if (veterinaryFilter.selected) {
      veterinaryApptList =
          await appointmentsRepository.getVeterinaryApptList(_selectedDate.day);
      list.add(veterinaryApptList);
    } else {
      veterinaryApptList.clear();
    }
    return list;
  }

  Widget _createList(List<DaycareAppt> listReceived) {
    List<Widget> list = new List();
    if (daycareApptList.isNotEmpty) {
      list.add(_createHour("AAAAAA"));
      print("aaaaa");
    }
    if (listReceived.isNotEmpty) {
      list.add(_createHour("PUTA"));
      print("ppppp");
    }
    print("BBBBBBBBBBB");
    /*for (int i = 8; i < 18; i++) {
      list.add(_createHour("$i:00 AM"));
    }*/
    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  Widget _createHour(String hour) {
    List<Widget> appointments = new List();
    for (int i = 0; i < 3; i++) {
      appointments.add(_createAppoitment(
          "Este es un nombre de prueba $i", ColorsApp.primaryColorBlue));
    }

    return Card(
      color: Color(0xFFD0D5FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: _screenSize.width * 0.87,
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: _screenSize.width * 0.003,
            ),
            Card(
                child: Container(
              alignment: Alignment.center,
              width: _screenSize.width * 0.28,
              margin: EdgeInsets.symmetric(vertical: 1),
              child: Text(
                hour,
                style: TextStyle(
                    color: Colors.black, fontSize: _screenSize.width * 0.045),
              ),
            )),
            SizedBox(
              width: _screenSize.width * 0.01,
            ),
            Column(
              children: appointments,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAppoitment(String userName, Color color) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        width: _screenSize.width * 0.54,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: _screenSize.width * 0.45,
              child: Text(
                userName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            GestureDetector(
              child: Icon(
                FontAwesomeIcons.chevronRight,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        ));
  }
}

class FilterAppts {
  FilterAppts(
      this.name, this.selectionColor, this.nonSelectionColor, this.selected);
  final String name;
  final Color selectionColor;
  final Color nonSelectionColor;
  bool selected;
}
