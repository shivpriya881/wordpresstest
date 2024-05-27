import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wordpresstest/models/product_item.dart';
import 'package:wordpresstest/utils/colors.dart';

class ProductItemCardWidget extends StatelessWidget {
  const ProductItemCardWidget({super.key, required this.item});

  final ProductModel item;
  final double width = 174;
  final double height = 250;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: item.images!.isNotEmpty
                  ? Image.network(item.images![0].url.toString())
                  : SizedBox(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              item.productName!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "\$${item.price}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                addWidget(),
              ],
            )
          ])),
    );
  }

  Widget addWidget() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}
