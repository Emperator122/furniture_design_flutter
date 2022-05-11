import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/cart/resources.dart';
import 'package:furniture/ui/colors.dart';

class PromoField extends StatelessWidget {
  const PromoField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      elevation: 20,
      child: TextField(
        enableSuggestions: false,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter your promo code',
          enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          suffixIcon: PromoButton(),
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(color: ApplicationColors.hintGray),
        ),
      ),
    );
  }

}

class PromoButton extends StatelessWidget {
  const PromoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => true,
      style: ElevatedButton.styleFrom(
        primary: ApplicationColors.black
      ),
      child: SvgPicture.asset(
        CartImages.promoApplyImage,
        fit: BoxFit.none,
      ),
    );
  }
}
