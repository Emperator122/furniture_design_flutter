import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/cart/cart_page.dart';
import 'package:furniture/home/favorite/bloc.dart';
import 'package:furniture/home/favorite/favorite_product_container.dart';
import 'package:furniture/home/favorite/resources.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/home/resources.dart';
import 'package:furniture/repositories/favorite_repository.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/text_style.dart';

class FavoritePageVm {
  late final FavoriteBloc _bloc;

  FavoritePageVm() {
    _bloc = FavoriteBloc(repository: FavoriteRepositoryMock());
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FavoritePageState();
  }
}

class FavoritePageState extends State<FavoritePage> {
  late final FavoritePageVm _vm;

  @override
  void initState() {
    super.initState();
    _vm = FavoritePageVm();
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
      body: BlocBuilder(
          bloc: _vm._bloc,
          builder: (_, state) {
            if (state is FavoriteLoadedState) {
              return Stack(
                children: [
                  _buildBody(state.products),
                  _buildButton(),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
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

  Widget _buildBody(List<Product> products) {
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
                        FavoriteProductContainer(
                          product: product,
                          onRemove: (product) => _vm._bloc.add(
                            RemoveProduct(product: product),
                          ),
                        ),
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
