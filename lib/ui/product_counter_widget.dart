import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/home/product/resources.dart';
import 'package:furniture/misc/value_cubit.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/text_style.dart';

const _buttonSize = 30.0;
const _color = ApplicationColors.textGray4;
const _borderRadius = 10.0;

class ProductCounter extends StatelessWidget {
  final ValueCubit<int> countController;

  const ProductCounter({
    Key? key,
    required this.countController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkResponse(
          radius: _buttonSize * 0.67,
          onTap: () => countController.state++,
          child: _buildButtonContainer(ProductIcons.plus),
        ),
        StreamBuilder(
            stream: countController.stream,
            builder: (context, _) {
              return MyText.h3(
                ProductStrings.counterTextFormatter(countController.state),
                overflow: TextOverflow.ellipsis,
                customStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
        InkResponse(
          radius: _buttonSize * 0.67,
          onTap: () => countController.state--,
          child: _buildButtonContainer(ProductIcons.minus),
        ),
      ],
    );
  }

  Widget _buildButtonContainer(String assetName) {
    return Container(
      height: _buttonSize,
      width: _buttonSize,
      decoration: const BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
      ),
      child: SvgPicture.asset(
        assetName,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
