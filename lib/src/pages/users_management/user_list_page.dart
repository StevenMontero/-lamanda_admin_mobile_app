import 'package:flutter/material.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/widgets/appBar.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Size _screenSize;
  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    double titleSize = _screenSize.width * 0.045;

    return Scaffold(
      appBar: titlePage(context),
      body: Column(
        children: [
          SizedBox(height: 2),
          Text("Administración de Usuarios",
              style: TextStyle(
                  color: ColorsApp.primaryColorBlue,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w900)),
          Divider(
            height: 5,
            thickness: 2,
          ),
          Container(
            child: Text(
              "En proceso...",
              style: TextStyle(fontSize: _screenSize.width * 0.1),
            ),
          ),
          Container(
            width: _screenSize.width * 0.4,
            child: Image.asset('assets/gif/in_process.gif'),
          )
          //INSERTAR DESPUÉS FILTRO DE USUARIOS ADMINS Y USUARIOS CLIENTES
          //_cardAdminUser(context, new AdminUser())
        ],
      ),
    );
  }
/*
  Widget _cardAdminUser(BuildContext context, AdminUser user) {
    final productCard = Card(
      margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: (user.photoUri == null)
                ? Image(
                    image: AssetImage('assets/img/no-image.png'),
                    height: 100,
                    width: 100,
                  )
                : Image(
                    image: NetworkImage("_image"),
                    height: 100,
                    width: 100,
                  ),
          ),
        ],
      ),
    );

    return GestureDetector(
      child: productCard,
      onTap: () =>
          Navigator.pushNamed(context, 'showProduct', arguments: user),
    );
  }*/
}
