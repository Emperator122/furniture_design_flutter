import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/home/home_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TabsPageState();
  }
}

class TabsPageState extends State<TabsPage> {
  final navigationBarItems = <BottomNavigationBarExtendedItem>[
    BottomNavigationBarExtendedItem(
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/icon_home_inactive.svg'),
        activeIcon: SvgPicture.asset('assets/icon_home_active.svg'),
      ),
      targetScreen: const HomePage(),
    ),
    BottomNavigationBarExtendedItem(
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/icon_favourite_inactive.svg'),
        activeIcon: SvgPicture.asset('assets/icon_favourite_active.svg'),
      ),
      targetScreen: const SizedBox(),
    ),
    BottomNavigationBarExtendedItem(
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/icon_bell_inactive.svg'),
        activeIcon: SvgPicture.asset('assets/icon_bell_active.svg'),
      ),
      targetScreen: const SizedBox(),
    ),
    BottomNavigationBarExtendedItem(
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/icon_person_inactive.svg'),
        activeIcon: SvgPicture.asset('assets/icon_person_active.svg'),
      ),
      targetScreen: const SizedBox(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return cupertino.CupertinoTabScaffold(
      tabBar: cupertino.CupertinoTabBar(
        items: navigationBarItems
            .map<BottomNavigationBarItem>((e) => e.bottomNavigationBarItem)
            .toList(),
      ),
      tabBuilder: (BuildContext context, int index) {
        return navigationBarItems[index].targetScreen;
      },
    );
  }
}

class BottomNavigationBarExtendedItem {
  final BottomNavigationBarItem bottomNavigationBarItem;
  final cupertino.Widget targetScreen;

  BottomNavigationBarExtendedItem({
    required this.bottomNavigationBarItem,
    required this.targetScreen,
  });
}
