import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/home/favorite/resources.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/strings.dart';
import 'package:furniture/ui/text_style.dart';

class FavoriteProductContainer extends StatelessWidget {
  final Product product;
  final void Function(Product product)? onRemove;

  const FavoriteProductContainer({
    Key? key,
    required this.product,
    this.onRemove
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: FavoriteSizes.productImageSize,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(
            width: FavoriteSizes.mainPadding,
          ),
          Expanded(
            child: _buildTitleAndPrice(),
          ),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(FavoriteSizes.productImageBorderRadius),
      ),
      child: Image.asset(
        product.image,
        fit: BoxFit.cover,
        height: FavoriteSizes.productImageSize,
        width: FavoriteSizes.productImageSize,
      ),
    );
  }

  Widget _buildTitleAndPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.h5(
          product.name,
          color: ApplicationColors.textGray3,
          customStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        MyText.h4(
          '${ApplicationStrings.currencySymbol} ${product.price}',
          color: ApplicationColors.black,
          customStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkResponse(
          onTap: () => onRemove?.call(product),
          child: SvgPicture.asset(FavoriteImages.remove),
        ),
        InkResponse(
          onTap: () => true,
          child: SvgPicture.asset(FavoriteImages.addToCart),
        ),
      ],
    );
  }
}
