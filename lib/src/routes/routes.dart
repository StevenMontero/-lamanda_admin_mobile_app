import 'package:flutter/material.dart';
import 'package:lamanda_admin/src/pages/appointment_pages/appoiment_list_page.dart';

Map<String, WidgetBuilder> getRoutesApp() {
  return <String, WidgetBuilder>{
    
    'esthetic' : (BuildContext contect) => GroomingScreen()
  };
}
