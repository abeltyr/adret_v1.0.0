import 'package:adret/services/user/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/product/create.dart';
import 'package:adret/views/shared/product/listing/listings/search/header/index.dart';
import 'package:adret/views/shared/product/listing/listings/allProducts/index.dart';
import 'package:adret/views/shared/product/listing/listings/search/index.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool searchOpened = false;

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: true);
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SearchHeader(
              searchOpened: searchOpened,
              openSearchOpened: () {
                setState(() {
                  searchOpened = true;
                });
              },
              closeSearchOpened: () {
                setState(() {
                  searchOpened = false;
                });
              },
            ),
            Expanded(
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: IndexedStack(
                    index: searchOpened ? 1 : 0,
                    children: [
                      ProductListing(
                          role: userService.currentUser.userRole ?? "Employee"),
                      const SearchProduct(),
                    ],
                  )),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
        if (userService.currentUser.userRole == "Manager" && !searchOpened)
          Positioned(
            bottom: 96,
            right: 0,
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: MainButton(
                    icon: !searchOpened
                        ? "assets/icons/bold/add.svg"
                        : "assets/icons/bold/scan.svg",
                    textFontSize: 30,
                    borderRadiusData: 10,
                    color: DarkModePlatformTheme.primary,
                    onClick: () {
                      if (searchOpened) {
                      } else {
                        CupertinoScaffold.showCupertinoModalBottomSheet(
                          context: context,
                          enableDrag: false,
                          builder: (context) => const CreateProduct(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
