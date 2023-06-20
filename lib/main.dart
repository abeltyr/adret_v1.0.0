import 'package:adret/model/company/index.dart';
import 'package:adret/model/inventoryInput/index.dart';
import 'package:adret/model/inventoryInputTitle/index.dart';
import 'package:adret/model/input/index.dart';
import 'package:adret/model/product/index.dart';
import 'package:adret/model/productVariation/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:adret/model/sales/index.dart';
import 'package:adret/model/user/index.dart';
import 'package:adret/model/userSettings/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'views/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");
  await Hive.openBox('language');
  await Hive.openBox('navbar');
  await Hive.openBox('companyCategory');
  await Hive.openBox('userRole');

  Hive.registerAdapter((UserSettingModelAdapter()));
  await Hive.openBox<UserSettingModel>('userSetting');

  Hive.registerAdapter((CompanyModelAdapter()));
  await Hive.openBox<CompanyModel>('company');

  Hive.registerAdapter((UserModelAdapter()));
  await Hive.openBox<UserModel>('user');

  Hive.registerAdapter((ProductModelAdapter()));
  await Hive.openBox<ProductModel>('products');

  Hive.registerAdapter((SalesModelAdapter()));
  await Hive.openBox<SalesModel>('sales');

  Hive.registerAdapter((ProductViewModelAdapter()));
  Hive.registerAdapter((InputModelAdapter()));
  Hive.registerAdapter((InventoryInputTitleModelAdapter()));
  Hive.registerAdapter((InventoryInputModelAdapter()));
  Hive.registerAdapter((MediaViewModelAdapter()));
  await Hive.openBox<ProductViewModel>('productView');

  Hive.registerAdapter((ProductVariationModelAdapter()));
  Hive.registerAdapter((ProductVariationListModelAdapter()));
  await Hive.openBox<ProductVariationListModel>('productVariations');

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const MyApp(),
  );
}
