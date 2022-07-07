import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/cart/bloc.dart';
import 'package:furniture/cart/resources.dart';
import 'package:furniture/home/favorite/resources.dart';
import 'package:furniture/cart/models/cart_product.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/product_counter_widget.dart';
import 'package:furniture/ui/strings.dart';
import 'package:furniture/ui/text_style.dart';

class ProductContainer extends StatefulWidget {
  final CartProduct cartProduct;
  final CartBloc cartBloc;

  const ProductContainer({
    Key? key,
    required this.cartProduct,
    required this.cartBloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductContainerState();
}

class ProductContainerState extends State<ProductContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  CartLoadedState get loadedState => widget.cartBloc.state as CartLoadedState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: FavoriteSizes.productImageSize,
      child: Row(
        children: [
          _buildImage(),
          const SizedBox(
            width: FavoriteSizes.mainPadding,
          ),
          Expanded(
            child: _buildMiddlePart(),
          ),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(CartSizes.productImageBorderRadius),
      ),
      child: Image.asset(
        widget.cartProduct.product.image,
        fit: BoxFit.cover,
        height: CartSizes.productImageSize,
        width: CartSizes.productImageSize,
      ),
    );
  }

  Widget _buildMiddlePart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.h5(
          widget.cartProduct.product.name,
          color: ApplicationColors.textGray3,
          customStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: CartSizes.productCounterWidth,
          child: ProductCounter(
            count: widget.cartProduct.count,
            onIncrease: (int newValue) {
              if(!loadedState.sendingData) {
                widget.cartBloc.add(
                  IncreaseProductCount(product: widget.cartProduct),
                );
              }
            },
            onDecrease: (int newValue) {
              if(!loadedState.sendingData) {
                widget.cartBloc.add(
                  DecreaseProductCount(product: widget.cartProduct),
                );
              }
            }
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: 15,
          onPressed: () => widget.cartBloc.add(
            RemoveProduct(product: widget.cartProduct),
          ),
          icon: SvgPicture.asset(FavoriteImages.remove),
        ),
        MyText.h4(
          '${ApplicationStrings.currencySymbol} '
          '${widget.cartProduct.product.uiPriceMultiply(widget.cartProduct.count)}',
          color: ApplicationColors.black,
          customStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
