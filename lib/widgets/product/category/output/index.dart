import 'package:adret/widgets/product/category/card/index.dart';
import 'package:flutter/material.dart';

class ProductCategoryOutput extends StatelessWidget {
  final String category;
  const ProductCategoryOutput({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 1.2 / 12 + 5),
          child: Row(
            children: [
              Category(
                width: MediaQuery.of(context).size.width - 50,
                showIcon: true,
                content: category,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
