import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamanda_admin/src/blocs/productCubit/products_cubit.dart';
import 'package:lamanda_admin/src/models/models.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/utils/utils.dart' as utils;
import 'package:lamanda_admin/src/widgets/appBar.dart';

class ShowProduct extends StatefulWidget {
  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  Product product = new Product();
  var productCubit;
  File _photo;

  @override
  Widget build(BuildContext context) {
    productCubit = context.bloc<ProductsCubit>();
    Product productData = ModalRoute.of(context).settings.arguments;
    if (productData != null) {
      product = productData;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: titlePage(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _viewPhoto(),
                SizedBox(height: 20.0),
                _nameProduct(),
                SizedBox(height: 20.0),
                _descriptionProduct(),
                SizedBox(height: 20.0),
                _priceProduct(),
                SizedBox(height: 20.0),
                _quantityProduct(),
                SizedBox(height: 20.0),
                _categoryProduct(),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _deleteButton(context),
                    SizedBox(width: 20.0),
                    _submitButton(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsApp.primaryColorBlue,
        child: Icon(Icons.add_a_photo, color: Colors.white),
        onPressed: () => _selectImage(context),
      ),
    );
  }

  Widget _nameProduct() {
    return TextFormField(
      initialValue: product.name,
      decoration: InputDecoration(
        labelText: 'Nombre del producto',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (value) {
        if (value.length < 3 && value == null) {
          return 'Ingrese el nombre del producto';
        } else {
          product.name = value;
          return null;
        }
      },
    );
  }

  Widget _descriptionProduct() {
    return TextFormField(
      initialValue: product.description,
      decoration: InputDecoration(
        labelText: 'Descripción del producto',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (value) {
        if (value.length < 1 && value == null) {
          return 'Ingrese la descripción del producto';
        } else {
          product.description = value;
          return null;
        }
      },
    );
  }

  Widget _priceProduct() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio del producto',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (value) {
        if (utils.isNumeric(value)) {
          product.price = double.parse(value);
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
      decoration: InputDecoration(
        labelText: 'Cantidad del producto',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (value) {
        if (utils.isNumeric(value)) {
          product.quantity = int.parse(value);
          return null;
        } else {
          return 'Solo valores númericos';
        }
      },
    );
  }

  Widget _categoryProduct() {
    List<Categories> categories = productCubit.getCategories();
    List<DropdownMenuItem<String>> options = new List();
    categories.forEach((c) {
      options.add(new DropdownMenuItem(
        value: c.toString().substring(c.toString().indexOf('.') + 1),
        child: new Text(c.toString().substring(c.toString().indexOf('.') + 1)),
      ));
    });

    String _selected;
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(20.0),
          ),
        ),
      ),
      hint: Text("Selecciona una categoria"),
      value: _selected,
      items: options,
      onChanged: (String value) {
        setState(() {
          product.categories = value;
          _selected = value;
        });
      },
    );
  }

  Widget _deleteButton(BuildContext context) {
    if (product.code != null) {
      return RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(15.0),
        color: ColorsApp.primaryColorOrange,
        textColor: Colors.white,
        onPressed: () {
          productCubit.deleteProduct(product);
          ScaffoldMessengerState()
              .showSnackBar(_messageSnack('Producto eliminado'));
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, 'listProducts');
        },
        icon: Icon(Icons.delete_forever),
        label: Text('Eliminar'),
      );
    }
    return Container();
  }

  Widget _submitButton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.all(15.0),
      color: ColorsApp.primaryColorBlue,
      textColor: Colors.white,
      onPressed: () {
        _saveProduct(context);
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, 'listProducts');
      },
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
                onSaved: (value) => product.photoUrl = value.trim(),
              ),
            ),
          );
        });
  }

  _selectPhoto(ImageSource source) async {
    //TODO: Genera problemas el Image Picker (No implementation found for method pickImage on channel plugins.flutter.io/image_picker)
    final pickedFile = await picker.getImage(source: source);

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
    if (!_formKey.currentState.validate()) {
      return ScaffoldMessengerState()
          .showSnackBar(_messageSnack('Verifique la información del producto'));
    }
    if (_photo != null) {
      product.photoUrl = await productCubit.loadPhoto(_photo);
    }

    if (product.code == null) {
      productCubit.createProduct(product);
      ScaffoldMessengerState()
          .showSnackBar(_messageSnack('Producto creado exitosamente'));
    } else {
      productCubit.modifyProduct(product);
      ScaffoldMessengerState().showSnackBar(
          SnackBar(content: Text('Producto modificado exitosamente')));
    }
  }

  Widget _messageSnack(String message) {
    return SnackBar(
      content: Text(message),
    );
  }
}
