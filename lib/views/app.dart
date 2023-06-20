import 'package:adret/services/cart/index.dart';
import 'package:adret/services/checks.dart';
import 'package:adret/services/image/index.dart';
import 'package:adret/services/inventory/index.dart';
import 'package:adret/services/inventory/variation.dart';
import 'package:adret/services/orders/index.dart';
import 'package:adret/services/product/index.dart';
import 'package:adret/services/navbar.dart';
import 'package:adret/services/products/index.dart';
import 'package:adret/services/products/search.dart';
import 'package:adret/services/summary/index.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/views/index.dart';
import 'package:adret/views/shared/account/employeeSetup/index.dart';
import 'package:adret/views/shared/account/language/index.dart';
import 'package:adret/views/shared/checkout/index.dart';
import 'package:adret/views/shared/product/create.dart';
import 'package:adret/widgets/product/camera/index.dart';
import 'package:adret/views/shared/product/find.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:adret/localization/l10n.dart';
import 'package:adret/services/language.dart';
import 'package:adret/views/shared/error/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'shared/loading/index.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initialRoute = "/";
    final Map<String, Widget Function(BuildContext)> routes = {
      '/': (ctx) => const MainView(),
      CreateProduct.routeName: (ctx) => const CreateProduct(),
      CurrentProductView.routeName: (ctx) => const CurrentProductView(),
      LoadingScreen.routeName: (ctx) => const LoadingScreen(),
      ErrorScreen.routeName: (ctx) => const ErrorScreen(),
      CameraScreen.routeName: (ctx) => const CameraScreen(),
      CheckoutScreen.routeName: (ctx) => const CheckoutScreen(),
      EmployeeSetupScreen.routeName: (ctx) => const EmployeeSetupScreen(),
      LanguageScreen.routeName: (ctx) => const LanguageScreen(),
    };
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NavbarService(),
        ),
        ChangeNotifierProvider.value(
          value: LanguageService(),
        ),
        ChangeNotifierProvider.value(
          value: ProductService(),
        ),
        ChangeNotifierProvider.value(
          value: UserService(),
        ),
        ChangeNotifierProvider.value(
          value: CurrentProductService(),
        ),
        ChangeNotifierProvider.value(
          value: GetImageProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OrderService(),
        ),
        ChangeNotifierProvider.value(
          value: SummaryService(),
        ),
        ChangeNotifierProvider.value(
          value: CartService(),
        ),
        ChangeNotifierProvider.value(
          value: SearchProductService(),
        ),
        ChangeNotifierProvider.value(
          value: InventoryService(),
        ),
        ChangeNotifierProvider.value(
          value: VariationService(),
        ),
        ChangeNotifierProvider.value(
          value: CheckService(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: Hive.box('language').listenable(),
        builder: (context, box, widget) {
          var boxData = box;
          String? lang = boxData.get("current");
          var appLocal = const Locale('en');
          if (lang != null) appLocal = Locale(lang);
          return MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            locale: appLocal,
            supportedLocales: L10n.all,
            initialRoute: initialRoute,
            routes: routes,
            theme: ThemeData(fontFamily: 'Nunito'),
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const ErrorScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
