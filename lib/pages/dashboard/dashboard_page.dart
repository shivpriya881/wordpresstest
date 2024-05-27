import 'package:flutter/material.dart';
import 'package:wordpresstest/pages/dashboard/navigator_item.dart';
import 'package:wordpresstest/utils/colors.dart';
import 'package:flutter_svg/svg.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigatorItems[currentIndex].screen,
      bottomNavigationBar: buildBottomNavigatorBar(),
    );
  }

  BottomNavigationBar buildBottomNavigatorBar() {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        items: navigatorItems.map((e) => getNavigatorBarItem(e)).toList());
  }

  BottomNavigationBarItem getNavigatorBarItem(NavigatorItem item) {
    Color iconColor =
        item.index == currentIndex ? AppColors.primaryColor : Colors.black;
    return BottomNavigationBarItem(
        label: item.label,
        icon: item.iconPath != null
            ? SvgPicture.asset(
                item.iconPath!,
                color: iconColor,
              )
            : SizedBox());
  }
}
