
class Product {
  final String name;
  final double price;
  final String image;
  final double rating;
  final int reviewsCount;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.reviewsCount,
    required this.description,
  });

  String get uiPrice => price.toStringAsFixed(2);

  String uiPriceMultiply(int count) => (count*price).toStringAsFixed(2);
}

extension ProductsExt on List<Product> {
  String get uiPrice =>
      fold<double>(0, (previousValue, element) => previousValue + element.price)
          .toStringAsFixed(2);
}
