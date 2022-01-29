import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double _linesMargin = 20.0;

class AuthHeader extends StatelessWidget {
  const AuthHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _getDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _linesMargin),
          child: SizedBox(
            child: SvgPicture.asset(
              'assets/registration/header_icon.svg',
            ),
          ),
        ),
        _getDivider(),
      ],
    );
  }

  Widget _getDivider() => Expanded(
    child: Container(
          color: const Color(0xFFBDBDBD),
          height: 1,
        ),
  );
}
