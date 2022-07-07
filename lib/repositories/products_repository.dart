import 'package:furniture/home/models/product.dart';
import 'package:furniture/misc/mock_data_manager.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProducts();
}

class ProductsRepositoryMock extends ProductsRepository {
  final MockDataManager mockDataManager;

  ProductsRepositoryMock() : mockDataManager = MockDataManager();

  @override
  Future<List<Product>> getProducts() async  {
    await mockDataManager.randomTimeout;
    return mockDataManager.getProducts();
  }

}
