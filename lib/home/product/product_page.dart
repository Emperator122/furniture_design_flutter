import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/home/product/back_button.dart';
import 'package:furniture/home/product/product_image_widget.dart';
import 'package:furniture/home/product/resources.dart';
import 'package:furniture/home/resources.dart';
import 'package:furniture/misc/value_cubit.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/product_counter_widget.dart';
import 'package:furniture/ui/text_style.dart';

class ProductVM {
  late final ValueCubit<int> valueController;
  late final List<StreamSubscription> streams;

  ProductVM() {
    streams = <StreamSubscription>[];

    valueController = ValueCubit<int>(1);

    streams.add(
      valueController.stream.listen((state) {
        if (state <= 0) {
          valueController.state++;
        }
      }),
    );
  }

  void close() {
    valueController.close();
    for (final stream in streams) {
      stream.cancel();
    }
  }
}

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductPageState();
  }
}

class ProductPageState extends State<ProductPage> {
  late final ProductVM _vm;

  @override
  void initState() {
    _vm = ProductVM();
    super.initState();
  }

  @override
  void dispose() {
    _vm.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * ProductSizes.imageLeftPaddingMultiplier),
                child: ProductImage(
                  image: widget.product.image,
                  height: size.height * ProductSizes.imageHeightMultiplier,
                ),
              ),
              const SizedBox(
                height: ProductSizes.imageBottomMargin,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ProductSizes.productInformationPadding,
                  ),
                  child: _buildProductInformation(),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * ProductSizes.imageLeftPaddingMultiplier -
                    ProductSizes.backButtonSize / 2,
                top: ProductSizes.backButtonTopMargin,
              ),
              child: ProductBackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.h2(
          widget.product.name,
          fontFamily: MyTextFontFamily.gelasio,
          customStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: ProductSizes.defaultMargin,
        ),
        _buildCostAndCountRow(),
        const SizedBox(
          height: ProductSizes.defaultMargin,
        ),
        _buildRatingRow(),
        Expanded(
          child: MyText.h5(
            widget.product.description,
            color: ApplicationColors.textGray3,
            textAlign: TextAlign.justify,
            customStyle: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(
          height: ProductSizes.defaultMargin,
        ),
        _buildButtons(),
        const SizedBox(
          height: ProductSizes.buttonsBottomMargin,
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return SafeArea(
      top: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: SvgPicture.asset(
              ProductIcons.addToFavourite,
            ),
            style: ElevatedButton.styleFrom(
              primary: ApplicationColors.textGray4,
              fixedSize: const Size(
                ProductSizes.buttonsHeight,
                ProductSizes.buttonsHeight,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  ProductSizes.favouriteButtonBorderRadius,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: ProductSizes.buttonsRightMargin,
          ),
          Expanded(
            child: SizedBox(
              height: ProductSizes.buttonsHeight,
              child: ElevatedButton(
                onPressed: () {},
                child: MyText.custom(
                  ProductStrings.addToCartButtonText,
                  fontSize: ProductSizes.addToFavouriteTextSize,
                  customStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostAndCountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText.h1(
          '${HomeStrings.currencySymbol} ${widget.product.price}',
          customStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: ProductSizes.productCounterWidth,
          child: ProductCounter(
            countController: _vm.valueController,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SvgPicture.asset(
            ProductIcons.star,
            alignment: Alignment.centerLeft,
          ),
        ),
        Expanded(
          flex: 3,
          child: MyText.h3(
            widget.product.rating.toString(),
            customStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 20,
          child: MyText.h5(
            ProductStrings.getReviewsCountText(widget.product.reviewsCount),
            color: ApplicationColors.textGray2,
            customStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
