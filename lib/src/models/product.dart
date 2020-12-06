import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String name;
  String description;
  double price;
  int quantity;
  String photoUrl;
  String code;
  String categories;

  Product({
    this.name = '',
    this.description = '',
    this.price = 0.0,
    this.quantity = 0,
    this.photoUrl,
    this.code,
    this.categories = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        photoUrl: json["photoUrl"],
        code: json["code"],
        categories: json["categories"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "quantity": quantity,
        "photoUrl": photoUrl,
        "code": code,
        "categories": categories,
      };
}
