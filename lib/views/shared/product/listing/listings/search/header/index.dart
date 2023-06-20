import 'package:adret/model/input/index.dart';
import 'package:adret/services/products/index.dart';
import 'package:adret/services/products/search.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchHeader extends StatefulWidget {
  final Function openSearchOpened;
  final Function closeSearchOpened;
  final bool searchOpened;
  const SearchHeader({
    super.key,
    required this.openSearchOpened,
    required this.closeSearchOpened,
    required this.searchOpened,
  });

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  late FocusNode _focus;
  bool hasText = false;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: "");
    _focus = FocusNode();
    _focus.addListener(_onFocusChange);
    if (_focus.hasFocus) {
      widget.openSearchOpened();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      widget.openSearchOpened();
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductService>(context, listen: true);
    final searchProduct =
        Provider.of<SearchProductService>(context, listen: false);
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 15,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: DarkModePlatformTheme.grey1,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Input(
                    focus: _focus,
                    controller: _controller,
                    icon: "assets/icons/bold/searchHeader.svg",
                    label: AppLocalizations.of(context)!.searchProducts,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        hasText = false;
                      } else {
                        hasText = true;
                      }
                      searchProduct.updateSearch(value);
                      setState(() {});
                    },
                    onDone: (value) {
                      searchProduct.search(value);
                    },
                    ratio1: product.hasSearch ? 1.35 : 1,
                    ratio2: product.hasSearch ? 10.65 : 11,
                    size: 20,
                    valueSetter: () {
                      return InputModel();
                    },
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  reverseDuration: const Duration(milliseconds: 100),
                  child: GestureDetector(
                    onTap: () {
                      _controller.text = "";
                      hasText = false;
                      setState(() {});
                    },
                    child: hasText
                        ? Container(
                            width: 32,
                            height: double.infinity,
                            padding: const EdgeInsets.all(3.5),
                            child: SvgPicture.asset(
                              "assets/icons/closeCircle.svg",
                              width: 30,
                              height: 30,
                              color: DarkModePlatformTheme.white,
                            ),
                          )
                        : Container(
                            width: 32,
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (widget.searchOpened)
          const SizedBox(
            width: 12,
          ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          reverseDuration: const Duration(milliseconds: 100),
          child: widget.searchOpened
              ? GestureDetector(
                  onTap: () {
                    widget.closeSearchOpened();
                    setState(() {});
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        color: DarkModePlatformTheme.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  width: 0,
                ),
        ),
      ],
    );
  }
}
