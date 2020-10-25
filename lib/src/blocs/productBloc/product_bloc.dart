import 'dart:async';
import 'dart:io';

import 'package:lamanda_admin/providers/product_provider.dart';
import 'package:lamanda_admin/src/models/product.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc {
  final _provider = new ProductProvider();

  final _productsController = new BehaviorSubject<List<Product>>();
  final _loadingController = new BehaviorSubject<bool>();

  get getProductsStream => _productsController.stream;
  get loadProductsStream => _loadingController.stream;

  getProducts() async {
    final products = await _provider.showProducts();
    _productsController.sink.add(products);
  }

  addProduct(Product product) async {
    _loadingController.sink.add(true);
    await _provider.addProduct(product);
    _loadingController.sink.add(false);
  }

  Future<String> loadPhoto(File photo) async {
    _loadingController.sink.add(true);
    final photoUrl = await _provider.loadPhoto(photo);
    _loadingController.sink.add(false);

    return photoUrl;
  }

  changeProduct(Product product) async {
    _loadingController.sink.add(true);
    await _provider.modifyProduct(product);
    _loadingController.sink.add(false);
  }

  deleteProduct(String code) async {
    _loadingController.sink.add(true);
    await _provider.deleteProduct(code);
    _loadingController.sink.add(false);
  }

  dispose() {
    _productsController?.close();
    _loadingController?.close();
  }
}
