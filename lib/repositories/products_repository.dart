import 'package:furniture/home/models/product.dart';
import 'package:furniture/misc/mock_data_manager.dart';

abstract class ProductsRepository {
  List<Product> getProducts();
}

class ProductsRepositoryMock extends ProductsRepository {
  final MockDataManager mockDataManager;

  ProductsRepositoryMock() : mockDataManager = MockDataManager();

  @override
  List<Product> getProducts() => mockDataManager.getProducts();

}
