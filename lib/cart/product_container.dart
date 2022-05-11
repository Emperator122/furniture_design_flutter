import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/cart/resources.dart';
import 'package:furniture/home/favorite/resources.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/misc/value_cubit.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/product_counter_widget.dart';
import 'package:furniture/ui/strings.dart';
import 'package:furniture/ui/text_style.dart';

class _ProductVM {
  late final ValueCubit<int> countController;
  late final List<StreamSubscription> streams;

  _ProductVM() {
    streams = <StreamSubscription>[];
    countController = ValueCubit<int>(1);

    streams.add(
      countController.stream.listen((state) {
        if (state <= 0) {
          countController.state++;
        }
      }),
    );
  }

  void close() {
    countController.close();
    for (final stream in streams) {
      stream.cancel();
    }
  }
}

class ProductContainer extends StatefulWidget {
  final Product product;
  const ProductContainer({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductContainerState();
}

class ProductContainerState extends State<ProductContainer> {
  late final _ProductVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = _ProductVM();
  }

  @override
  void dispose() {
    super.dispose();
    _vm.close();
  }

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
        widget.product.image,
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
          widget.product.name,
          color: ApplicationColors.textGray3,
          customStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: CartSizes.productCounterWidth,
          child: ProductCounter(countController: _vm.countController),
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
          onPressed: () => true,
          icon: SvgPicture.asset(FavoriteImages.remove),
        ),
        StreamBuilder<int>(
          stream: _vm.countController.stream,
          builder: (context, snapshot) {
            return MyText.h4(
              '${ApplicationStrings.currencySymbol} ${widget.product.uiPriceMultiply(_vm.countController.state)}',
              color: ApplicationColors.black,
              customStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          }
        ),
      ],
    );
  }
}
