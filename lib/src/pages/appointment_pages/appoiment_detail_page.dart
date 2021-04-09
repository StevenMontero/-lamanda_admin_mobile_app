import 'package:flutter/material.dart';
import 'package:lamanda_admin/models/daycare_appointment.dart';
import 'package:lamanda_admin/src/theme/colors.dart';

class AppoimentDetail extends StatefulWidget {
  @override
  _AppoimentDetailState createState() => _AppoimentDetailState();
}

class _AppoimentDetailState extends State<AppoimentDetail> {

  Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    final appoiment = ModalRoute.of(context)!.settings.arguments;
    if(appoiment is DaycareAppointment){
      backgroundColor = ColorsApp.primaryColorPinkDegraded;
    }
    return Scaffold(
      body: Center(
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
            children: <Widget>[
              
            ],
          ),
          
        ),
      ),

    );
  }
}

