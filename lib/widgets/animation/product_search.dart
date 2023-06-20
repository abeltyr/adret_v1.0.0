import 'package:adret/model/input/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/product_loading.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProductSearch extends StatefulWidget {
  const ProductSearch({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  late TextEditingController _valueController;
  @override
  void initState() {
    super.initState();
    _valueController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _valueController.dispose();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (constraints.maxWidth - 10) * 5 / 6,
            child: Input(
              controller: _valueController,
              label: AppLocalizations.of(context)!.inventoryTitle,
              valueSetter: () {
                return InputModel();
              },
              icon: "assets/icons/inventory.svg",
            ),
          ),
          SizedBox(
            width: (constraints.maxWidth - 10) / 6,
            child: GestureDetector(
              onTap: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: DarkModePlatformTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: !loading
                      ? SvgPicture.asset(
                          "assets/icons/searchProduct.svg",
                          width: 30,
                          height: 30,
                          color: DarkModePlatformTheme.black,
                        )
                      : const ProductLoading(),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
