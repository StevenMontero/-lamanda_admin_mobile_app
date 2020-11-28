import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_admin/models/appointment/daycare.dart';
import 'package:lamanda_admin/repository/appointments_repository.dart';
import 'package:lamanda_admin/src/pages/appointment_pages/individualFilter.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/widgets/appBar.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  double heightCard = 40.0;
  double widthCard;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
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
          _filterBar(context),
          _listAppointments(_screenSize)
        ],
      ),
    );
  }

  Widget _filterBar(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IndividualFilter(1),
          SizedBox(width: 5.0),
          IndividualFilter(2),
          SizedBox(width: 5.0),
          IndividualFilter(3),
          SizedBox(width: 5.0),
          IndividualFilter(4),
        ],
      ),
    );
  }

  Widget _listAppointments(Size screenSize) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: screenSize.width * 0.95,
      height: screenSize.height * 0.775,
      decoration: BoxDecoration(
        color: Color(0xFF6C78EB),
        borderRadius: new BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 2),
          _createMonthHeader(screenSize),
          _createDaysName(screenSize),
          _createApptContainer(screenSize)
        ],
      ),
    );
  }

  Widget _createMonthHeader(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: null,
          child: Icon(
            FontAwesomeIcons.chevronLeft,
            color: Colors.white,
            size: screenSize.height * 0.03,
          ),
        ),
        SizedBox(width: 25),
        Text(
          "Septiembre 2020",
          style: TextStyle(
              color: Colors.white, fontSize: screenSize.width * 0.045),
        ),
        SizedBox(width: 25),
        GestureDetector(
          onTap: null,
          child: Icon(
            FontAwesomeIcons.chevronRight,
            color: Colors.white,
            size: screenSize.height * 0.03,
          ),
        ),
      ],
    );
  }

  Widget _createDaysName(Size screenSize) {
    double sizedBox = screenSize.width * 0.06;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _createDay(screenSize, "Lun"),
        SizedBox(width: sizedBox),
        _createDay(screenSize, "Mar"),
        SizedBox(width: sizedBox),
        _createDay(screenSize, "Mie"),
        SizedBox(width: sizedBox),
        _createDay(screenSize, "Jue"),
        SizedBox(width: sizedBox),
        _createDay(screenSize, "Vie"),
        SizedBox(width: sizedBox),
        _createDay(screenSize, "Sab"),
        SizedBox(width: sizedBox),
        _createDay(screenSize, "Dom"),
      ],
    );
  }

  Widget _createDay(Size screenSize, String name) {
    double size = screenSize.width * 0.04;
    return GestureDetector(
      onTap: null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: size),
          ),
          Text(
            "01",
            style: TextStyle(color: Colors.white, fontSize: size),
          ),
        ],
      ),
    );
  }

  Widget _createApptContainer(Size screenSize) {
    double titlesSize = screenSize.width * 0.045;
    return Container(
      margin: EdgeInsets.only(top: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.652,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: screenSize.width * 0.1,
              ),
              Text(
                "Hora",
                style: TextStyle(color: Colors.black, fontSize: titlesSize),
              ),
              SizedBox(
                width: screenSize.width * 0.3,
              ),
              Text(
                "Detalles",
                style: TextStyle(color: Colors.black, fontSize: titlesSize),
              ),
            ],
          ),
          Expanded(child: _createList(screenSize))
        ],
      ),
    );
  }

  Widget _createList(Size screenSize) {
    List<Widget> list = new List();
    for (int i = 8; i < 18; i++) {
      list.add(_createHour(screenSize, "$i:00 AM"));
    }
    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  Widget _createHour(Size screenSize, String hour) {
    List<Widget> appointments = new List();
    for (int i = 0; i < 3; i++) {
      appointments.add(_createAppoitment(screenSize,
          "Este es un nombre de prueba $i", ColorsApp.primaryColorBlue));
    }

    return Card(
      color: Color(0xFFD0D5FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: screenSize.width * 0.87,
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width * 0.003,
            ),
            Card(
                child: Container(
              alignment: Alignment.center,
              width: screenSize.width * 0.28,
              margin: EdgeInsets.symmetric(vertical: 1),
              child: Text(
                hour,
                style: TextStyle(
                    color: Colors.black, fontSize: screenSize.width * 0.05),
              ),
            )),
            SizedBox(
              width: screenSize.width * 0.01,
            ),
            Column(
              children: appointments,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAppoitment(Size screenSize, String userName, Color color) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        width: screenSize.width * 0.54,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: screenSize.width * 0.45,
              child: Text(
                userName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 15),
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

  void refreshList() {}
}
