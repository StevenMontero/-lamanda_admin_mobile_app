import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamanda_admin/models/product.dart';
import 'package:lamanda_admin/providers/provider.dart';
import 'package:lamanda_admin/src/blocs/productBloc/product_bloc.dart';
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

  ProductBloc productsBloc;
  Product product = new Product();
  bool _saving = false;
  File photo;

  @override
  Widget build(BuildContext context) {
    productsBloc = Provider.productBloc(context);

    Product productData = ModalRoute.of(context).settings.arguments;
    if (productData != null) {
      product = productData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: titlePage(context),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _viewPhoto(),
                _selectImageButton(),
                _nameProduct(),
                _descriptionProduct(),
                _priceProduct(),
                _quantityProduct(),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameProduct() {
    return TextFormField(
      initialValue: product.name,
      decoration: InputDecoration(labelText: 'Nombre del producto'),
      onSaved: (value) => product.name = value,
      validator: (value) {
        if (value.length < 1) {
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

  Widget _submitButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: ColorsApp.primaryColorBlue,
      textColor: Colors.white,
      onPressed: (_saving) ? null : _saveProduct(context),
      icon: Icon(Icons.save),
      label: Text('Guardar'),
    );
  }

  Widget _selectImageButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: ColorsApp.primaryColorBlue,
      textColor: Colors.white,
      onPressed: _selectPhotoFromGalery(),
      icon: Icon(Icons.add_a_photo),
      label: Text('Seleccionar Foto'),
    );
  }

  Widget _viewPhoto() {
    if (product.photoUrl != null) {
      return Container();
    } else {
      if (photo != null) {
        return Image.file(
          photo,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _selectPhotoFromGalery() async {
    final imagePicker = new ImagePicker();
    final picked = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    photo = File(picked.path);

    if (photo != null) {}

    setState(() {});
  }

  _saveProduct(BuildContext context) {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _saving = true;
    });

    if (product.code == null) {
      productsBloc.addProduct(product);
    } else {
      productsBloc.modifyProduct(product);
    }

    setState(() {
      _saving = false;
    });
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
