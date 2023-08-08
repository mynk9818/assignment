import 'dart:convert';

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));

String cartItemsToJson(CartItems data) => json.encode(data.toJson());

class CartItems {
  int id;
  List<Product> products;
  int total;
  int discountedTotal;
  int userId;
  int totalProducts;
  int totalQuantity;

  CartItems({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
        id: json['id'],
        products: List<Product>.from(
          json['products'].map((x) => Product.fromJson(x)),
        ),
        total: json['total'],
        discountedTotal: json['discountedTotal'],
        userId: json['userId'],
        totalProducts: json['totalProducts'],
        totalQuantity: json['totalQuantity'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'products': List<dynamic>.from(products.map((x) => x.toJson())),
        'total': total,
        'discountedTotal': discountedTotal,
        'userId': userId,
        'totalProducts': totalProducts,
        'totalQuantity': totalQuantity,
      };
}

class Product {
  int id;
  String title;
  int price;
  int quantity;
  int total;
  double discountPercentage;
  int discountedPrice;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        quantity: json['quantity'],
        total: json['total'],
        discountPercentage: json['discountPercentage']?.toDouble(),
        discountedPrice: json['discountedPrice'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'quantity': quantity,
        'total': total,
        'discountPercentage': discountPercentage,
        'discountedPrice': discountedPrice,
      };
}
