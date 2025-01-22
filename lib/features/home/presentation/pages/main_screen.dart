import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:maos/core/common/themes.dart';

import 'home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final savedNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();

  int selectedTab = 0;
  List<NavModel> navigation = [];

  @override
  void initState() {
    super.initState();
    navigation = [
      NavModel(page: HomePage(), navKey: homeNavKey),
      NavModel(page: Container(), navKey: savedNavKey),
      NavModel(page: Container(), navKey: profileNavKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navigation[selectedTab].navKey.currentState?.canPop() ?? false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) navigation[selectedTab].navKey.currentState?.pop();
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab,
          children: navigation.map((page) {
            return Navigator(
              key: page.navKey,
              onGenerateInitialRoutes: (navigator, initialRoute) {
                return [
                  MaterialPageRoute(builder: (context) => page.page),
                ];
              },
            );
          }).toList(),
        ),
        bottomNavigationBar: NavBar(
          page: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              navigation[index].navKey.currentState?.popUntil((route) => route.isFirst);
            } else {
              setState(() => selectedTab = index);
            }
          },
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final int page;
  final Function(int) onTap;
  const NavBar({
    super.key,
    required this.page,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      height: 70,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          NavItem(
            icon: IconsaxPlusLinear.home_2,
            activeIcon: IconsaxPlusBold.home_2,
            selected: page == 0,
            onTap: () => onTap(0),
          ),
          NavItem(
            icon: IconsaxPlusLinear.save_2,
            activeIcon: IconsaxPlusBold.save_2,
            selected: page == 1,
            onTap: () => onTap(1),
          ),
          // const SizedBox(width: 64),
          NavItem(
            icon: IconsaxPlusLinear.profile_circle,
            activeIcon: IconsaxPlusBold.profile_circle,
            selected: page == 2,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool selected;
  final Function()? onTap;
  const NavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          selected ? activeIcon : icon,
          color: selected ? Theme.of(context).colorScheme.primary : Get.theme.appColors.neutral40,
        ),
      ),
    );
  }
}

class NavModel {
  final Widget page;
  final GlobalKey<NavigatorState> navKey;

  NavModel({required this.page, required this.navKey});
}
