import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/home/categories_widget.dart';
import 'package:furniture/home/models/product_category.dart';
import 'package:furniture/home/product_grid_item.dart';
import 'package:furniture/home/product/product_page.dart';
import 'package:furniture/home/resources.dart';
import 'package:furniture/misc/value_cubit.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/text_style.dart';

class HomePageVM {
  final ValueCubit<ProductCategory?> categoryController;

  HomePageVM() : categoryController = ValueCubit<ProductCategory?>(null);

  void close() {
    categoryController.close();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late final HomePageVM _vm;

  @override
  void initState() {
    _vm = HomePageVM();
    super.initState();
  }

  @override
  void dispose() {
    _vm.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(HomeIcons.search),
          onPressed: () {
            return;
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(HomeIcons.cart),
            onPressed: () {
              return;
            },
          ),
        ],
        title: _buildTitle(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyText.h3(
            HomeStrings.appBarTitle,
            color: ApplicationColors.textGray,
            fontFamily: MyTextFontFamily.gelasio,
            customStyle: const TextStyle(fontWeight: FontWeight.w400),
          ),
          MyText.h3(
            HomeStrings.appBarSubtitle,
            fontFamily: MyTextFontFamily.gelasio,
            customStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final ratio = (MediaQuery.of(context).size.width / 2 -
            2 * HomeSizes.productsListMargin -
            HomeSizes.productsListMargin) /
        (HomeSizes.productImageHeight + 10);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CategoriesWidget(
            categories: CategoriesWidgetExt.mock(),
            selectedCategoryController: _vm.categoryController,
          ),
          const SizedBox(
            height: HomeSizes.productsListMargin,
          ),
          SafeArea(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: ratio,
              padding: const EdgeInsets.symmetric(
                  horizontal: HomeSizes.productsListMargin),
              mainAxisSpacing: HomeSizes.productItemMargin,
              crossAxisSpacing: HomeSizes.productsListMargin,
              children: ProductGridItemExt.mock()
                  .map<Widget>(
                    (product) => ProductGridItem(
                      product: product,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductPage(product: product),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
