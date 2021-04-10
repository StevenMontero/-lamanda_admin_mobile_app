import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lamanda_admin/models/daycare_appointment.dart';
import 'package:lamanda_admin/models/hotel_appointment.dart';
import 'package:lamanda_admin/models/sthetic_appointment.dart';
import 'package:lamanda_admin/models/veterinary_appointment.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/utils/get_date_hour.dart';
import 'package:lamanda_admin/src/utils/get_day_text.dart';

class AppoimentDetail extends StatefulWidget {
  @override
  _AppoimentDetailState createState() => _AppoimentDetailState();
}

class _AppoimentDetailState extends State<AppoimentDetail> {
  Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _titlePage(context) as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _body() {
    final dynamic appoiment = ModalRoute.of(context)!.settings.arguments;
    if (appoiment is DaycareAppointment) {
      backgroundColor = ColorsApp.primaryColorPinkDegraded;
      return getDayCareAppoimentInfo(appoiment);
    } else if (appoiment is StheticAppointment) {
      backgroundColor = ColorsApp.primaryColorBlueDegraded;
      return getStheticAppoimentInfo(appoiment);
    } else if (appoiment is HotelAppointment) {
      backgroundColor = ColorsApp.primaryColorOrangeDegraded;
      return Center();
    } else if (appoiment is VeterinaryAppointment) {
      backgroundColor = ColorsApp.primaryColorTurquoiseDegraded;
      return Center();
    } else {
      return Center();
    }
  }
  //Detalle de las citas de guarrderia 
  Widget getDayCareAppoimentInfo(DaycareAppointment appoiment) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(14),
        height: MediaQuery.of(context).size.height * 1.3,
        width: MediaQuery.of(context).size.width * 0.96,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.67,
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: FadeInImage(
                            image: NetworkImage(appoiment.client!.photoUri!),
                            placeholder: AssetImage('assets/gif/pinkCat.gif'),
                            fit: BoxFit.cover,
                            height: 150.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.042,
                              child: Text(
                                appoiment.client!.userName!,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                appoiment.client!.email!,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                appoiment.client!.phone!,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.primaryColorPink,
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _formatInfo(appoiment.entryHour!.day.toString(), 0.043,
                          Colors.white, FontWeight.bold),
                      _formatInfo(DayText.getDayText(appoiment.date!.weekday),
                          0.020, Colors.grey[200], FontWeight.bold),
                      _formatInfo(DateHour.getTime(appoiment.entryHour!), 0.018,
                          Colors.grey[200], FontWeight.bold),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Salida",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorsApp.primaryColorPink,
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    width: MediaQuery.of(context).size.width * 0.66,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        _formatInfo(DateHour.getTime(appoiment.departureHour!),
                            0.022, Colors.white, FontWeight.normal),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: _formatInfo(appoiment.userPickup!, 0.018,
                              Colors.white, FontWeight.normal),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(8.0),
              ),
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01),
              width: MediaQuery.of(context).size.width * 0.89,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.01,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Text(
                      "Información de la mascota:",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _showSpecificInformationBool(
                              "Castrado", appoiment.pet!.castrated),
                          _showSpecificInformationBool(
                              "Sociable", appoiment.pet!.sociable),
                          _showSpecificInformationBool(
                              "Vacunado", appoiment.pet!.isVaccinationUpDate),
                          _showSpecificInformationDate(
                              "Desparacitado el:", appoiment.lastDeworming),
                          _showSpecificInformationDate(
                              "Protección de plagas el:",
                              appoiment.lastProtectionFleas),
                          _showSpecificInformationText(
                              "Raza:", appoiment.pet!.kindPet!),
                          _showSpecificInformationText(
                              "Edad:", appoiment.pet!.age!.toString()),
                        ],
                      ),
                    ),
                  ),
                  _createDirectionInformation(
                      appoiment.transfer!, appoiment.direccion!),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            _showProofPaymentPhoto(
                appoiment.proofPhotoUrl, appoiment.pymentType, appoiment.priceTotal),
          ],
        ),
      ),
    );
  }



  //Detalle de las citas de estética 
  Widget getStheticAppoimentInfo(StheticAppointment appoiment) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(14),
        height: MediaQuery.of(context).size.height * 1.3,
        width: MediaQuery.of(context).size.width * 0.96,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.67,
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: FadeInImage(
                            image: NetworkImage(appoiment.client!.photoUri!),
                            placeholder: AssetImage('assets/gif/blueCat.gif'),
                            fit: BoxFit.cover,
                            height: 150.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.042,
                              child: Text(
                                appoiment.client!.userName!,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                appoiment.client!.email!,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                appoiment.client!.phone!,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.primaryColorBlue,
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _formatInfo(appoiment.entryDate!.day.toString(), 0.043,
                          Colors.white, FontWeight.bold),
                      _formatInfo(DayText.getDayText(appoiment.entryDate!.weekday),
                          0.020, Colors.grey[200], FontWeight.bold),
                      _formatInfo(DateHour.getTime(appoiment.entryHour!), 0.018,
                          Colors.grey[200], FontWeight.bold),
                    ],
                  ),
                )
              ],
            ),
            //Container(
            //  margin: EdgeInsets.only(
            //      top: MediaQuery.of(context).size.height * 0.01),
            //  child: Row(
            //    mainAxisAlignment: MainAxisAlignment.center,
            //    children: [
            //      Text("Salida",
            //        style: TextStyle(
            //            fontSize: MediaQuery.of(context).size.width * 0.06),
            //      ),
            //      SizedBox(
            //        width: MediaQuery.of(context).size.width * 0.02,
            //      ),
            //      Container(
            //        decoration: BoxDecoration(
            //          color: ColorsApp.primaryColorPink,
            //          borderRadius: new BorderRadius.circular(8.0),
            //        ),
            //        width: MediaQuery.of(context).size.width * 0.66,
            //        height: MediaQuery.of(context).size.height * 0.06,
            //        child: Row(
            //          children: [
            //            SizedBox(
            //              width: MediaQuery.of(context).size.width * 0.01,
            //            ),
            //            _formatInfo(DateHour.getTime(appoiment.departureHour!),
            //                0.022, Colors.white, FontWeight.normal),
            //            SizedBox(
            //              width: MediaQuery.of(context).size.width * 0.02,
            //            ),
            //            Container(
            //              width: MediaQuery.of(context).size.width * 0.4,
            //              child: _formatInfo(appoiment.userPickup!, 0.018,
            //                  Colors.white, FontWeight.normal),
            //            ),
            //          ],
            //        ),
            //      )
            //    ],
            //  ),
            //),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(8.0),
              ),
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01),
              width: MediaQuery.of(context).size.width * 0.89,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.01,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Text(
                      "Información de la mascota:",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _showSpecificInformationBool(
                              "Castrado", appoiment.pet!.castrated),
                          _showSpecificInformationBool(
                              "Sociable", appoiment.pet!.sociable),
                          _showSpecificInformationBool(
                              "Vacunado", appoiment.pet!.isVaccinationUpDate),
                          _showSpecificInformationText(
                              "Tipo de pelo:", appoiment.pet!.fur!),
                          _showSpecificInformationText(
                              "Raza:", appoiment.pet!.kindPet!),
                          _showSpecificInformationText(
                              "Edad:", appoiment.pet!.age!.toString()),
                          _showSpecificInformationText(
                              "Peso:", appoiment.pet!.weight!.toString() + ' kg'),
                        ],
                      ),
                    ),
                  ),
                  _createDirectionInformation(
                      appoiment.transfer!, appoiment.address!),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            _showProofPaymentPhoto(
                appoiment.proofPhotoUrl, appoiment.pymentType, appoiment.priceTotal),
          ],
        ),
      ),
    );
  }
  //Detalle de las citas del hotel 
  Widget getHotelAppoimentInfo(HotelAppointment appoiment) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.84,
        width: MediaQuery.of(context).size.width * 0.93,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
  //Detalle de las citas de la Veterinaria
  Widget getVeterinaryAppoimentInfo(VeterinaryAppointment appoiment) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.84,
        width: MediaQuery.of(context).size.width * 0.93,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }

  Widget _showProofPaymentPhoto(String photoURL, 
  String proofPayment, double totalPrice) {
    if (proofPayment == 'Efectivo') {
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                height: 40,
                width: MediaQuery.of(context).size.width * 0.89,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                child: Text('Paga en Efectivo: ' + '$totalPrice' + ' Colones',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ))),
            SizedBox(
              height: 10,
            ),
            Image(
              image: AssetImage('assets/icons/pago_efectivo.png'),
              height: 250.0,
              width: 350,
              fit: BoxFit.cover,
            )
          ],
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                height: 40,
                width: MediaQuery.of(context).size.width * 0.89,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                child: Text('Comprobante SINPE Móvil',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ))),
            SizedBox(
              height: 10,
            ),
            (photoURL == "")
                ? Image(
                    image: AssetImage('assets/images/no-image.png'),
                    height: 250.0,
                    width: 350,
                    fit: BoxFit.cover,
                  )
                : Image(
                    image: NetworkImage(photoURL),
                    height: 250.0,
                    width: 350,
                    fit: BoxFit.cover,
                  ),
          ],
        ),
      );
    }
  }

  Widget _formatInfo(
      String inf, double size, Color? textColor, FontWeight fontWeight) {
    return Text(
      inf,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * size,
          fontWeight: fontWeight,
          color: textColor),
    );
  }

  Widget _showSpecificInformationBool(String atribute, bool? condition) {
    if (condition != null) {
      Icon icon;
      if (condition) {
        icon = new Icon(FontAwesomeIcons.check);
      } else {
        icon = new Icon(FontAwesomeIcons.times);
      }
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black26),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(2.0),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(atribute,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
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

  Widget _showSpecificInformationDate(String atribute, DateTime? date) {
    String formatedDate = DateFormat('dd-MM-yyyy').format(date!);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.black26),
        borderRadius: new BorderRadius.circular(8.0),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(atribute,
            style: TextStyle(
                color: Colors.black87,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Text(
            formatedDate,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _showSpecificInformationText(String atribute, String? value) {
    if (value != null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black26),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(2.0),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              atribute,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _createDirectionInformation(bool transfer, String addres) {
    if (transfer) {
      return Container(
        margin: EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey)),
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.width * 0.83,
        child: Column(
          children: [
            Text("Dirección domicilio"),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(2),
                  child: Text(
                    addres,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.035),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.04,
        child: Text(
          "* No se requiere recogida a domicilio",
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  Widget _titlePage(context) {
    return AppBar(
      leading: SafeArea(
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      centerTitle: true,
      title: SafeArea(
        child: Container(
          child: SvgPicture.asset(
            'assets/images/Logo_COLOR.svg',
            height: 45,
            width: 60,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
