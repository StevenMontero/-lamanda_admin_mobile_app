part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {
  final listProducts = false;
}

// ignore: must_be_immutable
class ProductsListed extends ProductsState {
  final listProducts = true;
  Product product;

  ProductsListed(this.product);
}

// ignore: must_be_immutable
class ProductsModified extends ProductsState {
  final listProducts = true;
  Product product;

  ProductsModified(this.product);
}
