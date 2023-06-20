import 'package:adret/model/user/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/card/iconText/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeSummaryCard extends StatelessWidget {
  final String sales;
  final String profit;
  final UserModel? employee;
  final bool collected;
  final Function onClick;
  final String date;
  const EmployeeSummaryCard({
    super.key,
    required this.sales,
    required this.profit,
    required this.employee,
    required this.collected,
    required this.onClick,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final double salesData = double.tryParse(sales) ?? 0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: DarkModePlatformTheme.fourthBlack,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: IconTextCard(
                  title: AppLocalizations.of(context)!.date,
                  subTitle: DateFormat.MMMd().format(DateTime.parse(date)),
                  icon: "assets/icons/bold/calendar.svg",
                  titleFontSize: 16,
                  iconSize: 38,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: IconTextCard(
                  title: AppLocalizations.of(context)!.sales,
                  subTitle:
                      '${priceShow(sales)} ${AppLocalizations.of(context)!.etb}',
                  icon: "assets/icons/bold/receiptSecond.svg",
                  titleFontSize: 16,
                  iconSize: 38,
                  titleColor: salesData > 0
                      ? DarkModePlatformTheme.positiveLight2
                      : salesData == 0
                          ? DarkModePlatformTheme.grey4
                          : DarkModePlatformTheme.negativeLight3,
                  subTitleColor: salesData > 0
                      ? DarkModePlatformTheme.positiveLight3
                      : salesData == 0
                          ? DarkModePlatformTheme.grey5
                          : DarkModePlatformTheme.negativeLight3,
                  iconColor: salesData > 0
                      ? DarkModePlatformTheme.positiveLight3
                      : salesData == 0
                          ? DarkModePlatformTheme.grey5
                          : DarkModePlatformTheme.negativeLight3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
