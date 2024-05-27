import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wordpresstest/models/product_item.dart';
import 'package:wordpresstest/pages/products/product_item_card_widget.dart';
import 'package:wordpresstest/provider/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:wordpresstest/provider/products_provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  String? categoryId, categoryName;

  final _sortByOptions = [
    SortBy("popularity", "Popularity ", "asc"),
    SortBy("modify", "Latest", "asc "),
    SortBy("price", "Price: High to Low ", "desc "),
    SortBy("price", "Price: Low to HIgh ", "asc "),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    categoryId = arguments['catId'].toString() ?? "";
    categoryName = arguments['catName'].toString() ?? "";

    var productsList = Provider.of<ProductsProvider>(context, listen: false);
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          productsList.setLoadMoreState(LoadMoreStatus.LOADING);
          productsList.fetchProducts(++_page,
              categoryId: categoryId.toString());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.only(left: 25),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        actions: [],
        title: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              categoryName!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
      ),
      body: _productsList(),
    );
  }

  Widget _productsList() {
    return Consumer<ProductsProvider>(
      builder: (context, productModel, child) {
        if (productModel.allProducts.isNotEmpty &&
            productModel.getLoadMoreStatus() != LoadMoreStatus.INITIAL) {
          return Column(
            children: [
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 0,
                  controller: _scrollController,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(1),
                  children: productModel.allProducts.map((ProductModel item) {
                    return GestureDetector(
                      onTap: () => onProductItemClicked(context, item),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: ProductItemCardWidget(
                          item: item,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible:
                    productModel.getLoadMoreStatus() == LoadMoreStatus.LOADING,
                child: Container(
                  padding: EdgeInsets.all(50),
                  height: 35,
                  width: 35,
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          );
        }

        if (productModel.allProducts.isEmpty &&
            productModel.getLoadMoreStatus() == LoadMoreStatus.STABLE) {
          return Center(
            child: Text(
              "NO Products",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _productFilters() {
    return PopupMenuButton(
      onSelected: (sortBy) {
        var productProvider =
            Provider.of<ProductsProvider>(context, listen: false);
        productProvider.resetStreams();
        productProvider.setSortOrder(sortBy);
        productProvider.fetchProducts(_page,
            categoryId: categoryId.toString()); // here
      },
      itemBuilder: (BuildContext context) {
        return _sortByOptions.map(
          (item) {
            return PopupMenuItem(
              value: item,
              child: Container(
                child: Text(item.text),
              ),
            );
          },
        ).toList();
      },
      icon: Container(
          padding: EdgeInsets.only(right: 25),
          child: Icon(
            Icons.sort,
            color: Colors.black,
          )),
    );
  }

  void onProductItemClicked(BuildContext context, ProductModel model) {
    Navigator.of(context).pushNamed("/product-details", arguments: {
      'productId': model.productId,
      'productName': model.productName,
    });
  }
}
