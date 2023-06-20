import 'package:adret/model/input/index.dart';
import 'package:adret/services/user/actions/update_password.dart';
import 'package:adret/services/user/actions/update_user.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/utils/notification/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/account/settings/password/index.dart';
import 'package:adret/views/shared/account/settings/profile/index.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/header/sliderHeader/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeSettings extends StatefulWidget {
  final int userIndex;
  const EmployeeSettings({
    super.key,
    required this.userIndex,
  });

  @override
  State<EmployeeSettings> createState() => _EmployeeSettingsState();
}

class _EmployeeSettingsState extends State<EmployeeSettings> {
  int index = 0;
  bool loading = false;

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late InputModel fullName;
  late InputModel phoneNumber;
  late InputModel email;
  late String username;
  late String id;
  late InputModel newPassword;
  late InputModel checkPassword;

  final RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final RegExp phoneRegex = RegExp(r'(^(\+251([0-9]){9})$)');

  @override
  void initState() {
    super.initState();
    final userService = Provider.of<UserService>(context, listen: false);

    var fullNameData = userService.users[widget.userIndex].fullName ?? "";
    var emailData = userService.users[widget.userIndex].email ?? "";
    var phoneNumberData = userService.users[widget.userIndex].phoneNumber ?? "";

    username = userService.users[widget.userIndex].userName ?? "";
    id = userService.users[widget.userIndex].id ?? "";
    fullName = InputModel(input: fullNameData);
    email = InputModel(input: emailData);
    phoneNumber = InputModel(input: phoneNumberData);
    _fullNameController = TextEditingController(text: fullNameData);
    _emailController = TextEditingController(text: emailData);
    _phoneNumberController = TextEditingController(text: phoneNumberData);
    checkPassword = InputModel(input: "");
    newPassword = InputModel(input: "");
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: DarkModePlatformTheme.secondBlack,
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 0, bottom: 10),
                width: 75,
                height: 5,
                decoration: BoxDecoration(
                  color: DarkModePlatformTheme.darkWhite,
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
            ),
            // TextHeader(
            //   centerText: "Employee ${fullName.input}",
            //   actionText: "done",
            //   showCloseText: false,
            //   showActionText: false,
            //   actionFunction: () {
            //     Navigator.pop(context);
            //   },
            // ),
            const SizedBox(
              height: 12,
            ),
            SliderHeader(
              index: index,
              updateIndex: (int value) {
                index = value;
                setState(() {});
              },
              icon: "assets/icons/bold/editData.svg",
              text: AppLocalizations.of(context)!.profile,
              icon1: "assets/icons/bold/key.svg",
              text1: AppLocalizations.of(context)!.password,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IndexedStack(
                  index: index,
                  children: [
                    UpdateProfile(
                      emailController: _emailController,
                      fullNameController: _fullNameController,
                      phoneNumberController: _phoneNumberController,
                      email: email,
                      fullName: fullName,
                      phoneNumber: phoneNumber,
                      updateEmail: (p0) {
                        if (email.errorStatus && emailRegex.hasMatch(p0)) {
                          email.errorMessage = "";
                          email.errorStatus = false;
                          setState(() {});
                        }
                        email.input = p0;
                      },
                      updatePhoneNumber: (p0) {
                        if (phoneNumber.errorStatus &&
                            phoneRegex.hasMatch(p0)) {
                          phoneNumber.errorMessage = "";
                          phoneNumber.errorStatus = false;
                          setState(() {});
                        }
                        phoneNumber.input = p0;
                      },
                      updateFullName: (p0) {
                        if (fullName.errorStatus && p0.length > 3) {
                          fullName.errorMessage = "";
                          fullName.errorStatus = false;
                          setState(() {});
                        }
                        fullName.input = p0;
                      },
                    ),
                    UpdatePassword(
                      newPassword: newPassword,
                      checkPassword: checkPassword,
                      updateNewPassword: (p0) {
                        if (newPassword.errorStatus && regex.hasMatch(p0)) {
                          newPassword.errorMessage = "";
                          newPassword.errorStatus = false;
                          setState(() {});
                        }
                        newPassword.input = p0;
                      },
                      updateCheckPassword: (p0) {
                        if (checkPassword.errorStatus &&
                            newPassword.input == p0) {
                          checkPassword.errorMessage = "";
                          checkPassword.errorStatus = false;
                          setState(() {});
                        }
                        checkPassword.input = p0;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: index == 0
                    ? MainButton(
                        loading: loading,
                        borderRadiusData: 10,
                        textFontSize: 22,
                        onClick: () async {
                          setState(() {
                            loading = true;
                          });
                          bool error = false;

                          if (fullName.input == null &&
                              fullName.input.length < 3) {
                            fullName.errorMessage =
                                AppLocalizations.of(context)!.shortName;
                            fullName.errorStatus = true;
                            error = true;
                          }

                          if (userService.currentUser.email != null &&
                              !emailRegex.hasMatch(email.input)) {
                            email.errorMessage =
                                AppLocalizations.of(context)!.emailErrorMessage;
                            email.errorStatus = true;
                            error = true;
                          }

                          if (userService.currentUser.phoneNumber != null &&
                              !phoneRegex.hasMatch(phoneNumber.input)) {
                            phoneNumber.errorMessage =
                                AppLocalizations.of(context)!
                                    .phoneNumberErrorMessage;
                            phoneNumber.errorStatus = true;
                            error = true;
                          }

                          if (error) {
                            setState(() {
                              loading = false;
                            });
                            return;
                          }

                          try {
                            var employee = await updateUserFunction(
                              fullName: fullName.input,
                              email: email.input,
                              phoneNumber: phoneNumber.input,
                              id: id,
                            );

                            if (employee != null) {
                              // ignore: use_build_context_synchronously
                              successNotification(
                                context: context,
                                // ignore: use_build_context_synchronously
                                text: AppLocalizations.of(context)!
                                    .profileUpdateMessage,
                              );
                              userService.updateUserList(
                                  user: employee, index: widget.userIndex);
                            } else {
                              throw Exception("Error updating Employee detail");
                            }
                          } catch (e) {
                            String errorMessage = "$e";
                            var errorSplit = e.toString().split("Exception: ");
                            if (errorSplit.length > 1 &&
                                errorSplit[1].isNotEmpty) {
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
                        icon: "assets/icons/bold/penEdit.svg",
                        title: AppLocalizations.of(context)!.update,
                      )
                    : MainButton(
                        loading: loading,
                        borderRadiusData: 10,
                        textFontSize: 22,
                        onClick: () async {
                          setState(() {
                            loading = true;
                          });
                          bool error = false;

                          if (newPassword.input == null ||
                              !regex.hasMatch(newPassword.input)) {
                            newPassword.errorMessage =
                                AppLocalizations.of(context)!
                                    .passwordErrorMessage;
                            newPassword.errorStatus = true;
                            error = true;
                          }
                          if (newPassword.input != checkPassword.input) {
                            checkPassword.errorMessage =
                                AppLocalizations.of(context)!
                                    .confirmPasswordErrorMessage;
                            checkPassword.errorStatus = true;
                            error = true;
                          }

                          if (error) {
                            setState(() {
                              loading = false;
                            });
                            return;
                          }

                          try {
                            await updatePasswordFunction(
                              password: newPassword.input,
                              username: username,
                            );
                            // ignore: use_build_context_synchronously
                            successNotification(
                              context: context,
                              // ignore: use_build_context_synchronously
                              text: AppLocalizations.of(context)!
                                  .passwordUpdateMessage,
                            );
                          } catch (e) {
                            String errorMessage =
                                "Error updating user password!";
                            errorNotification(
                              context: context,
                              text: errorMessage,
                            );
                          }

                          setState(() {
                            loading = false;
                          });
                        },
                        icon: "assets/icons/bold/keySquare.svg",
                        title: AppLocalizations.of(context)!.update,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
