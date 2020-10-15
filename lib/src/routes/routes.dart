import 'package:flutter/cupertino.dart';
import 'package:lamanda_admin/src/pages/Products/List_Products.dart';
import 'package:lamanda_admin/src/pages/home.dart';

Map<String, WidgetBuilder> getRoutesApp() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomeScreen(),
    'listProducts': (BuildContext context) => List_Products(),
  };
}
