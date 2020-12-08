import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';
import 'package:lamanda_admin/models/appointment/apptStay.dart';
import 'package:lamanda_admin/models/appointment/daycare.dart';
import 'package:lamanda_admin/models/appointment/esthetic.dart';
import 'package:lamanda_admin/models/appointment/hotel.dart';
import 'package:lamanda_admin/models/appointment/veterinary.dart';
import 'package:lamanda_admin/models/pet.dart';
import 'package:lamanda_admin/models/userProfile.dart';
import 'package:lamanda_admin/repository/appointments_repository.dart';
import 'package:lamanda_admin/repository/pet_repository.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/widgets/appBar.dart';

class ApptDetails extends StatefulWidget {
  @override
  _ApptDetailsState createState() => _ApptDetailsState();
}

class _ApptDetailsState extends State<ApptDetails> {
  Appointment appt;
  UserProfile user;
  Color backgroundColor;
  Color apptColor;
  Color degradedColor;
  int type;
  Size _screenSize;
  String loadingGif;
  @override
  Widget build(BuildContext context) {
    appt = ModalRoute.of(context).settings.arguments;
    user = appt.entryUser;
    _screenSize = MediaQuery.of(context).size;

    switch (appt.runtimeType) {
      case DaycareAppt:
        loadingGif = 'assets/gif/pinkCat.gif';
        type = 1;
        backgroundColor = ColorsApp.primaryColorPinkDegraded;
        apptColor = ColorsApp.primaryColorPink;
        degradedColor = ColorsApp.primaryColorPinkDegraded2;
        break;
      case EstheticAppt:
        loadingGif = 'assets/gif/blueCat.gif';
        type = 2;
        backgroundColor = ColorsApp.primaryColorBlueDegraded;
        apptColor = ColorsApp.primaryColorBlue;
        degradedColor = ColorsApp.primaryColorBlueDegraded2;
        break;
      case HotelAppt:
        loadingGif = 'assets/gif/orangeCat.gif';
        type = 3;
        backgroundColor = ColorsApp.primaryColorOrangeDegraded;
        apptColor = ColorsApp.primaryColorOrange;
        degradedColor = ColorsApp.primaryColorOrangeDegraded2;
        break;
      case VeterinaryAppt:
        loadingGif = 'assets/gif/turCat.gif';
        type = 4;
        backgroundColor = ColorsApp.primaryColorTurquoiseDegraded;
        apptColor = ColorsApp.primaryColorTurquoise;
        degradedColor = ColorsApp.primaryColorTurquoiseDegraded2;
        break;
    }
    print(appt.id);
    return Scaffold(
        appBar: titlePage(context),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: new BorderRadius.circular(8.0),
            ),
            margin: EdgeInsets.only(top: 10),
            height: _screenSize.height * 0.84,
            width: _screenSize.width * 0.93,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _createHeader(),
                _createDepartureInformation(),
                _createBody(),
                _createApptCondition(context)
              ],
            ),
          ),
        ));
  }

  Widget _createHeader() {
    String name;
    if (user.lastName != null) {
      name = user.userName + " " + user.lastName;
    } else {
      name = user.userName;
    }
    String url;
    if (user.photoUri != null) {
      url = user.photoUri;
    } else {
      url = 'assets/img/no-image.png';
    }
    Widget hourContainer = Container();
    if (type == 2) {
      EstheticAppt sthetic = appt;
      hourContainer = _createInformation(_getTime(sthetic.entryHour.toDate()),
          0.018, Colors.grey[200], FontWeight.bold);
    }
    if (type == 1) {
      DaycareAppt daycare = appt;
      hourContainer = _createInformation(_getTime(daycare.entryHour.toDate()),
          0.018, Colors.grey[200], FontWeight.bold);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(8.0),
          ),
          width: _screenSize.width * 0.61,
          height: _screenSize.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: FadeInImage(
                    image: NetworkImage(url),
                    placeholder: AssetImage(loadingGif),
                    fit: BoxFit.cover,
                    height: 150.0,
                  ),
                ),
              ),
              SizedBox(
                width: _screenSize.width * 0.02,
              ),
              Container(
                width: _screenSize.width * 0.4,
                child: Column(
                  children: [
                    Container(
                      height: _screenSize.height * 0.052,
                      child: Text(
                        name,
                        style: TextStyle(fontSize: _screenSize.height * 0.018),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        user.email,
                        style: TextStyle(fontSize: _screenSize.height * 0.011),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: _screenSize.width * 0.03,
        ),
        Container(
          decoration: BoxDecoration(
            color: apptColor,
            borderRadius: new BorderRadius.circular(10.0),
          ),
          width: _screenSize.width * 0.23,
          height: _screenSize.height * 0.12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _createInformation(appt.entryDate.toDate().day.toString(), 0.043,
                  Colors.white, FontWeight.bold),
              _createInformation(
                  _getDayText(), 0.017, Colors.grey[200], FontWeight.bold),
              hourContainer
            ],
          ),
        )
      ],
    );
  }

  Widget _createInformation(
      String inf, double size, Color textColor, FontWeight fontWeight) {
    return Text(
      inf,
      style: TextStyle(
          fontSize: _screenSize.height * size,
          fontWeight: fontWeight,
          color: textColor),
    );
  }

  Widget _createDepartureInformation() {
    if (type == 1 || type == 3) {
      ApptStay appts = appt;

      Widget hourContainer = Container();
      if (type == 1) {
        DaycareAppt daycare = appt;
        print(daycare.departureDate.toDate().hour);
        hourContainer = _createInformation(
            _getTime(daycare.departureDate.toDate()),
            0.022,
            Colors.white,
            FontWeight.normal);
      }
      return Container(
        margin: EdgeInsets.only(top: _screenSize.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Salida",
              style: TextStyle(fontSize: _screenSize.width * 0.06),
            ),
            SizedBox(
              width: _screenSize.width * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: apptColor,
                borderRadius: new BorderRadius.circular(8.0),
              ),
              width: _screenSize.width * 0.66,
              height: _screenSize.height * 0.06,
              child: Row(
                children: [
                  SizedBox(
                    width: _screenSize.width * 0.01,
                  ),
                  hourContainer,
                  SizedBox(
                    width: _screenSize.width * 0.02,
                  ),
                  Container(
                    width: _screenSize.width * 0.4,
                    child: _createInformation(appts.departureUser, 0.018,
                        Colors.white, FontWeight.normal),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
    return Container();
  }

  Widget _createBody() {
    double principalContainerHeight;
    double petInformationHeight;
    Container symptoms = new Container();
    if (type == 1 || type == 3) {
      principalContainerHeight = _screenSize.height * 0.55;
      if (appt.transfer) {
        petInformationHeight = _screenSize.height * 0.35;
      } else {
        petInformationHeight = _screenSize.height * 0.4;
      }
    } else {
      principalContainerHeight = _screenSize.height * 0.61;
      if (appt.transfer) {
        petInformationHeight = _screenSize.height * 0.415;
      } else {
        petInformationHeight = _screenSize.height * 0.515;
      }
      if (type == 4) {
        VeterinaryAppt vet = appt;
        symptoms = new Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(8.0),
          ),
          height: _screenSize.height * 0.14,
          width: _screenSize.width * 0.83,
          child: Column(
            children: [
              Text("Síntomas"),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: _screenSize.width * 0.88,
                    margin: EdgeInsets.all(2),
                    child: Text(
                      vet.symptoms + "asd asd dasdsad asdasd asdasd",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: _screenSize.width * 0.035),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.symmetric(vertical: _screenSize.height * 0.01),
      width: _screenSize.width * 0.89,
      height: principalContainerHeight,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: _screenSize.width * 0.01,
                vertical: _screenSize.height * 0.01),
            child: Text(
              "Información de mascota:",
              style: TextStyle(fontSize: _screenSize.width * 0.04),
            ),
          ),
          Container(
              width: _screenSize.width * 0.85,
              height: petInformationHeight,
              child: _showPetInformation()),
          _createDirectionInformation()
        ],
      ),
    );
  }

  Widget _showPetInformation() {
    switch (type) {
      case 2:
        EstheticAppt sthetic = appt;
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tipo de pelaje:",
                style: TextStyle(
                    fontSize: _screenSize.width * 0.05,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: _screenSize.width * 0.05,
              ),
              Text(
                sthetic.fur,
                style: TextStyle(fontSize: _screenSize.width * 0.05),
              ),
            ],
          ),
        );
        break;
      case 3:
        HotelAppt hotel = appt;
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _showSpecificInformationBool("Castrado", hotel.isCastrated),
              _showSpecificInformationBool("Sociable", hotel.isSociable),
              _showSpecificInformationBool(
                  "Vacunado", hotel.isVaccinationUpDate),
              _showSpecificInformationBool("Castrado", hotel.isCastrated),
              _showSpecificInformationDate(
                  "Desparacitado el:", hotel.lastDeworming),
              _showSpecificInformationDate(
                  "Protección de plagas el:", hotel.lastProtectionFleas),
              _showSpecificInformationText("Raza:", hotel.race.toString()),
              _showSpecificInformationText("Edad:", hotel.age.toString()),
            ],
          ),
        );
        break;
      case 1:
        DaycareAppt daycare = appt;
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _showSpecificInformationBool("Castrado", daycare.isCastrated),
              _showSpecificInformationBool("Sociable", daycare.isSociable),
              _showSpecificInformationBool(
                  "Vacunado", daycare.isVaccinationUpDate),
              _showSpecificInformationBool("Castrado", daycare.isCastrated),
              _showSpecificInformationDate(
                  "Desparacitado el:", daycare.lastDeworming),
              _showSpecificInformationDate(
                  "Protección de plagas el:", daycare.lastProtectionFleas),
              _showSpecificInformationText("Raza:", daycare.race.toString()),
              _showSpecificInformationText("Edad:", daycare.age.toString()),
            ],
          ),
        );
        break;
      case 4:
        if (type == 4) {
          VeterinaryAppt vet = appt;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(8.0),
            ),
            height: _screenSize.height * 0.14,
            width: _screenSize.width * 0.83,
            child: Column(
              children: [
                _showSpecificInformationText("Raza:", vet.race.toString()),
                SizedBox(
                  height: _screenSize.height * 0.05,
                ),
                Text("Síntomas"),
                Container(
                  width: _screenSize.width * 0.88,
                  margin: EdgeInsets.all(2),
                  child: Text(
                    vet.symptoms + "asd asd dasdsad asdasd asdasd",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: _screenSize.width * 0.035),
                  ),
                ),
              ],
            ),
          );
        }
        break;
      default:
    }
    return Container();
  }

  Widget _showSpecificInformationBool(String atribute, bool condition) {
    if (condition != null) {
      Icon icon;
      if (condition) {
        icon = new Icon(FontAwesomeIcons.check);
      } else {
        icon = new Icon(FontAwesomeIcons.times);
      }
      return Container(
        width: _screenSize.width * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              atribute,
              style: TextStyle(
                  fontSize: _screenSize.width * 0.05,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: _screenSize.width * 0.05,
            ),
            Container(
              child: icon,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _showSpecificInformationDate(String atribute, Timestamp date) {
    if (date != null) {
      return Container(
        width: _screenSize.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              atribute,
              style: TextStyle(
                  fontSize: _screenSize.width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: _screenSize.width * 0.05,
            ),
            Text(
              date.toDate().day.toString() +
                  "-" +
                  date.toDate().month.toString() +
                  "-" +
                  date.toDate().year.toString(),
              style: TextStyle(
                  fontSize: _screenSize.width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _showSpecificInformationText(String atribute, String value) {
    if (value != null) {
      return Container(
        width: _screenSize.width * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              atribute,
              style: TextStyle(
                  fontSize: _screenSize.width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: _screenSize.width * 0.05,
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: _screenSize.width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
  /* Widget _createBody() {
    double principalContainerHeight;
    double petInformationHeight;
    Container symptoms = new Container();
    if (type == 1 || type == 3) {
      principalContainerHeight = _screenSize.height * 0.55;
      if (appt.transfer) {
        petInformationHeight = _screenSize.height * 0.355;
      } else {
        petInformationHeight = _screenSize.height * 0.46;
      }
    } else {
      principalContainerHeight = _screenSize.height * 0.61;
      if (appt.transfer) {
        petInformationHeight = _screenSize.height * 0.415;
      } else {
        petInformationHeight = _screenSize.height * 0.515;
      }
      if (type == 4) {
        VeterinaryAppt vet = appt;
        symptoms = new Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(8.0),
          ),
          height: _screenSize.height * 0.14,
          width: _screenSize.width * 0.83,
          child: Column(
            children: [
              Text("Síntomas"),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: _screenSize.width * 0.88,
                    margin: EdgeInsets.all(2),
                    child: Text(
                      vet.symptoms + "asd asd dasdsad asdasd asdasd",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: _screenSize.width * 0.035),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.symmetric(vertical: _screenSize.height * 0.01),
      width: _screenSize.width * 0.89,
      height: principalContainerHeight,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: _screenSize.width * 0.01,
                vertical: _screenSize.height * 0.01),
            child: Text(
              "Información de mascota(s):",
              style: TextStyle(fontSize: _screenSize.width * 0.04),
            ),
          ),
          Container(
            width: _screenSize.width * 0.85,
            height: petInformationHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemCount: user.petList.length,
                      itemBuilder: (BuildContext context, int index) {
                        int i = index + 1;
                        return FutureBuilder(
                          future:
                              PetRepository().getPet(user.petList['pet$i'].id),
                          builder: (BuildContext context,
                              AsyncSnapshot<Pet> snapshot) {
                            if (snapshot.hasData) {
                              return _createIndividualPetInformation(
                                  snapshot.data);
                            } else {
                              return Container(
                                height: 100,
                                child: Image.asset(loadingGif),
                              );
                            }
                          },
                        );
                      }),
                  symptoms
                ],
              ),
            ),
          ),
          _createDirectionInformation()
        ],
      ),
    );
  }*/

/*
  Widget _createPetTextAtribute(String atribute, String value) {
    return Container(
      width: _screenSize.width * 0.42,
      child: Row(
        children: [
          Text(
            atribute + ": ",
            style: TextStyle(
                fontSize: _screenSize.height * 0.02,
                fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: _screenSize.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }*/
/*
  Widget _createPetConditionAtribute(String atribute, bool condition) {
    Color backColor;
    Color textColor;
    Icon icon;
    if (condition) {
      backColor = apptColor;
      textColor = Colors.white;
      icon = Icon(
        FontAwesomeIcons.check,
        color: Colors.grey[600],
        size: 12,
      );
    } else {
      backColor = Colors.white;
      textColor = Colors.grey;
      icon = Icon(
        FontAwesomeIcons.times,
        color: Colors.grey,
        size: 14,
      );
    }
    return Container(
      width: _screenSize.width * 0.38,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              child: icon),
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(
              atribute,
              style: TextStyle(
                  fontSize: _screenSize.width * 0.036, color: textColor),
            ),
          ),
        ],
      ),
    );
  }*/

  Widget _createDirectionInformation() {
    if (appt.transfer) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey)),
        height: _screenSize.height * 0.14,
        width: _screenSize.width * 0.83,
        child: Column(
          children: [
            Text("Dirección domicilio"),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(2),
                  child: Text(
                    appt.direction,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: _screenSize.width * 0.035),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      height: _screenSize.height * 0.04,
      child: Text(
        "* No se requiere recogida a domicilio",
        style: TextStyle(
            color: Colors.black,
            fontSize: _screenSize.width * 0.04,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _createApptCondition(BuildContext contextPage) {
    Color color;
    Color textColor;
    String confirmedCondition;
    Icon icon;
    double divider;

    Widget actionArea;

    if (appt.isConfirmed) {
      divider = _screenSize.width * 0.26;
      color = apptColor;
      confirmedCondition = "Confirmada";
      textColor = Colors.white;
      icon = Icon(
        FontAwesomeIcons.check,
        color: Colors.white,
      );
      actionArea = Row(
        children: [
          /*GestureDetector(
            onTap: () => _editAppt(context),
            child: new Container(
              width: _screenSize.width * 0.12,
              height: _screenSize.height * 0.05,
              child: Icon(
                FontAwesomeIcons.pen,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),*/
          GestureDetector(
            onTap: () =>
                _showAlert(context, contextPage, "Eliminar cita?", false),
            child: new Container(
              width: _screenSize.width * 0.12,
              height: _screenSize.height * 0.05,
              child: Icon(
                FontAwesomeIcons.trash,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    } else {
      divider = _screenSize.width * 0.06;
      color = degradedColor;
      confirmedCondition = "Sin confirmar";
      textColor = Colors.grey[700];
      icon = Icon(
        FontAwesomeIcons.ellipsisH,
        color: Colors.grey[700],
      );
      actionArea = new Container(
        width: _screenSize.width * 0.32,
        height: _screenSize.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () =>
                  _showAlert(context, contextPage, "¿Confirmar cita?", true),
              child: Container(
                decoration: BoxDecoration(
                  color: apptColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                width: _screenSize.width * 0.16,
                height: _screenSize.height * 0.05,
                child: Icon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () =>
                  _showAlert(context, contextPage, "¿Rechazar cita?", false),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                height: _screenSize.height * 0.05,
                width: _screenSize.width * 0.16,
                child: Icon(
                  FontAwesomeIcons.times,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      width: _screenSize.width * 0.855,
      height: _screenSize.height * 0.06,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text(
              confirmedCondition,
              style: TextStyle(
                  color: textColor,
                  fontSize: _screenSize.width * 0.05,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: divider,
            ),
            actionArea
          ],
        ),
      ),
    );
  }

  void _showAlert(BuildContext context, BuildContext contextPage,
      String message, bool isConfirm) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            backgroundColor: degradedColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: null,
            content: Text(
              message,
              style: TextStyle(fontSize: 22),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    'Sí',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _updateAppt(isConfirm, contextPage);
                  }),
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  /*void _editAppt(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            backgroundColor: degradedColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(
              "Editar cita",
              style: TextStyle(fontSize: 22),
            ),
            content: null,
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    'Guardar',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _update();
                  }),
              FlatButton(
                child: Text(
                  'Volver',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }*/

  void _left(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  void _updateAppt(bool isConfirm, BuildContext contextPage) {
    setState(() {
      if (isConfirm) {
        appt.isConfirmed = true;
        _update();
      } else {
        appt.isDeclined = true;
        switch (appt.runtimeType) {
          case DaycareAppt:
            AppointmentsRepository().deleteDaycare(appt.id);
            break;
          case EstheticAppt:
            AppointmentsRepository().deleteSthetic(appt.id);
            break;
          case HotelAppt:
            AppointmentsRepository().deleteHotel(appt.id);
            break;
          case VeterinaryAppt:
            AppointmentsRepository().deleteVeterinary(appt.id);
            break;
          default:
        }
        _left(contextPage);
      }
    });
  }

  void _update() {
    switch (appt.runtimeType) {
      case DaycareAppt:
        AppointmentsRepository().updateDaycare(appt);
        break;
      case EstheticAppt:
        AppointmentsRepository().updateSthetic(appt);
        break;
      case HotelAppt:
        AppointmentsRepository().updateHotel(appt);
        break;
      case VeterinaryAppt:
        AppointmentsRepository().updateVeterinary(appt);
        break;
      default:
    }
  }

  String _getDayText() {
    switch (appt.entryDate.toDate().weekday) {
      case 1:
        return "Lunes";
        break;
      case 2:
        return "Mártes";
        break;
      case 3:
        return "Miércoles";
        break;
      case 4:
        return "Jueves";
        break;
      case 5:
        return "Viernes";
        break;
      case 6:
        return "Sábado";
        break;
      case 7:
        return "Domingo";
        break;
      default:
    }
    return "";
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
