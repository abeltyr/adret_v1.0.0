import 'package:adret/model/shared.dart';
import 'package:adret/services/navbar.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/account/index.dart';
import 'package:adret/views/shared/product/listing/index.dart';
import 'package:adret/views/shared/order/index.dart';
import 'package:adret/widgets/navbar/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<NavbarModel> managerNavbar = [
  NavbarModel(
    index: 0,
    activeIcon: "assets/icons/navbar/shop.svg",
    icon: "assets/icons/navbar/shopLine.svg",
    title: "Shop",
  ),
  NavbarModel(
    index: 1,
    activeIcon: "assets/icons/bold/product.svg",
    icon: "assets/icons/product.svg",
    title: "Products",
  ),
  // NavbarModel(
  //   index: 3,
  //   activeIcon: "assets/icons/bold/order.svg",
  //   icon: "assets/icons/order.svg",
  //   title: "Checkout",
  //   modal: const CheckoutScreen(),
  // ),
  NavbarModel(
    index: 2,
    activeIcon: "assets/icons/bold/userOctagon.svg",
    icon: "assets/icons/userOctagon.svg",
    title: "Products",
  ),
];

class EmployeeView extends StatefulWidget {
  const EmployeeView({super.key});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  @override
  void initState() {
    Provider.of<UserService>(context, listen: false).fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navbar = Provider.of<NavbarService>(context, listen: true);

    return Scaffold(
      backgroundColor: DarkModePlatformTheme.secondBlack,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: IndexedStack(
                index: navbar.navBarIndex,
                children: const [
                  OrderScreen(),
                  ProductScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Navbar(
                navbarData: managerNavbar,
              ),
            )
          ],
        ),
      ),
    );
  }
}
