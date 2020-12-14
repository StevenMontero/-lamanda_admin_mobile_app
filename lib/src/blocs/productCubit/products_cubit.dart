import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lamanda_admin/repository/product_repository.dart';
import 'package:lamanda_admin/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final products = new ProductService();
  final _productsController = new BehaviorSubject<List<Product>>();
  get getProductsStream => _productsController.stream;

  void createProduct(Product product) {
    products.addProduct(product);
    emit(new ProductsModified(product));
  }

  void modifyProduct(Product product) {
    products.modifyProduct(product);
    emit(new ProductsModified(product));
  }

  void deleteProduct(Product product) {
    products.deleteProduct(product.code);
    emit(new ProductsModified(product));
  }

  Future<List<Product>> getProducts() async {
    List<Product> list = await products.getProducts();
    if (list.isEmpty != true) {
      emit(new ProductsListed(new Product()));
    }
    _productsController.sink.add(list);
    return list;
  }

  Future<Product> getProduct(String code) {
    return products.getProduct(code);
  }

  //TODO: Agregar endpoint donde se guardara la imagen
  Future<String> loadPhoto(File photo) async {
    return "";
  }

  List<Categories> getCategories() {
    return Categories.values;
  }

  dispose() {
    _productsController?.close();
  }
}
