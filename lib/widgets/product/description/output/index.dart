import 'package:adret/model/input/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/description/screen/index.dart';
import 'package:adret/widgets/textAreaIconField/index.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProductDescriptionOutput extends StatelessWidget {
  final String detail;
  const ProductDescriptionOutput({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    bool descriptionExist = detail.isEmpty;
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          context: context,
          builder: (context) => DescriptionScreen(
              initialData: InputModel(input: detail),
              disable: true,
              saveData: (value) {},
              focus: false,
              label: AppLocalizations.of(context)!.productDescriptionPrompt),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.only(
          top: descriptionExist ? 12 : 6,
        ),
        child: TextAreaIconField(
          icon: descriptionExist ? "assets/icons/document.svg" : null,
          label: AppLocalizations.of(context)!.description,
          content: descriptionExist ? AppLocalizations.of(context)!.description : detail,
          fontWeight: FontWeight.w200,
          color: descriptionExist
              ? DarkModePlatformTheme.darkWhite
              : DarkModePlatformTheme.white,
          ratio1: descriptionExist ? 1.1 : 1.2,
          ratio2: descriptionExist ? 10.9 : 10.8,
          size: descriptionExist ? 23 : 16,
        ),
      ),
    );
  }
}
