import 'package:flutter/material.dart';
import 'package:lamanda_admin/src/pages/appointment_pages/appoiment_daycare_list_page.dart';
import 'package:lamanda_admin/src/pages/appointment_pages/appoiment_detail_page.dart';
import 'package:lamanda_admin/src/pages/appointment_pages/appoiment_esthetic_list_page.dart';
import 'package:lamanda_admin/src/pages/appointment_pages/appoiment_hotel_list_page.dart';
import 'package:lamanda_admin/src/pages/appointment_pages/appoiment_veterinary_list_page.dart';

Map<String, WidgetBuilder> getRoutesApp() {
  return <String, WidgetBuilder>{
    
    'esthetic' : (BuildContext contect) => GroomingScreen(),
    'daycare' : (BuildContext contect) => DayCareScreen(),
    'hotel' : (BuildContext contect) => HotelScreen(),
    'veterinary': (BuildContext contect) => VeterinaryScreen(),
    'detail' : (BuildContext contect) => AppoimentDetail(),
  };
}
