import 'package:adret/model/input/index.dart';
import 'package:adret/services/user/actions/create_user.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/header/textHeader/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({
    super.key,
  });

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

final RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final RegExp phoneRegex = RegExp(r'(^(\+251([0-9]){9})$)');

class _AddEmployeeState extends State<AddEmployee> {
  late InputModel username;
  late InputModel fullName;
  late InputModel phoneNumber;
  late InputModel password;
  late InputModel confirmPassword;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    username = InputModel();
    fullName = InputModel();
    phoneNumber = InputModel();
    password = InputModel();
    confirmPassword = InputModel();
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);
    return Scaffold(
      backgroundColor: DarkModePlatformTheme.secondBlack,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: (Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextHeader(
              centerText: AppLocalizations.of(context)!.addEmployee,
              showActionText: false,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Input(
                        icon: "assets/icons/bold/userSquare.svg",
                        label: AppLocalizations.of(context)!.fullName,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        ratio1: 0.9,
                        ratio2: 11.1,
                        size: 22,
                        divider: true,
                        onChanged: ((p0) {
                          if (fullName.errorStatus && p0.length > 3) {
                            fullName.errorMessage = "";
                            fullName.errorStatus = false;
                            setState(() {});
                          }
                          fullName.input = p0;
                        }),
                        valueSetter: () {
                          return fullName;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Input(
                        icon: "assets/icons/bold/userOctagon.svg",
                        label: AppLocalizations.of(context)!.username,
                        ratio1: 0.9,
                        ratio2: 11.1,
                        size: 22,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        divider: true,
                        onChanged: ((p0) {
                          if (username.errorStatus && p0.trim().length > 3) {
                            username.errorMessage = "";
                            username.errorStatus = false;
                            setState(() {});
                          }
                          username.input = (p0);
                        }),
                        valueSetter: () {
                          return username;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Input(
                        icon: "assets/icons/bold/phone.svg",
                        label: AppLocalizations.of(context)!.phoneNumber,
                        textInputType: TextInputType.phone,
                        ratio1: 0.9,
                        ratio2: 11.1,
                        size: 22,
                        divider: true,
                        onChanged: ((p0) {
                          if (phoneNumber.errorStatus &&
                              phoneRegex.hasMatch(p0)) {
                            phoneNumber.errorMessage = "";
                            phoneNumber.errorStatus = false;
                            setState(() {});
                          }
                          phoneNumber.input = p0;
                        }),
                        valueSetter: () {
                          return phoneNumber;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Input(
                        icon: "assets/icons/bold/key.svg",
                        label: AppLocalizations.of(context)!.password,
                        textInputType: TextInputType.visiblePassword,
                        ratio1: 0.9,
                        ratio2: 11.1,
                        size: 22,
                        divider: true,
                        onChanged: ((p0) {
                          if (password.errorStatus && regex.hasMatch(p0)) {
                            password.errorMessage = "";
                            password.errorStatus = false;
                            setState(() {});
                          }
                          password.input = p0;
                        }),
                        valueSetter: () {
                          return password;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Input(
                        icon: "assets/icons/bold/key.svg",
                        label: AppLocalizations.of(context)!.confirmPassword,
                        textInputType: TextInputType.visiblePassword,
                        ratio1: 0.9,
                        ratio2: 11.1,
                        size: 22,
                        divider: true,
                        onChanged: ((p0) {
                          if (confirmPassword.errorStatus &&
                              password.input == p0) {
                            confirmPassword.errorMessage = "";
                            confirmPassword.errorStatus = false;
                            setState(() {});
                          }
                          confirmPassword.input = p0;
                        }),
                        valueSetter: () {
                          return confirmPassword;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: MainButton(
                loading: loading,
                borderRadiusData: 10,
                textFontSize: 22,
                onClick: () async {
                  setState(() {
                    loading = true;
                  });
                  bool error = false;

                  if (fullName.input == null || fullName.input.length <= 3) {
                    fullName.errorMessage =
                        AppLocalizations.of(context)!.shortName;
                    fullName.errorStatus = true;
                    error = true;
                  }

                  if (username.input == null ||
                      username.input.trim().length <= 3) {
                    username.errorMessage =
                        AppLocalizations.of(context)!.shortUserName;
                    username.errorStatus = true;
                    error = true;
                  }

                  if (phoneNumber.input == null ||
                      !phoneRegex.hasMatch(phoneNumber.input)) {
                    phoneNumber.errorMessage =
                        AppLocalizations.of(context)!.phoneNumberErrorMessage;
                    phoneNumber.errorStatus = true;
                    error = true;
                  }
                  if (password.input == null ||
                      password.input == null ||
                      !regex.hasMatch(password.input)) {
                    password.errorMessage =
                        AppLocalizations.of(context)!.passwordErrorMessage;
                    password.errorStatus = true;
                    error = true;
                  }

                  if (confirmPassword.input == null ||
                      password.input != confirmPassword.input) {
                    confirmPassword.errorMessage = AppLocalizations.of(context)!
                        .confirmPasswordErrorMessage;
                    confirmPassword.errorStatus = true;
                    error = true;
                  }

                  if (error) {
                    setState(() {
                      loading = false;
                    });
                    return;
                  }

                  try {
                    var user = await createUserFunction(
                      fullName: fullName.input,
                      password: password.input,
                      phoneNumber: phoneNumber.input,
                      userName: username.input.trim(),
                    );

                    if (user != null) {
                      userService.addUser(user);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } else {
                      throw Exception(
                        // ignore: use_build_context_synchronously
                        AppLocalizations.of(context)!.createUserError,
                      );
                    }
                  } catch (e) {
                    String errorMessage = "$e";
                    var errorSplit = e.toString().split("Exception: ");
                    if (errorSplit.length > 1) {
                      errorMessage = errorSplit[1];
                    }
                    errorNotification(
                      context: context,
                      text: errorMessage,
                    );
                  }

                  setState(() {
                    loading = false;
                  });
                },
                icon: "assets/icons/bold/addUser.svg",
                title: AppLocalizations.of(context)!.create,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
