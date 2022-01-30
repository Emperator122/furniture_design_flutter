import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/home/resources.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/text_style.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  final void Function() onTap;

  const ProductGridItem({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(HomeSizes.productImageBorderRadius),
              ),
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                height: HomeSizes.productImageHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: HomeSizes.productItemIconMargin,
                right: HomeSizes.productItemIconMargin,
              ),
              child: SvgPicture.asset(HomeIcons.shopping),
            ),
          ],
        ),
        MyText.h5(
          product.name,
          color: ApplicationColors.textGray3,
          customStyle: const TextStyle(fontWeight: FontWeight.w400),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        MyText.h5(
          '${HomeStrings.currencySymbol} ${product.price}',
          color: ApplicationColors.black,
          customStyle: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

extension ProductGridItemExt on ProductGridItem {
  static List<Product> mock() {
    double randomPrice() {
      final rnd = Random();
      return rnd.nextInt(100) * 1.0;
    }

    const path = 'assets/mock/products_images';
    return <Product>[
      Product(
        name: 'Couch with humans',
        price: randomPrice(),
        image: '$path/couch_1.jpg',
        description: 'Good couch. I like it.',
        reviewsCount: 25,
        rating: 4.5,
      ),
      Product(
        name: 'Regular soft сouch',
        price: randomPrice(),
        image: '$path/couch_2.jpg',
        description: 'Just good soft couch. Nothing more.',
        reviewsCount: 6,
        rating: 5,
      ),
      Product(
        name: 'Old chair',
        price: randomPrice(),
        image: '$path/chair_1.jpg',
        description: 'My grandmother\'s chair',
        reviewsCount: 1,
        rating: 3.5,
      ),
      Product(
        name: 'Omega kit with omega description',
        price: randomPrice(),
        image: '$path/kit_1.jpg',
        description: 'Minimal Stand is made of by natural wood. '
            'The design that is very simple and minimal. This is truly '
            'one of the best furnitures in any family for now. With 3 '
            'different colors, you can easily select the best match for your '
            'home. ',
        reviewsCount: 15,
        rating: 4.5,
      ),
      Product(
        name: 'Blue lamp',
        price: randomPrice(),
        image: '$path/lamp_1.jpg',
        description: 'Blue lamp',
        reviewsCount: 10,
        rating: 4.5,
      ),
      Product(
        name: 'Red lamp',
        price: randomPrice(),
        image: '$path/lamp_2.jpg',
        description: 'Red lamp',
        reviewsCount: 9,
        rating: 1.5,
      ),
    ];
  }
}
