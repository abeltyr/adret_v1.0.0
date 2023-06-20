import 'package:adret/model/input/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdatePassword extends StatelessWidget {
  final InputModel? oldPassword;
  final Function(String)? updateOldPassword;
  final InputModel newPassword;
  final Function(String) updateNewPassword;
  final InputModel checkPassword;
  final Function(String) updateCheckPassword;
  const UpdatePassword({
    super.key,
    this.oldPassword,
    this.updateOldPassword,
    required this.newPassword,
    required this.updateNewPassword,
    required this.checkPassword,
    required this.updateCheckPassword,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
          height: 12,
        ),
        if (updateOldPassword != null && oldPassword != null)
          Input(
            icon: "assets/icons/bold/key.svg",
            label: AppLocalizations.of(context)!.oldPassword,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            ratio1: 1,
            ratio2: 11,
            size: '${Localizations.localeOf(context)}' == "en" ? 26 : 22,
            divider: true,
            onChanged: ((p0) {
              updateOldPassword!(p0);
            }),
            valueSetter: () {
              return oldPassword;
            },
          ),
        if (updateOldPassword != null && oldPassword != null)
          const SizedBox(
            height: 16,
          ),
        Input(
          icon: "assets/icons/bold/keySquare.svg",
          label: AppLocalizations.of(context)!.newPassword,
          textInputType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          ratio1: 1,
          ratio2: 11,
          size: '${Localizations.localeOf(context)}' == "en" ? 26 : 22,
          divider: true,
          onChanged: ((p0) {
            updateNewPassword(p0);
          }),
          valueSetter: () {
            return newPassword;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Input(
          icon: "assets/icons/bold/keySquare.svg",
          label: AppLocalizations.of(context)!.reEnterPassword,
          textInputType: TextInputType.visiblePassword,
          ratio1: 1,
          ratio2: 11,
          divider: true,
          size: '${Localizations.localeOf(context)}' == "en" ? 26 : 22,
          onChanged: ((p0) {
            updateCheckPassword(p0);
          }),
          valueSetter: () {
            return checkPassword;
          },
        ),
      ]),
    );
  }
}
