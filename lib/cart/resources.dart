import 'package:furniture/cart/models/cart_product.dart';

abstract class CartStrings {
  static const pageTitle = 'MY CART';
  static const totalText = 'Total:';
  static const checkOutText = 'CHECK OUT';

  static String getUITotalPrice(List<CartProduct> products) => products
      .fold<double>(
          0,
          (previousValue, element) =>
              previousValue + element.product.price * element.count)
      .toStringAsFixed(2);
}

abstract class CartSizes {
  static const mainPadding = 20.0;
  static const productImageSize = 100.0;
  static const productImageBorderRadius = 10.0;
  static const productCounterWidth = 113.0;
  static const productPadding = 12.0;
}

abstract class CartImages {
  static const promoApplyImage = 'assets/cart/right_arrow.svg';
}
