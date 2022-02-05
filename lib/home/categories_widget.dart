import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/home/models/product_category.dart';
import 'package:furniture/home/resources.dart';
import 'package:furniture/misc/value_cubit.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/text_style.dart';

class CategoriesWidget extends StatelessWidget {
  final List<ProductCategory> categories;
  final ValueCubit<ProductCategory?> selectedCategoryController;

  const CategoriesWidget({
    Key? key,
    required this.categories,
    required this.selectedCategoryController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductCategory?>(
        stream: selectedCategoryController.stream,
        builder: (context, state) {
          final selectedCategoryName = selectedCategoryController.state?.name ??
              (categories.isNotEmpty ? categories.first.name : null);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: HomeSizes.categoriesPadding,
              ),
              child: Wrap(
                spacing: HomeSizes.categoriesMargin,
                children: categories.map<Widget>((category) {
                  void _onCategoryTap() =>
                      selectedCategoryController.state = category;
                  return category.name == selectedCategoryName
                      ? CategoryIcon.selected(
                          category: category,
                          onTap: _onCategoryTap,
                        )
                      : CategoryIcon.unselected(
                          category: category,
                          onTap: _onCategoryTap,
                        );
                }).toList(),
              ),
            ),
          );
        });
  }
}

class CategoryIcon extends StatelessWidget {
  final Color iconColor;
  final Color containerColor;
  final Color textColor;
  final FontWeight fontWeight;
  final ProductCategory category;
  final void Function() onTap;

  const CategoryIcon.selected(
      {Key? key, required this.category, required this.onTap})
      : containerColor = ApplicationColors.black,
        iconColor = ApplicationColors.white,
        fontWeight = FontWeight.w600,
        textColor = ApplicationColors.black,
        super(key: key);

  const CategoryIcon.unselected(
      {Key? key, required this.category, required this.onTap})
      : containerColor = ApplicationColors.blurGray,
        iconColor = ApplicationColors.textGray,
        fontWeight = FontWeight.w400,
        textColor = ApplicationColors.textGray2,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: HomeSizes.categoriesIconSize,
            height: HomeSizes.categoriesIconSize,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: const BorderRadius.all(
                  Radius.circular(HomeSizes.categoriesIconBorderRadius)),
            ),
            child: Center(
              child: SvgPicture.asset(
                category.icon,
                color: iconColor,
              ),
            ),
          ),
          MyText.h5(
            category.name,
            color: textColor,
            customStyle: TextStyle(fontWeight: fontWeight),
          )
        ],
      ),
    );
  }
}

extension CategoriesWidgetExt on CategoriesWidget {
  static List<ProductCategory> mock() {
    const dir = 'assets/home';
    return <ProductCategory>[
      ProductCategory(
        icon: '$dir/cats_favourite.svg',
        name: 'Popular',
      ),
      ProductCategory(
        icon: '$dir/cats_chair.svg',
        name: 'Chair',
      ),
      ProductCategory(
        icon: '$dir/cats_table.svg',
        name: 'Table',
      ),
      ProductCategory(
        icon: '$dir/cats_armchair.svg',
        name: 'Armchair',
      ),
      ProductCategory(
        icon: '$dir/cats_bed.svg',
        name: 'Bed',
      ),
      ProductCategory(
        icon: '$dir/cats_lamp.svg',
        name: 'Lamp',
      ),
    ];
  }
}
