import 'package:flutter/cupertino.dart';
import 'package:lamanda_admin/src/pages/Products/list_products_page.dart';
import 'package:lamanda_admin/src/pages/Products/show_product.dart';
import 'package:lamanda_admin/src/pages/home.dart';

Map<String, WidgetBuilder> getRoutesApp() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomeScreen(),
    'listProducts': (BuildContext context) => ListProducts(),
    'showProduct': (BuildContext context) => ShowProduct(),
  };
}
