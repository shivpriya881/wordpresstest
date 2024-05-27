import 'package:flutter/material.dart';
import 'package:wordpresstest/models/product_item.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductModel? model;
  String? productId, productName;

  @override
  void initState() {
    super.initState();
    model = ProductModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    productId = arguments["productId"]?.toString() ?? "";
    productName = arguments["productName"]?.tostring() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
