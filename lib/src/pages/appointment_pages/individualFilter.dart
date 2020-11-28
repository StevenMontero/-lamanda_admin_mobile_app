import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_admin/src/theme/colors.dart';

class IndividualFilter extends StatefulWidget {
  int type;
  IndividualFilter(int type) {
    this.type = type;
  }

  @override
  _State createState() => _State(type);
}

class _State extends State<IndividualFilter> {
  int type;

  String name;
  Color color;
  Color textColor;

  double heightCard;
  double widthCard;
  double textSize;
  Icon icon;

  bool pressed = false;

  _State(int type) {
    this.type = type;
    _cases();
    pressed = true;
  }

  void _cases() {
    if (pressed) {
      color = Colors.white;
    } else {
      textColor = ColorsApp.textColorWhite;
      icon = Icon(
        FontAwesomeIcons.checkCircle,
        color: Colors.white,
        size: 20.0,
      );
    }
    switch (type) {
      case 1:
        name = "Estét.";
        if (pressed) {
          textColor = ColorsApp.primaryColorBlue;
          icon = Icon(
            FontAwesomeIcons.circle,
            color: ColorsApp.primaryColorBlue,
            size: 20.0,
          );
        } else {
          color = ColorsApp.primaryColorBlue;
        }
        break;
      case 2:
        name = "Veter.";
        if (pressed) {
          textColor = ColorsApp.primaryColorTurquoise;
          icon = Icon(
            FontAwesomeIcons.circle,
            color: ColorsApp.primaryColorTurquoise,
            size: 20.0,
          );
        } else {
          color = ColorsApp.primaryColorTurquoise;
        }
        break;
      case 3:
        name = "Guard.";
        if (pressed) {
          textColor = ColorsApp.primaryColorPink;
          icon = Icon(
            FontAwesomeIcons.circle,
            color: ColorsApp.primaryColorPink,
            size: 20.0,
          );
        } else {
          color = ColorsApp.primaryColorPink;
        }
        break;
      case 4:
        name = "Hotel";
        if (pressed) {
          textColor = ColorsApp.primaryColorOrange;
          icon = Icon(
            FontAwesomeIcons.circle,
            color: ColorsApp.primaryColorOrange,
            size: 20.0,
          );
        } else {
          color = ColorsApp.primaryColorOrange;
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    widthCard = _screenSize.width * 0.23;
    textSize = widthCard * 0.14;
    heightCard = _screenSize.height * 0.055;

    return GestureDetector(
      onTap: () {
        filterPressed();
      },
      child: Container(
        height: heightCard,
        width: widthCard,
        child: Card(
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                name,
                style: TextStyle(color: textColor, fontSize: textSize),
              ),
              SizedBox(width: 5.0),
              icon,
              SizedBox(width: 5.0),
            ],
          ),
        ),
      ),
    );
  }

  void filterPressed() {
    setState(() {
      _cases();
      if (pressed) {
        pressed = false;
      } else {
        _cases();
        pressed = true;
      }
    });
  }
}
