import 'package:flutter/foundation.dart';

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
}
