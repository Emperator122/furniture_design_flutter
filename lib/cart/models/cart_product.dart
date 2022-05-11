import 'package:furniture/home/models/product.dart';

class CartProduct {
  final Product product;
  final int count;

  CartProduct({
    required this.product,
    required this.count,
  });
}
