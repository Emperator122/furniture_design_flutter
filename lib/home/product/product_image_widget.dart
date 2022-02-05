import 'package:flutter/material.dart';
import 'package:furniture/home/product/resources.dart';

class ProductImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;

  const ProductImage({
    Key? key,
    required this.image,
    this.height,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(ProductSizes.imageBottomLeftBorderRadius),
      ),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        height: height,
        width: width,
      ),
    );
  }
}
