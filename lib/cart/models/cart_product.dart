import 'package:furniture/home/models/product.dart';

class CartProduct {
  final Product product;
  final int count;

  CartProduct({
    required this.product,
    required this.count,
  });

  CartProduct copyWith({
    Product? product,
    int? count,
  }) {
    return CartProduct(
      product: product ?? this.product,
      count: count ?? this.count,
    );
  }
}
