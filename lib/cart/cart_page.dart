import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/cart/bloc.dart';
import 'package:furniture/cart/promo_field.dart';
import 'package:furniture/cart/resources.dart';
import 'package:furniture/cart/product_container.dart';
import 'package:furniture/cart/models/cart_product.dart';
import 'package:furniture/repositories/cart_repository.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/icons.dart';
import 'package:furniture/ui/strings.dart';
import 'package:furniture/ui/text_style.dart';

class CartPageVM {
  late final CartBloc cartBloc;

  CartPageVM() {
    cartBloc = CartBloc(
      repository: CartRepositoryMock(),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late final CartPageVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = CartPageVM();
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
    return BlocBuilder(
      bloc: _vm.cartBloc,
      builder: (context, state) {
        if (state is CartLoadedState) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(
                    state.products.length,
                    (index) {
                      final product = state.products[index];
                      return Column(
                        children: [
                          ProductContainer(
                            cartProduct: product,
                            cartBloc: _vm.cartBloc,
                          ),
                          if (index != state.products.length - 1)
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
                child: _buildBottomPart(state.products),
              ),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildBottomPart(List<CartProduct> products) {
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

  Widget _buildTotalField(List<CartProduct> products) {
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
            '${ApplicationStrings.currencySymbol} ${CartStrings.getUITotalPrice(products)}',
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
