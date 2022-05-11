import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/cart/cart_page.dart';
import 'package:furniture/home/favorite/favorite_product_container.dart';
import 'package:furniture/home/favorite/resources.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/home/product_grid_item.dart';
import 'package:furniture/home/resources.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/text_style.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FavoritePageState();
  }
}

class FavoritePageState extends State<FavoritePage> {
  late final List<Product> products;

  @override
  void initState() {
    super.initState();
    products = FavoritePageExt.mock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(HomeIcons.search),
          onPressed: () {
            return;
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(HomeIcons.cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
          ),
        ],
        title: _buildTitle(),
      ),
      body: Stack(
        children: [
          _buildBody(),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return MyText.h4(
      FavoriteStrings.appBarTitle,
      color: ApplicationColors.black,
      fontFamily: MyTextFontFamily.merriweather,
      customStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FavoriteSizes.mainPadding,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ...List.generate(
                  products.length,
                  (index) {
                    final product = products[index];
                    return Column(
                      children: [
                        FavoriteProductContainer(product: product),
                        if (index != products.length - 1)
                          const Divider(
                            height: FavoriteSizes.productPadding * 2,
                            thickness: 1.0,
                            color: ApplicationColors.blurGray,
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: FavoriteSizes.productImageSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(FavoriteSizes.mainPadding),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            height: FavoriteSizes.addAllToCartButtonHeight,
            child: ElevatedButton(
              onPressed: () => true,
              style: ElevatedButton.styleFrom(
                elevation: 20.0,
              ),
              child: MyText.h3(
                FavoriteStrings.addAllToCartButtonText,
                color: ApplicationColors.white,
                customStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension FavoritePageExt on FavoritePage {
  static List<Product> mock() {
    final products = ProductGridItemExt.mock();

    int randomCount() {
      final rnd = Random();
      return rnd.nextInt(products.length);
    }

    return products.getRange(0, randomCount()).toList();
  }
}
