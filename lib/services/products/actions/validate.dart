import 'package:adret/model/input/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:adret/services/inventory/index.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> validateProductsFunction({
  required ProductViewModel hiveData,
  required InputModel title,
  required BuildContext context,
}) async {
  try {
    // if (product.currentProductLoading) return;
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    if (hiveData.media == null ||
        (hiveData.media != null && hiveData.media!.isEmpty)) {
      // ignore: use_build_context_synchronously
      errorNotification(
        context: context,
        text: AppLocalizations.of(context)!.addImageError,
        bottom: 0,
      );
      return false;
    }

    if (title.input == null || title.input.toString().trim() == "") {
      // ignore: use_build_context_synchronously
      errorNotification(
        context: context,
        text: AppLocalizations.of(context)!.titleError,
        bottom: 0,
      );
      return false;
    } else {
      hiveData.title = title;
    }

    var category = hiveData.category ?? InputModel();
    if (category.input == null ||
        (category.input != null && category.input.toString().trim() == "")) {
      // ignore: use_build_context_synchronously
      errorNotification(
        context: context,
        text: AppLocalizations.of(context)!.categoryError,
        bottom: 0,
      );
      return false;
    }

    final inventoryService =
        Provider.of<InventoryService>(context, listen: false);
    bool validation = await inventoryService.validateInventory(
      hiveData.inventory![0],
      (text) {
        errorNotification(
          context: context,
          text: text,
          bottom: 0,
        );
      },
      context,
    );

    if (!validation) return false;
    return true;
  } catch (e) {
    errorNotification(
      context: context,
      text: AppLocalizations.of(context)!.inventoryValidationError,
      bottom: 0,
    );
    return false;
    // throw Exception(e);
  }
}
