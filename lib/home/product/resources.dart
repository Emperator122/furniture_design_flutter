class ProductIcons {
  static const addToFavourite = 'assets/home/add_to_favourite.svg';
  static const minus = 'assets/home/minus_icon.svg';
  static const plus = 'assets/home/plus_icon.svg';
  static const star = 'assets/home/star.svg';

  ProductIcons._();
}

class ProductStrings {
  static const addToCartButtonText = 'Add to cart';
  static String getReviewsCountText(int count) => '($count reviews)';

  static String counterTextFormatter(int count) {
    if(count < 10) {
      return '0$count';
    }
    return count.toString();
  }

  ProductStrings._();
}

class ProductSizes {
  static const imageLeftPaddingMultiplier = 0.14;
  static const imageHeightMultiplier = 0.5;
  static const imageBottomLeftBorderRadius = 50.0;
  static const imageBottomMargin = 25.0;
  static const productInformationPadding = 25.0;
  static const defaultMargin = 10.0;
  static const productCounterWidth = 113.0;
  static const addToFavouriteTextSize = 20.0;
  static const buttonsBottomMargin = 20.0;
  static const buttonsRightMargin = 20.0;
  static const buttonsHeight = 60.0;
  static const favouriteButtonBorderRadius = 16.0;
  static const backButtonSize = 50.0;
  static const backButtonTopMargin = 15.0;

  ProductSizes._();
}