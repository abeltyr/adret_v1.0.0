import 'dart:io';

import 'package:adret/model/shared.dart';
import 'package:adret/services/navbar.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/navbar/navbarButton/index.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  final List<NavbarModel> navbarData;
  const Navbar({
    Key? key,
    required this.navbarData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navbar = Provider.of<NavbarService>(context, listen: true);

    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 80,
      decoration: BoxDecoration(
        color: DarkModePlatformTheme.black,
        border: Border(
          top: BorderSide(
            width: 0.25,
            color: DarkModePlatformTheme.white.withOpacity(0.5),
          ),
        ),
      ),
      padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: (Platform.isAndroid ? 10 : 15),
          bottom: (Platform.isAndroid
              ? MediaQuery.of(context).padding.bottom + 10
              : MediaQuery.of(context).padding.bottom * 2 / 3)),
      child: Row(
        children: navbarData
            .map(
              (data) => NavbarButton(
                width: (width - 20) / navbarData.length,
                active: navbar.navBarIndex == data.index,
                activeIcon: data.activeIcon,
                icon: data.icon,
                click: () {
                  if (data.path != null) {
                    Navigator.pushNamed(context, data.path!);
                  } else if (data.modal != null) {
                    CupertinoScaffold.showCupertinoModalBottomSheet(
                        enableDrag: false,
                        context: context,
                        backgroundColor: DarkModePlatformTheme.secondBlack,
                        builder: (context) => data.modal!);
                  } else {
                    navbar.updateNavBarIndex(data.index);
                  }
                },
                title: data.title,
              ),
            )
            .toList(),
      ),
    );
  }
}
