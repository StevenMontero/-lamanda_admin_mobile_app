import 'package:flutter/cupertino.dart';
import 'package:lamanda_admin/src/pages/Products/list_products_page.dart';
import 'package:lamanda_admin/src/pages/home.dart';
import 'package:lamanda_admin/src/pages/login_pages/login_page.dart';

Map<String, WidgetBuilder> getRoutesApp() {
  return <String, WidgetBuilder>{
    'admin_home': (BuildContext context) => AdminHome(),
    'listProducts': (BuildContext context) => ListProducts(),
    'login': (BuildContext context) => LoginScreen(),
  };
}
