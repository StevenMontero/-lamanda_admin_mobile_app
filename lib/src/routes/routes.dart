import 'package:flutter/cupertino.dart';
import 'package:lamanda_admin/src/pages/Products/list_products_page.dart';
import 'package:lamanda_admin/src/pages/Products/show_product.dart';
import 'package:lamanda_admin/src/pages/appointment_pages/appointment_details.dart';
import 'package:lamanda_admin/src/pages/appointment_pages/appointment_list_page.dart';
import 'package:lamanda_admin/src/pages/home.dart';
import 'package:lamanda_admin/src/pages/orders/order_list_page.dart';
import 'package:lamanda_admin/src/pages/users_management/user_list_page.dart';

Map<String, WidgetBuilder> getRoutesApp() {
  return <String, WidgetBuilder>{
    'admin_home': (BuildContext context) => AdminHome(),
    'listProducts': (BuildContext context) => ListProducts(),
    'showProduct': (BuildContext context) => ShowProduct(),
    'listAppointments': (BuildContext context) => AppointmentList(),
    'apptDetails': (BuildContext context) => ApptDetails(),
    'user_list': (BuildContext context) => UserList(),
    'user_details': (BuildContext context) => UserList(),
    'orders_list': (BuildContext context) => OrdersList(),
  };
}
