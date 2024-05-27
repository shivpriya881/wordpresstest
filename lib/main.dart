import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpresstest/pages/dashboard/dashboard_page.dart';
import 'package:wordpresstest/pages/products/products_page.dart';
import 'package:wordpresstest/provider/products_provider.dart';
import 'package:wordpresstest/pages/products/product_details_page.dart';
import 'pages/categories/categories_page.dart';

Widget _defaultHome = DashboardPage(); // Corrected to DashboardPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProductsProvider(), child: ProductsPage())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // disable debug banner
        routes: <String, WidgetBuilder>{
          '/': (context) => DashboardPage(),
          '/products': (context) => ProductsPage(),
          '/products-details': (context) => ProductDetailsPage(),
        },
      ),
    );
  }
}
