import 'package:adret/model/input/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/product/description/screen/index.dart';
import 'package:adret/widgets/textAreaIconField/index.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDescriptionInput extends StatelessWidget {
  final InputModel detail;
  final Function updateFunction;
  final bool showIcon;
  const ProductDescriptionInput({
    super.key,
    required this.detail,
    required this.updateFunction,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    bool descriptionExist = (detail.input == null ||
        (detail.input != null && detail.input!.isEmpty));

    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          context: context,
          enableDrag: false,
          builder: (context) => DescriptionScreen(
            initialData: detail,
            saveData: (value) {
              updateFunction(value);
            },
            focus: true,
            label: AppLocalizations.of(context)!.productDescriptionPrompt,
          ),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.only(
          top: descriptionExist ? 12 : 6,
        ),
        child: TextAreaIconField(
          showIcon: showIcon && descriptionExist,
          icon:
              descriptionExist || showIcon ? "assets/icons/document.svg" : null,
          label: AppLocalizations.of(context)!.description,
          content: descriptionExist
              ? AppLocalizations.of(context)!.description
              : detail.input.toString(),
          fontWeight: FontWeight.w200,
          color: descriptionExist
              ? DarkModePlatformTheme.grey5.withOpacity(0.5)
              : DarkModePlatformTheme.grey5,
          ratio1: descriptionExist || showIcon ? 1.1 : 1.2,
          ratio2: descriptionExist || showIcon ? 10.9 : 10.8,
          size: descriptionExist || showIcon ? 25 : 17,
        ),
      ),
    );
  }
}
