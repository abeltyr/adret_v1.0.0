import 'package:adret/model/input/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/category/screen/index.dart';
import 'package:adret/widgets/product/category/card/index.dart';
import 'package:adret/widgets/textIconField/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProductCategoryInput extends StatelessWidget {
  final InputModel category;
  const ProductCategoryInput({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    bool categoryExist = category.input == null ||
        (category.input != null && category.input!.isEmpty);
    return Column(
      children: [
        SizedBox(
          height: categoryExist ? 6 : 12,
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15.0),
                ),
              ),
              context: context,
              isScrollControlled: true,
              backgroundColor: DarkModePlatformTheme.secondBlack,
              builder: (context) => const CategoryInventory(),
            );
          },
          behavior: HitTestBehavior.translucent,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: categoryExist
                ? TextIconField(
                    icon: "assets/icons/tag.svg",
                    content: AppLocalizations.of(context)!.category,
                    color: DarkModePlatformTheme.white.withOpacity(0.5),
                    ratio1: 1.2,
                    ratio2: 10.8,
                    size: 25,
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 1.2 / 12 + 5),
                    child: Row(
                      children: [
                        Category(
                          width: MediaQuery.of(context).size.width - 50,
                          showIcon: true,
                          content: category.input.toString(),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
