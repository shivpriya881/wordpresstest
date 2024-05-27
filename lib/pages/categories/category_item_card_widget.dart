//stl
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wordpresstest/utils/colors.dart';
import 'package:wordpresstest/models/category_model.dart';

class CategoryItemCardWidget extends StatelessWidget {
  const CategoryItemCardWidget(
      {super.key, required this.item, required this.color});

  final CategoryModel item;
  final double height = 150.0;
  final double width = 175.0;
  final Color borderColor = AppColors.darkGrey;
  final double borderRadius = 18;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
              decoration: BoxDecoration(
                  color: color.withOpacity(.1),
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 90,
                      width: 100,
                      child: SizedBox(
                        width: 80,
                        child: item.image?.url != null
                            ? Image.network(item.image!.url!)
                            : SizedBox(),
                      ),
                    )
                  ])),
        ),
        SizedBox(
            height: 30,
            child: Text(
              item.categoryName!,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
