import 'dart:math';
import 'package:furniture/cart/models/cart_product.dart';
import 'package:furniture/misc/mock_data_manager.dart';

abstract class CartRepository {
  List<CartProduct> getProducts();
}

class CartRepositoryMock extends CartRepository {
  final MockDataManager mockDataManager;

  CartRepositoryMock() : mockDataManager = MockDataManager();

  @override
  List<CartProduct> getProducts() {
    final products = mockDataManager.getProducts();

    int randomCount() {
      final rnd = Random();
      return 1 + rnd.nextInt(products.length);
    }

    return products
        .getRange(0, randomCount())
        .map<CartProduct>((e) => CartProduct(product: e, count: 1))
        .toList()
      ..shuffle();
  }
}
