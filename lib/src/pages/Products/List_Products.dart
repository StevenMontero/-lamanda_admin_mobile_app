import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lamanda_admin/src/theme/colors.dart';

class List_Products extends StatelessWidget {
  const List_Products({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _titlePage(context),
      body: Container(
        child: Column(
          children: [
            _optionsBar(),
            Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                children: _products(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 40.0),
        backgroundColor: ColorsApp.primaryColorBlue,
        onPressed: () {},
      ),
    );
  }

  Widget _titlePage(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: Expanded(
        child: Container(
          color: Colors.white,
          width: AppBar().preferredSize.height + 40,
          height: AppBar().preferredSize.height,
          child: SvgPicture.asset(
            'assets/images/Logo_COLOR.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  Widget _optionsBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.tune,
              color: ColorsApp.primaryColorBlue,
            ),
            label: Text(
              "Filtros",
              style: TextStyle(
                color: ColorsApp.primaryColorBlue,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(width: 40.0),
          Text(
            "Productos",
            style: TextStyle(
              color: ColorsApp.primaryColorBlue,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardProduct() {
    int _quantity = 21;
    String _messageQuantity = _quantity.toString() + " en stock";
    String _price = "\$6000";
    String _title = "Césped Sintético\nWeeWee Patch";

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Image(
              image: NetworkImage(
                  'https://www.todomascotascr.com/84-4814-large/cesped-sintetico-weewee-patch.jpg',
                  scale: 2.5),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _title,
                  style: TextStyle(
                      color: ColorsApp.textPrimaryColor, fontSize: 15.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  _price,
                  style: TextStyle(
                    color: ColorsApp.primaryColorBlue,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  _messageQuantity,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: _colorStatus(_quantity),
                  ),
                  width: 120.0,
                  height: 5.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color _colorStatus(int quantity) {
    Color color;
    if (quantity < 10) {
      color = Colors.red;
    } else if (quantity < 20 && quantity >= 10) {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }
    return color;
  }

  List<Widget> _products() {
    List<Widget> listProducts = new List<Widget>();

    for (int i = 0; i < 15; i++) {
      listProducts.add(_cardProduct());
      listProducts.add(SizedBox(height: 10.0));
    }

    return listProducts;
  }
}
