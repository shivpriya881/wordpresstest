import 'package:flutter/material.dart';
import 'package:wordpresstest/pages/categories/categories_page.dart';

class NavigatorItem {
  final String label;
  final String? iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Shop", null, 0, SizedBox()),
  NavigatorItem("Categories", null, 1, CategoriesPage()),
  NavigatorItem("Cart", null, 2, SizedBox()),
  NavigatorItem("Account", null, 3, SizedBox())
];
