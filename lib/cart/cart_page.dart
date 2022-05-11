import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/cart/promo_field.dart';
import 'package:furniture/cart/resources.dart';
import 'package:furniture/cart/product_container.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/home/product_grid_item.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/icons.dart';
import 'package:furniture/ui/strings.dart';
import 'package:furniture/ui/text_style.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late final List<Product> products;

  @override
  void initState() {
    super.initState();
    products = CartPageExt.mock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: _buildTitle(),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(ApplicationIcons.backButton),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: CartSizes.mainPadding),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return MyText.h4(
      CartStrings.pageTitle,
      color: ApplicationColors.black,
      fontFamily: MyTextFontFamily.merriweather,
      customStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: List.generate(
              products.length,
              (index) {
                final product = products[index];
                return Column(
                  children: [
                    ProductContainer(product: product),
                    if (index != products.length - 1)
                      const Divider(
                        height: CartSizes.productPadding * 2,
                        thickness: 1.0,
                        color: ApplicationColors.blurGray,
                      ),
                  ],
                );
              },
            ),
          ),
        ),
        SafeArea(
          child: _buildBottomPart(products),
        ),
      ],
    );
  }

  Widget _buildBottomPart(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: CartSizes.mainPadding),
      child: Column(
        children: [
          const PromoField(),
          const SizedBox(height: CartSizes.mainPadding),
          _buildTotalField(products),
          const SizedBox(height: CartSizes.mainPadding),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildTotalField(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CartSizes.mainPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.custom(
            CartStrings.totalText,
            color: ApplicationColors.textGray2,
            customStyle: const TextStyle(fontWeight: FontWeight.bold),
            fontSize: 20,
          ),
          MyText.custom(
            '${ApplicationStrings.currencySymbol} ${products.uiPrice}',
            color: ApplicationColors.black,
            customStyle: const TextStyle(fontWeight: FontWeight.bold),
            fontSize: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
      ),
      onPressed: () => true,
      child: MyText.custom(CartStrings.checkOutText,
          fontSize: 20,
          customStyle: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

extension CartPageExt on CartPage {
  static List<Product> mock() {
    final products = ProductGridItemExt.mock();

    int randomCount() {
      final rnd = Random();
      return 1 + rnd.nextInt(products.length);
    }

    return products.getRange(0, randomCount()).toList();
  }
}
