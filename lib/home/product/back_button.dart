import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/home/product/resources.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/icons.dart';

class ProductBackButton extends StatelessWidget {
  final void Function()? onPressed;

  const ProductBackButton({Key? key, this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ProductSizes.backButtonSize,
      height: ProductSizes.backButtonSize,
      child: ElevatedButton(
        onPressed: onPressed,
        child: SvgPicture.asset(
          ApplicationIcons.backButton,
          fit: BoxFit.scaleDown,
        ),
        style: ElevatedButton.styleFrom(
          primary: ApplicationColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ProductSizes.favouriteButtonBorderRadius,
            ),
          ),
        ),
      ),
    );
  }

}