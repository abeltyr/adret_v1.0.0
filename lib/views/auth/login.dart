import 'package:adret/model/input/index.dart';
import 'package:adret/model/userSettings/index.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool loading = false;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _companyController;
  late InputModel userInput;
  late InputModel passwordInput;
  late InputModel companyInput;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    var hiveUserSetting = Hive.box<UserSettingModel>('userSetting');
    UserSettingModel userSetting =
        hiveUserSetting.get("current", defaultValue: UserSettingModel())!;
    var companyId = userSetting.companyId;
    super.initState();
    _usernameController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _companyController = TextEditingController(text: companyId);

    userInput = InputModel(input: "");
    passwordInput = InputModel(input: "");
    companyInput = InputModel(input: companyId);
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _companyController.dispose();
  }

  void keyboardDown() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DarkModePlatformTheme.secondBlack,
        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SvgPicture.asset(
                                  "assets/icons/logo.svg",
                                  color: DarkModePlatformTheme.primary,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            AppLocalizations.of(context)!.welcomeMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              color: DarkModePlatformTheme.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 27,
                              wordSpacing: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            AppLocalizations.of(context)!.loginPrompt,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color:
                                  DarkModePlatformTheme.white.withOpacity(0.75),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              wordSpacing: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Input(
                              label: AppLocalizations.of(context)!.companyCode,
                              valueSetter: () {
                                return companyInput;
                              },
                              onChanged: (value) {
                                if (companyInput.errorStatus &&
                                    value.trim().isNotEmpty) {
                                  companyInput.errorStatus = false;
                                  companyInput.errorMessage = "";
                                  setState(() {});
                                }
                                companyInput.input = value;
                              },
                              icon: "assets/icons/shop.svg",
                              textInputAction: TextInputAction.next,
                              ratio1: 1,
                              ratio2: 11,
                              divider: true,
                              size: 20),
                          const SizedBox(
                            height: 12,
                          ),
                          Input(
                              label: AppLocalizations.of(context)!.username,
                              valueSetter: () {
                                return userInput;
                              },
                              onChanged: (value) {
                                if (userInput.errorStatus &&
                                    value.trim().isNotEmpty) {
                                  userInput.errorStatus = false;
                                  userInput.errorMessage = "";
                                  setState(() {});
                                }
                                userInput.input = value;
                              },
                              icon: "assets/icons/userSquare.svg",
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.none,
                              ratio1: 1,
                              ratio2: 11,
                              divider: true,
                              size: 20),
                          const SizedBox(
                            height: 12,
                          ),
                          Input(
                              label: AppLocalizations.of(context)!.password,
                              valueSetter: () {
                                return passwordInput;
                              },
                              onChanged: (value) {
                                if (passwordInput.errorStatus &&
                                    value.trim().isNotEmpty) {
                                  passwordInput.errorStatus = false;
                                  passwordInput.errorMessage = "";
                                  setState(() {});
                                }
                                passwordInput.input = value;
                              },
                              textInputType: TextInputType.visiblePassword,
                              icon: "assets/icons/key.svg",
                              ratio1: 1,
                              ratio2: 11,
                              divider: true,
                              size: 20),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: MainButton(
                    onClick: () async {
                      // if (product.addProductLoading) return;
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      var error = false;
                      if (companyInput.input == null ||
                          (companyInput.input != null &&
                              companyInput.input.toString().trim().isEmpty)) {
                        companyInput.errorMessage =
                            AppLocalizations.of(context)!.companyRequired;
                        companyInput.errorStatus = true;
                        error = true;
                      }
                      if (userInput.input == null ||
                          (userInput.input != null &&
                              userInput.input.toString().trim().isEmpty)) {
                        userInput.errorMessage =
                            AppLocalizations.of(context)!.usernameRequired;
                        userInput.errorStatus = true;
                        error = true;
                      }
                      if (passwordInput.input == null ||
                          (passwordInput.input != null &&
                              passwordInput.input.toString().trim().isEmpty)) {
                        passwordInput.errorMessage =
                            AppLocalizations.of(context)!.passwordRequired;
                        passwordInput.errorStatus = true;
                        error = true;
                      }
                      setState(() {});
                      if (error) return;

                      setState(() {
                        loading = true;
                      });

                      try {
                        await Provider.of<UserService>(
                          context,
                          listen: false,
                        ).login(
                          userName: userInput.input,
                          password: passwordInput.input,
                          companyId: companyInput.input,
                        );
                      } catch (e) {
                        // print("error fetched");
                        errorNotification(
                          context: context,
                          text: AppLocalizations.of(context)!.errorNotification,
                        );
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    color: DarkModePlatformTheme.primary,
                    textColor: DarkModePlatformTheme.primaryDark2,
                    borderRadiusData: 10,
                    textFontSize: 24,
                    title: AppLocalizations.of(context)!.signIn,
                    loading: loading,
                    icon: "assets/icons/login.svg",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ));
  }
}
