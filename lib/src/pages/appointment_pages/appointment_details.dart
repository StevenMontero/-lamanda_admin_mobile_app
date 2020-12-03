import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_admin/models/appointment/appointment.dart';
import 'package:lamanda_admin/models/appointment/daycare.dart';
import 'package:lamanda_admin/models/appointment/esthetic.dart';
import 'package:lamanda_admin/models/appointment/hotel.dart';
import 'package:lamanda_admin/models/appointment/veterinary.dart';
import 'package:lamanda_admin/models/userProfile.dart';
import 'package:lamanda_admin/repository/user_repository.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/widgets/appBar.dart';

class ApptDetails extends StatefulWidget {
  @override
  _ApptDetailsState createState() => _ApptDetailsState();
}

class _ApptDetailsState extends State<ApptDetails> {
  Appointment appt;
  Color backgroundColor;
  Color apptColor;
  Color degradedColor;
  int type;
  Size _screenSize;
  @override
  Widget build(BuildContext context) {
    appt = ModalRoute.of(context).settings.arguments;
    _screenSize = MediaQuery.of(context).size;

    switch (appt.runtimeType) {
      case DaycareAppt:
        type = 1;
        backgroundColor = ColorsApp.primaryColorPinkDegraded;
        apptColor = ColorsApp.primaryColorPink;
        degradedColor = ColorsApp.primaryColorPinkDegraded2;
        break;
      case EstheticAppt:
        type = 2;
        backgroundColor = ColorsApp.primaryColorBlueDegraded;
        apptColor = ColorsApp.primaryColorBlue;
        degradedColor = ColorsApp.primaryColorBlueDegraded2;
        break;
      case HotelAppt:
        type = 3;
        backgroundColor = ColorsApp.primaryColorOrangeDegraded;
        apptColor = ColorsApp.primaryColorOrange;
        degradedColor = ColorsApp.primaryColorOrangeDegraded2;
        break;
      case VeterinaryAppt:
        type = 4;
        backgroundColor = ColorsApp.primaryColorTurquoiseDegraded;
        apptColor = ColorsApp.primaryColorTurquoise;
        degradedColor = ColorsApp.primaryColorTurquoiseDegraded2;
        break;
    }
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
                _createInformationCondition()
              ],
            ),
          ),
        ));
  }

  Widget _createHeader() {
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
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: new BorderRadius.circular(30),
                  )),
              SizedBox(
                width: _screenSize.width * 0.02,
              ),
              Container(
                  width: _screenSize.width * 0.4,
                  child: FutureBuilder(
                    future: UserRepository().getUserProfile(appt.entryUser.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<UserProfile> snapshot) {
                      if (snapshot.hasData) {
                        String name;
                        if (snapshot.data.lastName != null) {
                          name = snapshot.data.userName +
                              " " +
                              snapshot.data.lastName;
                        } else {
                          name = snapshot.data.userName;
                        }
                        return Column(
                          children: [
                            Container(
                              height: _screenSize.height * 0.052,
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontSize: _screenSize.height * 0.018),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                snapshot.data.phone,
                                style: TextStyle(
                                    fontSize: _screenSize.height * 0.025),
                              ),
                            )
                          ],
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
        )
      ],
    );
  }

  Widget _createDepartureInformation() {
    if (type == 1 || type == 3) {
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
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.symmetric(vertical: _screenSize.height * 0.01),
      width: _screenSize.width * 0.855,
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
            width: _screenSize.width * 0.83,
            height: petInformationHeight,
            child: SingleChildScrollView(
                //informacion mascotas
                ),
          ),
          _createDirectionInformation()
        ],
      ),
    );
  }

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

  Widget _createInformationCondition() {
    Color color;
    String confirmedCondition;
    String actionMessage;
    Icon icon;

    FlatButton(onPressed: null, child: Text("Rechazar"));

    if (appt.isConfirmed) {
      color = apptColor;
      confirmedCondition = "Confirmada";
      actionMessage = "Modificar";
      icon = Icon(FontAwesomeIcons.check);
    } else {
      color = degradedColor;
      confirmedCondition = "Sin confirmar";
      actionMessage = "Confirmar";
    }

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      width: _screenSize.width * 0.855,
      height: _screenSize.height * 0.06,
    );
  }
}
