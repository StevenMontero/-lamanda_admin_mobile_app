import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lamanda_admin/src/models/models.dart';
import 'package:mime_type/mime_type.dart';

class ProductProvider {
  //TODO: falta agregar conexion a db
  final String _db = '';
  /* List<Category> categories = [
    Category.fromJson(1, 'Perros'),
    Category.fromJson(2, 'Gatos'),
    Category.fromJson(3, 'Aves'),
  ]; */

  Future<List<Product>> showProducts() async {
    final _getProducts = '$_db/products.json';
    // final resp = await http.get(_getProducts);
    // final Map<String, dynamic> data = json.decode(resp.body);
    final List<Product> products = new List();

    // if (data == null) return [];

    // if (data['error'] != null) return [];

    // data.forEach((key, value) {
    //   final temp = Product.fromJson(value);
    //   temp.code = key;

    //   products.add(value);
    // });

    return products;
  }

  Future<bool> addProduct(Product product) async {
    // final _addProduct = '$_db/products.json';
    // final resp = await http.post(_addProduct, body: productToJson(product));
    // final data = json.decode(resp.body);
    // print(data);
    return true;
  }

  Future<String> loadPhoto(File photo) async {
    //TODO: Agregar endpoint donde se guardara la imagen
    /*final url = Uri.parse('');
    final mimeType = mime(photo.path).split('/');

    final imageUpload = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', photo.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUpload.files.add(file);

    final streamResponse = await imageUpload.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Error to load source');
      return null;
    }

    final urlSecure = json.decode(resp.body);
    return urlSecure['secure_url'];
    */
  }

  Future<bool> modifyProduct(Product product) async {
    // final _modify = '$_db/products/${product.code}.json';
    // final resp = await http.put(_modify);
    // final data = json.decode(resp.body);
    // print(data);
    return true;
  }

  Future<bool> deleteProduct(String code) async {
    // final _deleted = '$_db/products/$code.json';
    // final resp = await http.delete(_deleted);
    // final data = json.decode(resp.body);
    // print(data);
    return true;
  }
}
