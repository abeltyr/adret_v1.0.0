import 'package:adret/services/checks.dart';
import 'package:adret/views/auth/login.dart';
import 'package:adret/views/manger/index.dart';
import 'package:adret/views/shared/loading/index.dart';
import 'package:adret/views/shared/transition/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'employee/index.dart';

class MainView extends StatefulWidget {
  static const routeName = '/';
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    if (mounted) {
      var checkService = Provider.of<CheckService>(context, listen: false);
      await checkService.checkConnection();
      FlutterNativeSplash.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    var checkService = Provider.of<CheckService>(context, listen: true);

    if (checkService.loadingScreen) {
      return const LoadingScreen();
    }
    if (checkService.connectionIssue) {
      return TransitionScreen(
        action: () async {
          checkService.updateLoadingScreen(true);
          await checkService.checkConnection();
          checkService.updateLoadingScreen(false);
        },
        actionText: AppLocalizations.of(context)!.reconnect,
        actionIcon: "assets/icons/refresh.svg",
        animation: "assets/animations/noConnection.json",
        topText: AppLocalizations.of(context)!.internetIssue,
        subText: AppLocalizations.of(context)!.networkErrorPrompt,
        icon: null,
        details:  [
          AppLocalizations.of(context)!.turnOnData
        ],
      );
    }
    return CupertinoScaffold(
      // backgroundColor: DarkModePlatformTheme.primaryDark,
      body: ValueListenableBuilder(
        valueListenable: Hive.box('userRole').listenable(),
        builder: (context, box, widget) {
          var boxData = box;
          String? userRole = boxData.get("current", defaultValue: null);
          if (userRole != null) {
            if (userRole == "Manager") {
              return const MangerView();
            } else {
              return const EmployeeView();
            }
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
