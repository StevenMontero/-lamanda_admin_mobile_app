import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lamanda_admin/models/product.dart';

class ProductProvider {
  final String _db = '';

  Future<List<Product>> showProducts() async {
    final _getProducts = '$_db/products.json';
    final resp = await http.get(_getProducts);
    final Map<String, dynamic> data = json.decode(resp.body);
    final List<Product> products = new List();

    if (data == null) return [];

    if (data['error'] != null) return [];

    data.forEach((key, value) {
      final temp = Product.fromJson(value);
      temp.code = key;

      products.add(value);
    });

    return products;
  }

  Future<bool> addProduct(Product product) async {
    final _addProduct = '$_db/products.json';
    final resp = await http.post(_addProduct, body: productToJson(product));
    final data = json.decode(resp.body);
    print(data);
    return true;
  }

  Future<bool> modifyProduct(Product product) async {
    final _modify = '$_db/products/${product.code}.json';
    final resp = await http.put(_modify);
    final data = json.decode(resp.body);
    print(data);
    return true;
  }

  Future<bool> deleteProduct(String code) async {
    final _deleted = '$_db/products/$code.json';
    final resp = await http.delete(_deleted);
    final data = json.decode(resp.body);
    print(data);
    return true;
  }
}
