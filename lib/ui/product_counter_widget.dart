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
  final int count;
  final ValueCubit<int>? countController;
  final void Function(int newCount)? onIncrease;
  final void Function(int newCount)? onDecrease;

  const ProductCounter({
    Key? key,
    this.count = 0,
    this.countController,
    this.onIncrease,
    this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkResponse(
          radius: _buttonSize * 0.67,
          onTap: () {
            final newCount = (countController?.state ?? count) + 1;
            countController?.state = newCount;
            if (onIncrease != null) {
              onIncrease!(newCount);
            }
          },
          child: const ButtonContainer(
            assetName: ProductIcons.plus,
            size: _buttonSize,
          ),
        ),
        if (countController != null)
          StreamBuilder(
            stream: countController!.stream,
            builder: (context, state) {
              return MyText.h3(
                ProductStrings.counterTextFormatter(countController!.state),
                overflow: TextOverflow.ellipsis,
                customStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          )
        else
          MyText.h3(
            ProductStrings.counterTextFormatter(count),
            overflow: TextOverflow.ellipsis,
            customStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        InkResponse(
          radius: _buttonSize * 0.67,
          onTap: () {
            final newCount = (countController?.state ?? count) - 1;
            countController?.state = newCount;
            if (onDecrease != null) {
              onDecrease!(newCount);
            }
          },
          child: const ButtonContainer(
            assetName: ProductIcons.minus,
            size: _buttonSize,
          ),
        ),
      ],
    );
  }
}

class ButtonContainer extends StatelessWidget {
  final String assetName;
  final double size;

  const ButtonContainer({
    Key? key,
    required this.size,
    required this.assetName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
