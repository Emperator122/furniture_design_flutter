import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/home/resources.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/strings.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
            '${ApplicationStrings.currencySymbol} ${product.uiPrice}',
            color: ApplicationColors.black,
            customStyle: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
