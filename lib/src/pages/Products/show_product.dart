import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamanda_admin/src/blocs/productBloc/product_bloc.dart';
import 'package:lamanda_admin/src/models/models.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/utils/utils.dart' as utils;
import 'package:lamanda_admin/src/widgets/appBar.dart';

class ShowProduct extends StatefulWidget {
  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final products = new ProductBloc();
  final picker = ImagePicker();
  Product product = new Product();

  File _photo;

  @override
  Widget build(BuildContext context) {
    Product productData = ModalRoute.of(context).settings.arguments;
    if (productData != null) {
      product = productData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: titlePage(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _viewPhoto(),
                _nameProduct(),
                _descriptionProduct(),
                _priceProduct(),
                _quantityProduct(),
                SizedBox(height: 20.0),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsApp.primaryColorBlue,
        child: Icon(Icons.add_a_photo),
        onPressed: () => _selectImage(context),
      ),
    );
  }

  Widget _nameProduct() {
    return TextFormField(
      initialValue: product.name,
      decoration: InputDecoration(labelText: 'Nombre del producto'),
      onSaved: (value) => product.name = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _descriptionProduct() {
    return TextFormField(
      initialValue: product.description,
      decoration: InputDecoration(labelText: 'Descripción del producto'),
      onSaved: (value) => product.description = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese la descripción del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _priceProduct() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio del producto'),
      onSaved: (value) => product.price = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo valores númericos';
        }
      },
    );
  }

  Widget _quantityProduct() {
    return TextFormField(
      initialValue: product.quantity.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Cantidad del producto'),
      onSaved: (value) => product.quantity = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo valores númericos';
        }
      },
    );
  }

  Widget _submitButton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.all(15.0),
      color: ColorsApp.primaryColorBlue,
      textColor: Colors.white,
      onPressed: () => _saveProduct(context),
      icon: Icon(Icons.save),
      label: Text('Guardar'),
    );
  }

  Future<void> _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seleccione el medio"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () => _selectPhoto(ImageSource.gallery),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camara"),
                    onTap: () => _selectPhoto(ImageSource.camera),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Web"),
                    onTap: () => _selectPhotoFromWeb(context),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _viewPhoto() {
    if (product.photoUrl != null) {
      return Image(
        image: NetworkImage(product.photoUrl),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage(_photo?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  Future<void> _selectPhotoFromWeb(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ingrese la dirección de la imagen"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Aceptar'),
              ),
            ],
            content: SingleChildScrollView(
              child: TextFormField(
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                    labelText: 'Ejemplo: http://www.web.com/image.png'),
                onChanged: (value) {
                  setState(() {
                    product.photoUrl = value.trim();
                  });
                },
              ),
            ),
          );
        });
  }

  _selectPhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 70);

    setState(() {
      if (pickedFile != null) {
        product.photoUrl = null;
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _saveProduct(BuildContext context) async {
    //TODO: falta guardar foto a db
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {});

    if (_photo != null) {
      product.photoUrl = await products.loadPhoto(_photo);
    }

    if (product.code == null) {
      products.addProduct(product);
    } else {
      products.changeProduct(product);
    }

    setState(() {});

    _messageSnack('Producto Guardado');
    Navigator.pop(context);
  }

  Widget _messageSnack(String message) {
    final snack = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    return snack;
  }
}
