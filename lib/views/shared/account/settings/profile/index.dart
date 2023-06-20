import 'package:adret/model/input/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateProfile extends StatelessWidget {
  final InputModel email;
  final Function(String) updateEmail;
  final InputModel fullName;
  final Function(String) updateFullName;
  final InputModel phoneNumber;
  final Function(String) updatePhoneNumber;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  const UpdateProfile({
    super.key,
    required this.email,
    required this.updateEmail,
    required this.fullName,
    required this.fullNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.updateFullName,
    required this.phoneNumber,
    required this.updatePhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
          height: 12,
        ),
        Input(
          icon: "assets/icons/bold/userSquare.svg",
          label: AppLocalizations.of(context)!.fullName,
          controller: fullNameController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.name,
          ratio1: 1,
          ratio2: 11,
          divider: true,
          size: '${Localizations.localeOf(context)}' == "en" ? 26 : 22,
          onChanged: ((p0) {
            updateFullName(p0);
          }),
          valueSetter: () {
            return fullName;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Input(
          icon: "assets/icons/bold/email.svg",
          label: AppLocalizations.of(context)!.emailAddress,
          ratio1: 1,
          controller: emailController,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          ratio2: 11,
          size: '${Localizations.localeOf(context)}' == "en" ? 26 : 22,
          divider: true,
          onChanged: ((p0) {
            updateEmail(p0);
          }),
          valueSetter: () {
            return email;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Input(
          icon: "assets/icons/bold/phone.svg",
          label: AppLocalizations.of(context)!.phoneNumber,
          controller: phoneNumberController,
          textInputType: TextInputType.phone,
          ratio1: 1,
          ratio2: 11,
          divider: true,
          size: '${Localizations.localeOf(context)}' == "en" ? 26 : 22,
          onChanged: ((p0) {
            updatePhoneNumber(p0);
          }),
          valueSetter: () {
            return phoneNumber;
          },
        ),
      ]),
    );
  }
}
