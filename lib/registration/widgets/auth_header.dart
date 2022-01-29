import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 4,
          child: _getDivider(),
        ),
        Flexible(
          flex: 3,
          child: SvgPicture.asset(
            'assets/registration/header_icon.svg',
          ),
        ),
        Flexible(
          flex: 4,
          child: _getDivider(),
        ),
      ],
    );
  }

  Widget _getDivider() => Container(
        color: const Color(0xFFBDBDBD),
        height: 1,
      );
}
