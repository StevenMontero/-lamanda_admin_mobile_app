import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:lamanda_admin/models/product.dart';
import 'package:lamanda_admin/providers/product_provider.dart';

class ProductBloc {
  final _productProvider = new ProductProvider();

  final _productsController = new BehaviorSubject<List<Product>>();
  final _loadingController = new BehaviorSubject<bool>();

  Stream<List<Product>> get productStream => _productsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  dispose() {
    _productsController?.close();
    _loadingController?.close();
  }

  showProducts() async {
    final products = await _productProvider.showProducts();
    _productsController.sink.add(products);
  }

  addProduct(Product product) async {
    _loadingController.sink.add(true);
    await _productProvider.addProduct(product);
    _loadingController.sink.add(false);
  }

  modifyProduct(Product product) async {
    _loadingController.sink.add(true);
    await _productProvider.modifyProduct(product);
    _loadingController.sink.add(false);
  }

  deleteProduct(String code) async {
    _loadingController.sink.add(true);
    await _productProvider.deleteProduct(code);
    _loadingController.sink.add(false);
  }
}
