import 'package:adret/services/orders/index.dart';
import 'package:adret/services/summary/index.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/account/employeeSetup/index.dart';
import 'package:adret/views/shared/account/language/index.dart';
import 'package:adret/views/shared/account/settings/index.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/card/horizontalCard/index.dart';
import 'package:adret/widgets/card/iconHorizontalCard/index.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: true);
    final orderService = Provider.of<OrderService>(context, listen: false);
    final summaryService = Provider.of<SummaryService>(context, listen: false);
    return SizedBox(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: DarkModePlatformTheme.primaryLight3,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      avatarCut(userService.currentUser.fullName),
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        color: DarkModePlatformTheme.primaryDark2,
                        fontWeight: FontWeight.w800,
                        fontSize: 35,
                        wordSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          capitalize(userService.currentUser.fullName!),
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            color: DarkModePlatformTheme.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            wordSpacing: 1,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          companyNameRemover(
                              userService.currentUser.userName ?? ""),
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color:
                                DarkModePlatformTheme.white.withOpacity(0.75),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            wordSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (userService.currentUser.company != null)
                  HorizontalCard(
                    active: false,
                    subText: userService.currentUser.company!.companyCode!,
                    title: userService.currentUser.company!.name!,
                    icon: "assets/icons/bold/shop.svg",
                    titleSize: 18,
                    subTextSize: 16,
                  ),
                const SizedBox(
                  height: 8,
                ),
                IconHorizontalCard(
                  onClick: () {
                    showCupertinoModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      context: context,
                      enableDrag: true,
                      builder: (context) => const UserSettings(),
                    );
                  },
                  icon: "assets/icons/bold/settings.svg",
                  text: AppLocalizations.of(context)!.updateAccount,
                ),
                const SizedBox(
                  height: 8,
                ),
                if (userService.currentUser.userRole == "Manager")
                  IconHorizontalCard(
                    onClick: () {
                      Navigator.pushNamed(
                          context, EmployeeSetupScreen.routeName);
                    },
                    icon: "assets/icons/bold/employees.svg",
                    text: AppLocalizations.of(context)!.employees,
                  ),
                if (userService.currentUser.userRole == "Manager")
                  const SizedBox(
                    height: 8,
                  ),
                IconHorizontalCard(
                  onClick: () {
                    Navigator.pushNamed(context, LanguageScreen.routeName);
                  },
                  icon: "assets/icons/bold/lang.svg",
                  text: AppLocalizations.of(context)!.languages,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: MainButton(
              onClick: () {
                userService.logout();
                orderService.reset();
                summaryService.reset();
              },
              icon: "assets/icons/bold/logout.svg",
              title: AppLocalizations.of(context)!.logOut,
              color: DarkModePlatformTheme.fourthBlack,
              textColor: DarkModePlatformTheme.negativeLight3.withOpacity(0.75),
            ),
          ),
          const SizedBox(height: 96)
        ],
      ),
    );
  }
}
