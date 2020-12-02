import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamanda_admin/src/blocs/productCubit/products_cubit.dart';
import 'package:lamanda_admin/src/models/models.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/widgets/appBar.dart';
import '../../theme/colors.dart';

class ListProducts extends StatelessWidget {
  final products = new ProductsCubit();

  @override
  Widget build(BuildContext context) {
    products.getProducts();

    return Scaffold(
      appBar: titlePage(context),
      body: BlocBuilder<ProductsCubit, ProductsState>(builder: (_, state) {
        if (state is ProductsInitial) {
          return Center(
            child: Text(
              'Presione el boton \'+\' para agregar un producto',
              style: TextStyle(color: ColorsApp.textPrimaryColor),
            ),
          );
        } else {
          return _body(context);
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 40.0),
        backgroundColor: ColorsApp.primaryColorBlue,
        onPressed: () => Navigator.pushNamed(context, 'showProduct'),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _optionsBar(context),
          Divider(),
          Expanded(
            child: _showProducts(),
          ),
        ],
      ),
    );
  }

  Widget _optionsBar(BuildContext context) {
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

  Widget _showProducts() {
    return StreamBuilder(
      stream: products.getProductsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {
          final _product = snapshot.data ?? [];

          if (_product == []) {
            Center(
              child: Text(
                'Presione el boton \'+\' para agregar un producto',
                style: TextStyle(color: ColorsApp.textPrimaryColor),
              ),
            );
          }

          return ListView.builder(
            itemCount: _product.length,
            itemBuilder: (context, i) => _cardProduct(context, _product[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    double _quantity = double.parse('${product.quantity}');
    String _messageQuantity = '${product.quantity}' + " en stock";
    String _price = "\$" + '${product.price}';
    String _title = '${product.name}';
    String _image = '${product.photoUrl}';

    final productCard = Card(
      margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: (product.photoUrl == null)
                ? Image(
                    image: AssetImage('assets/img/no-image.png'),
                    height: 100,
                    width: 100,
                  )
                : Image(
                    image: NetworkImage(_image),
                    height: 100,
                    width: 100,
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

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        child: Icon(Icons.delete, size: 20.0),
        alignment: Alignment.centerLeft,
        color: Colors.red,
      ),
      onDismissed: (direction) {
        direction = DismissDirection.startToEnd;
        products.deleteProduct(product);
      },
      child: GestureDetector(
        child: productCard,
        onTap: () =>
            Navigator.pushNamed(context, 'showProduct', arguments: product),
      ),
    );
  }

  Color _colorStatus(double quantity) {
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
}
