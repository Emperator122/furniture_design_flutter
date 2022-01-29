import 'package:flutter/material.dart';
import 'package:furniture/ui/text_style.dart';

class RegularButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Function()? onPressed;
  final String text;
  final double? elevation;

  const RegularButton({
    Key? key,
    this.width,
    this.height,
    this.elevation,
    this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF212121),
        elevation: elevation,
        fixedSize:
            (width != null && height != null) ? Size(width!, height!) : null,
      ),
      onPressed: onPressed,
      child: MyText.h3(
        text,
        fontFamily: MyTextFontFamily.gelasio,
      ),
    );
  }
}
