import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_admin/src/models/models.dart';

class ProductService {
  final products = FirebaseFirestore.instance.collection('products');
  Stream collectionStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  Future<void> addProduct(Product product) async {
    products
        .add(product.toJson())
        .then((value) => print('added product'))
        .catchError((e) {
      print(e);
    });
  }

  Future<void> modifyProduct(Product product) async {
    products
        .doc(product.code)
        .update(product.toJson())
        .then((value) => print('updated product'))
        .catchError((e) {
      print(e);
    });
  }

  Future<void> deleteProduct(String code) async {
    products
        .doc(code)
        .delete()
        .then((value) => print('deleted product'))
        .catchError((e) {
      print(e);
    });
  }

  Future<List<Product>> getProducts() async {
    final List<Product> listProducts = new List();
    dynamic temp = Product();
    final snap = products.snapshots();
    snap.forEach((value) {
      value.docs.forEach((p) {
        temp = Product.fromJson(p.data());
        temp.code = p.id;
      });

      listProducts.add(temp);
    });
    return listProducts;
  }

  Future<Product> getProduct(String code) async {
    dynamic temp = Product();
    final snap = products.doc(code).snapshots();
    snap.forEach((p) {
      temp = Product.fromJson(p.data());
      temp.code = p.id;
    });
    return temp;
  }
}
