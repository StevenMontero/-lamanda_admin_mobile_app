import 'package:flutter/cupertino.dart';
import 'package:lamanda_admin/src/blocs/productBloc/product_bloc.dart';
export 'package:lamanda_admin/src/blocs/productBloc/product_bloc.dart';

class Provider extends InheritedWidget {
  final _productBloc = ProductBloc();

  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static ProductBloc productBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType() as Provider)
        ._productBloc;
  }
}
