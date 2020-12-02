import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lamanda_admin/providers/product_service.dart';
import 'package:lamanda_admin/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final products = new ProductService();
  final _productsController = new BehaviorSubject<List<Product>>();
  get getProductsStream => _productsController.stream;

  void createProduct(Product product) {
    final currentState = state;
    if (currentState is ProductsModified) {
      currentState.product = product;
      products.addProduct(product);
      emit(new ProductsModified(product));
    }
  }

  void modifyProduct(Product product) {
    final currentState = state;
    if (currentState is ProductsModified) {
      currentState.product = product;
      products.modifyProduct(product);
      emit(new ProductsModified(product));
    }
  }

  void deleteProduct(Product product) {
    final currentState = state;
    if (currentState is ProductsModified) {
      currentState.product = product;
      products.deleteProduct(product.code);
      emit(new ProductsModified(product));
    }
  }

  Future<List<Product>> getProducts() async {
    final list = await products.getProducts();
    _productsController.sink.add(list);
    return list;
  }

  Future<Product> getProduct(String code) {
    return products.getProduct(code);
  }

  //TODO: Agregar endpoint donde se guardara la imagen
  Future<String> loadPhoto(File photo) async {}

  List<Categories> getCategories() {
    return Categories.values;
  }

  dispose() {
    _productsController?.close();
  }
}
