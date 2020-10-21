import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_admin/src/theme/colors.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _titlePage(context),
      body: _body(),
    );
  }

  Widget _titlePage(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: SafeArea(
        child: Container(
          height: 70,
          width: 70,
          child: SvgPicture.asset(
            'assets/img/Logo_COLOR.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.only(top: 80),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                _optionCard(1),
                _optionCard(3),
              ],
            ),
            Column(
              children: [
                _optionCard(2),
                _optionCard(4),
              ],
            )
          ],
        ),
    );
  }

  Widget _optionCard(int option) {
    double size = 160;
    String indicationText="";
    Icon icon;

    switch (option) {
      case 1:
        indicationText = "Gestión de productos";
        icon = new Icon(FontAwesomeIcons.solidClipboard, 
              color: Colors.white,
              size: 45,);
        break;
      case 2:
        indicationText = "Gestión de usuarios";
        icon = new Icon(FontAwesomeIcons.userEdit, 
              color: Colors.white,
              size: 45,);
        break;
      case 3:
        indicationText = "Gestión de citas";
        icon = new Icon(FontAwesomeIcons.solidCalendarCheck, 
              color: Colors.white,
              size: 45,);
        break;
      case 4:
        indicationText = "Gestión de ordenes";
        icon = new Icon(FontAwesomeIcons.fileInvoiceDollar, 
              color: Colors.white,
              size: 45,);
        break;
      default:
    }

    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        elevation: 3.0,
        color: ColorsApp.primaryColorBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            icon,
            SizedBox(height: 10.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: indicationText,
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
                 ),
            ),
          ],
        ),
      )
    );
  }
}
