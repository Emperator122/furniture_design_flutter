import 'dart:math';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/misc/mock_data_manager.dart';

abstract class FavoriteRepository {
  Future<List<Product>> getProducts();
}

class FavoriteRepositoryMock extends FavoriteRepository {
  final MockDataManager mockDataManager;

  FavoriteRepositoryMock() : mockDataManager = MockDataManager();

  @override
  Future<List<Product>> getProducts() async {
    final products = mockDataManager.getProducts();

    int randomCount() {
      final rnd = Random();
      return 1+rnd.nextInt(products.length);
    }
    await mockDataManager.randomTimeout;
    return products.getRange(0, randomCount()).toList()..shuffle();
  }
}
